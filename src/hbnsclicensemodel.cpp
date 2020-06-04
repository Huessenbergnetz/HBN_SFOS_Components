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

#include "hbnsclicensemodel.h"
#include "hbnsc.h"
#include <algorithm>
#ifdef HBNSC_WITH_OPENSSL
#include <openssl/opensslv.h>
#endif
#ifdef HBNSC_WITH_SQLITE
#include <sqlite3.h>
#endif
#ifdef HBNSC_WITH_DBUS
#include <dbus/dbus.h>
#endif

using namespace Hbnsc;

struct LicenseModel::Item {
    QString name;
    QString author;
    QString version;
    QString description;
    QString license;
    QString licenseFile;
    QUrl website;
    QUrl customLicenseFile;
    QUrl licenseWebsite;

    Item() = default;

    Item(const QString &_name, const QString &_author, const QString &_version, const QUrl &_website, const QString &_desc, const QString &_license, const QString &_licenseFile, const QUrl &_licenseWebsite, const QUrl &_customLicenseFile) :
        name(_name), author(_author), version(_version), description(_desc), license(_license), licenseFile(_licenseFile), website(_website), customLicenseFile(_customLicenseFile), licenseWebsite(_licenseWebsite)
    {

    }

    Item(const Item &other) = default;

//    Item(Item &&other) :
//        name(std::move(other.name)), author(std::move(other.author)), version(std::move(other.version)), description(std::move(other.description)), license(std::move(other.license)), licenseFile(std::move(other.licenseFile)), website(std::move(other.website)), customLicenseFile(std::move(other.customLicenseFile)), licenseWebsite(std::move(other.licenseWebsite))
//    {

//    }
    Item(Item &&other) = default;

    Item& operator=(const Item &other) = default;

    Item& operator=(Item &&other) = default;
};

LicenseModel::LicenseModel(QObject *parent) : QAbstractListModel(parent)
{
    m_items.emplace_back(
                QStringLiteral("Qt"),
                QStringLiteral("The Qt Company"),
                QStringLiteral(QT_VERSION_STR),
                QUrl(QStringLiteral("https://www.qt.io")),
                QString(),
                QStringLiteral("GNU Lesser General Public License, Version 3"),
                QStringLiteral("LGPLv3.qml"),
                QUrl(QStringLiteral("https://www.qt.io/licensing/")),
                QUrl()
                );

    m_items.emplace_back(
                QStringLiteral("libsailfishapp"),
                QStringLiteral("Jolla Ltd."),
                QString(),
                QUrl(QStringLiteral("https://sailfishos.org/develop/docs/libsailfishapp/")),
                QString(),
                QStringLiteral("GNU Lesser General Public License, Version 2.1"),
                QStringLiteral("LGPLv2_1.qml"),
                QUrl(),
                QUrl()
                );

    m_items.emplace_back(
                QStringLiteral("Sailfish Silica UI"),
                QStringLiteral("Jolla Ltd."),
                QString(),
                QUrl(QStringLiteral("https://sailfishos.org/develop/docs/silica/")),
                QString(),
                QStringLiteral("Modified BSD License"),
                QStringLiteral("BSD-3.qml"),
                QUrl(),
                QUrl()
                );

    m_items.emplace_back(
                QStringLiteral("HBN SFOS Components"),
                QStringLiteral("Matthias Fehring"),
                Hbnsc::version().toString(),
                QUrl(QStringLiteral("https://github.com/Huessenbergnetz/HBN_SFOS_Components")),
                //: Description for the HBN SFOS Components in the list of used 3rd party components.
                //% "HBN SFOS Components are a set of reusable C++ and QML components for Sailfish OS like the About page."
                qtTrId("hbnsc-components-desc"),
                QStringLiteral("Modified BSD License"),
                QStringLiteral("BSD-3.qml"),
                QUrl(QStringLiteral("https://github.com/Huessenbergnetz/HBN_SFOS_Components/blob/master/LICENSE")),
                QUrl()
                );

    m_items.emplace_back(
                QStringLiteral("HBN SFOS Components Translations"),
                QStringLiteral("HBN SFOS Components Translators"),
                Hbnsc::version().toString(),
                QUrl(QStringLiteral("https://www.transifex.com/huessenbergnetz/hbn-sfos-components/")),
                //: Description for the HBN SFOS Components translations in the list of used 3rd party components.
                //% "HBN SFOS Components are a set of reusable C++ and QML components for Sailfish OS like the About page. The translations are provided by the community."
                qtTrId("hbnsc-components-trans-desc"),
                QStringLiteral("Creative Commons Attribution 4.0 International Public License"),
                QStringLiteral("CC-BY-4_0.qml"),
                QUrl(QStringLiteral("https://github.com/Huessenbergnetz/HBN_SFOS_Components/blob/master/LICENSE.translations")),
                QUrl()
                );

#ifdef HBNSC_WITH_OPENSSL
    m_items.emplace_back(
                QStringLiteral("OpenSSL"),
                QStringLiteral("OpenSSL Development Team"),
                QStringLiteral(SHLIB_VERSION_NUMBER),
                QUrl(QStringLiteral("https://www.openssl.org")),
                QString(),
                QStringLiteral("OpenSSL & SSLeay License"),
                QStringLiteral("OpenSSL.qml"),
                QUrl(QStringLiteral("https://www.openssl.org/source/license.html")),
                QUrl()
                );
#endif

#ifdef HBNSC_WITH_NEMONOTIFY
    m_items.emplace_back(
                QStringLiteral("nemonotifications"),
                QStringLiteral("Jolla Ltd."),
                QString(),
                QUrl(QStringLiteral("https://sailfishos.org/develop/docs/nemo-qml-plugin-notifications/notification.html/")),
                QString(),
                QStringLiteral("Modified BSD License"),
                QStringLiteral("BSD-3.qml"),
                QUrl(),
                QUrl()
                );
#endif

#ifdef HBNSC_WITH_SQLITE
    m_items.emplace_back(
                QStringLiteral("SQLite"),
                QStringLiteral("SQLite Team"),
                QStringLiteral(SQLITE_VERSION),
                QUrl(QStringLiteral("https://www.sqlite.org")),
                QString(),
                QStringLiteral("Public Domain"),
                QStringLiteral("SQLite.qml"),
                QUrl(QStringLiteral("https://www.sqlite.org/copyright.html")),
                QUrl()
                );
#endif

#ifdef HBNSC_WITH_DBUS
    int dbus_maj_ver = 0;
    int dbus_min_ver = 0;
    int dbus_mic_ver = 0;
    dbus_get_version(&dbus_maj_ver, &dbus_min_ver, &dbus_mic_ver);
    QVersionNumber dbusVersion(dbus_maj_ver, dbus_min_ver, dbus_mic_ver);
    m_items.emplace_back(
                QStringLiteral("libdbus-1"),
                QStringLiteral("D-Bus-Team"),
                dbusVersion.toString(),
                QUrl(QStringLiteral("http://freedesktop.org/wiki/Software/dbus")),
                QString(),
                QStringLiteral("GNU General Public License, Version 2"),
                QStringLiteral("GPLv2.qml"),
                QUrl(QStringLiteral("https://gitlab.freedesktop.org/dbus/dbus/blob/master/COPYING")),
                QUrl()
                );
#endif
}

