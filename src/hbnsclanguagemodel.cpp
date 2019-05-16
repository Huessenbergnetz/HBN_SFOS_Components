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

* Neither the name of BT_SFOS_Components nor the names of its
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
#include <algorithm>

using namespace Hbnsc;

struct LanguageModel::Language {
    QString code;
    QString name;

    Language(const QString &_code, const QString &_name) :
        code(std::move(_code)), name(std::move(_name))
    {

    }

    Language(const Language &other) = default;

    Language(Language &&other) :
        code(std::move(other.code)), name(std::move(other.name))
    {

    }

    Language& operator=(const Language &other) = default;
};

LanguageModel::LanguageModel(const QStringList &supportedLangs, QObject *parent) :
    QAbstractListModel(parent)
{
    m_langs.reserve(supportedLangs.size() + 1);

    if (!supportedLangs.empty()) {
        for (const QString &lang : supportedLangs) {
            QLocale locale(lang);
            const QString name = locale.nativeLanguageName() % QStringLiteral(" (") % QLocale::languageToString(locale.language()) % QLatin1Char(')');
            m_langs.emplace_back(lang, name);
        }

        std::sort(m_langs.begin(), m_langs.end(), [](const Language &a, const Language &b){
            return QString::localeAwareCompare(a.name, b.name) < 0;
        });
    }

    QString syslang;
    for (const QString &lang : QLocale::system().uiLanguages()) {
        if (supportedLangs.contains(lang)) {
            syslang = lang;
            break;
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

    const Language l = m_langs.at(index.row());

    switch(role) {
    case Code:
        return QVariant::fromValue(l.code);
    case Name:
        return QVariant::fromValue(l.name);
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
        if (m_langs.at(i).code == langCode) {
            idx = i;
            break;
        }
    }

    return idx;
}
