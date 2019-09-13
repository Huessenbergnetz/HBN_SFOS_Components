/*
Copyright (c) 2015-2019, Hüssenbergnetz/Matthias Fehring
https://github.com/Huessenbergnetz/HBN_SFOS_Components
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of HBN_SFOS_Components nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "hbnsclanguagemodel.h"
#include <QLocale>
#include <QStringBuilder>
#include <QDir>
#include <QFileInfo>
#include <algorithm>
#ifndef CLAZY
#include <sailfishapp.h>
#endif

using namespace Hbnsc;

LanguageModel::LanguageModel(const QStringList &supportedLangs, QObject *parent) :
    QAbstractListModel(parent)
{
    populate(supportedLangs);
}

LanguageModel::LanguageModel(const QString &transDir, const QString &transName, QObject *parent) :
    QAbstractListModel(parent)
{
#ifndef CLAZY
    const QString _transDir = transDir.startsWith(QLatin1Char('/')) ? transDir : SailfishApp::pathTo(transDir).toString(QUrl::RemoveScheme);
#else
    const QString _transDir = transDir;
#endif

    const QDir dir(_transDir);
    const QString searchGlob = transName % QStringLiteral("*.qm");
    const QFileInfoList files = dir.entryInfoList(QStringList(searchGlob), QDir::Files);
    const int suffixIdx = transName.size() - 1;
    QStringList supportedLangs;
    supportedLangs.reserve(files.size());
    for (const QFileInfo &file : files) {
        const QString base = file.baseName();
        const QString lc = base.right(base.size() - suffixIdx - 1);
        qDebug("Adding \"%s\" to the list of supported translations.", qUtf8Printable(lc));
        supportedLangs << lc;
    }
    populate(supportedLangs);
}

LanguageModel::~LanguageModel()
{

}

QHash<int, QByteArray> LanguageModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles.insert(Code, QByteArrayLiteral("code"));
    roles.insert(Name, QByteArrayLiteral("name"));
    return roles;
}

int LanguageModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_langs.size();
}

QModelIndex LanguageModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent)) {
        return QModelIndex();
    }

    return createIndex(row, column);
}

QVariant LanguageModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() > (rowCount() - 1)) {
        return QVariant();
    }

    const std::pair<QString,QString> l = m_langs.at(index.row());

    switch(role) {
    case Code:
        return QVariant::fromValue(l.first);
    case Name:
        return QVariant::fromValue(l.second);
    default:
        return QVariant();
    }
}

int LanguageModel::findIndex(const QString &langCode) const
{
    if (rowCount() == 0) {
        return -1;
    }

    int idx = -1;
    int size = static_cast<int>(m_langs.size());
    for (int i = 0; i < size; ++i) {
        if (m_langs.at(i).first == langCode) {
            idx = i;
            break;
        }
    }

    return idx;
}

void LanguageModel::populate(const QStringList &supportedLangs)
{
    m_langs.reserve(supportedLangs.size() + 1);

    if (!supportedLangs.empty()) {
        for (const QString &lang : supportedLangs) {
            QLocale locale(lang);
            const QString name = locale.nativeLanguageName() % QStringLiteral(" (") % QLocale::languageToString(locale.language()) % QLatin1Char(')');
            m_langs.emplace_back(lang, name);
        }

        std::sort(m_langs.begin(), m_langs.end(), [](const std::pair<QString,QString> &a, const std::pair<QString,QString> &b){
            return QString::localeAwareCompare(a.second, b.second) < 0;
        });
    }

    QString syslang;
    const QStringList uiLangs = QLocale::system().uiLanguages();
    for (const QString &lang : uiLangs) {
        if (supportedLangs.contains(lang)) {
            syslang = lang;
            break;
        }
    }

    if (syslang.isEmpty()) {
        for (const QString &lang : uiLangs) {
            const int underScoreIdx = lang.indexOf(QLatin1Char('-'));
            if (underScoreIdx > 0) {
                const QString langPart = lang.left(underScoreIdx);
                if (supportedLangs.contains(langPart)) {
                    syslang = langPart;
                    break;
                }
            }
        }
    }

    if (syslang.isEmpty()) {
        syslang = QStringLiteral("en");
    }

    QLocale locale(syslang);

    //: Means the default language of the system
    //% "Default"
    const QString defName = qtTrId("hbnsc-default-locale") % QStringLiteral(" (") % locale.nativeLanguageName() % QLatin1Char(')');
    m_langs.emplace(m_langs.begin(), QString(), defName);
}


#include "moc_hbnsclanguagemodel.cpp"
