HBNSC_VER_MAJ = 1
HBNSC_VER_MIN = 6
HBNSC_VER_PAT = 0

HBNSC_INSTALL_QML_DIR = /usr/share/$$TARGET/de/huessenbergnetz/hbnsc
isEmpty(HBNSC_INSTALL_ICONS_DIR): HBNSC_INSTALL_ICONS_DIR = $$HBNSC_INSTALL_QML_DIR/icons
isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/$$TARGET/translations

DEFINES += HBNSC_ICONS_DIR=\"\\\"$${HBNSC_INSTALL_ICONS_DIR}/\\\"\"
DEFINES += HBNSC_VERSION=\"\\\"$${HBNSC_VER_MAJ}.$${HBNSC_VER_MIN}.$${HBNSC_VER_PAT}\\\"\"
DEFINES += HBNSC_L10N_DIR=\"\\\"$${INSTALL_TRANSLATIONS_DIR}\\\"\"

HEADERS += \
    $$PWD/src/hbnsc.h \
    $$PWD/src/hbnsciconprovider.h \
    $$PWD/src/hbnsclicensemodel.h \
    $$PWD/src/hbnsclanguagemodel.h

SOURCES += \
    $$PWD/src/hbnsciconprovider.cpp \
    $$PWD/src/hbnsclicensemodel.cpp \
    $$PWD/src/hbnsclanguagemodel.cpp \
    $$PWD/src/hbnsc.cpp

OTHER_FILES += \
    $$PWD/qml/de/huessenbergnetz/hbnsc/InfoHint.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/IconWithHint.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/Contributors.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/Changelog.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/AboutPage.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/PaypalChooser.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/LanguagePicker.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/ChangelogDelegate.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/ContributorsDelegate.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/LicenseDelegate.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/LicenseBase.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/LGPLv3.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/BSD-3.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/GPLv3.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/CC-BY-3_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/CC-BY-4_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/CC-BY-NC-SA-4_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/CC0-1_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/CC-SP-1_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/GPLv2.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/Apache-2_0.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/LGPLv2_1.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/SIL-OFL-1_1.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/SQLite.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/OpenSSL.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/zlib.qml \
    $$PWD/qml/de/huessenbergnetz/hbnsc/qmldir

QML_IMPORT_PATH += $$PWD/qml

INCLUDEPATH += $$PWD/src

PKGCONFIG *= sailfishsilica
INCLUDEPATH *= /usr/include/libsailfishsilica

contains(PKGCONFIG, openssl) {
    DEFINES += HBNSC_WITH_OPENSSL
}

contains(PKGCONFIG, nemonotifications-qt5) {
    DEFINES += HBNSC_WITH_NEMONOTIFY
}

contains(QT, sql) {
    DEFINES += HBNSC_WITH_SQLITE
}

contains(QT, dbus) {
    DEFINES += HBNSC_WITH_DBUS
    PKGCONFIG *= dbus-1
    INCLUDEPATH *= /usr/include/dbus-1.0
}

CONFIG *= c++11
CONFIG *= c++14

hbnscLicenses.path = $$HBNSC_INSTALL_QML_DIR/licenses

isEmpty(HBNSC_LICENSES) {
    hbnscLicenses.files = $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/*.qml
} else {
    hbnscLicenses.files = $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/LicenseBase.qml

    for(l, HBNSC_LICENSES) {
        exists($$PWD/qml/licenses/$${l}.qml) {
            hbnscLicenses.files += $$PWD/qml/de/huessenbergnetz/hbnsc/licenses/$${l}.qml
        }
    }
}

hbnscQml.path = $$HBNSC_INSTALL_QML_DIR
hbnscQml.files = $$PWD/qml/de/huessenbergnetz/hbnsc/*.qml

hbnscIcons.path = $$HBNSC_INSTALL_ICONS_DIR
hbnscIcons.files = $$PWD/images/z*

hbnscTranslations.path = $$INSTALL_TRANSLATIONS_DIR
hbnscTranslations.files = $$PWD/translations/*.qm

hbnscQmlDir.path = $$HBNSC_INSTALL_QML_DIR
hbnscQmlDir.files = $$PWD/qml/de/huessenbergnetz/hbnsc/qmldir

INSTALLS += hbnscQml hbnscQmlDir hbnscIcons hbnscTranslations hbnscLicenses