LicenseModel::~LicenseModel()
{

}

QHash<int, QByteArray> LicenseModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractItemModel::roleNames();
    roles.insert(Name, QByteArrayLiteral("name"));
    roles.insert(Author, QByteArrayLiteral("author"));
    roles.insert(Version, QByteArrayLiteral("version"));
    roles.insert(Description, QByteArrayLiteral("description"));
    roles.insert(Website, QByteArrayLiteral("website"));
    roles.insert(License, QByteArrayLiteral("license"));
    roles.insert(LicenseFile, QByteArrayLiteral("licenseFile"));
    roles.insert(CustomLicenseFile, QByteArrayLiteral("customLicenseFile"));
    roles.insert(LicenseWebsite, QByteArrayLiteral("licenseWebsite"));
    return roles;
}

int LicenseModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_items.size();
}

QModelIndex LicenseModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent)) {
        return QModelIndex();
    }

    return createIndex(row, column);
}

QVariant LicenseModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() > (rowCount()-1)) {
        return QVariant();
    }

    const LicenseModel::Item i = m_items.at(index.row());

    switch (role) {
    case Name:
        return QVariant::fromValue(i.name);
    case Author:
        return QVariant::fromValue(i.author);
    case Version:
        return QVariant::fromValue(i.version);
    case Description:
        return QVariant::fromValue(i.description);
    case Website:
        return QVariant::fromValue(i.website);
    case License:
        return QVariant::fromValue(i.license);
    case LicenseFile:
        return QVariant::fromValue(i.licenseFile);
    case CustomLicenseFile:
        return QVariant::fromValue(i.customLicenseFile);
    case LicenseWebsite:
        return QVariant::fromValue(i.licenseWebsite);
    default:
        return QVariant();
    }
}

void LicenseModel::add(const QString &name, const QString &author, const QString &version, const QUrl &website, const QString &description, const QString &license, const QString &licenseFile, const QUrl &licenseWebsite, const QUrl &customLicenseFile)
{
    m_items.emplace_back(name, author, version, website, description, license, licenseFile, licenseWebsite, customLicenseFile);
}

void LicenseModel::sortLicenses()
{
    std::sort(m_items.begin(), m_items.end(), [](const Item &a, const Item &b){
        return QString::localeAwareCompare(a.name, b.name) < 0;
    });
}

#include "moc_hbnsclicensemodel.cpp"
