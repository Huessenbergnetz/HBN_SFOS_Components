HBNSC_VER_MAJ = 1
HBNSC_VER_MIN = 4
HBNSC_VER_PAT = 3

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
    $$PWD/src/hbnsclicensemodel.cpp \
    $$PWD/src/hbnsclanguagemodel.cpp

OTHER_FILES += \
    $$PWD/qml/InfoHint.qml \
    $$PWD/qml/IconWithHint.qml \
    $$PWD/qml/Contributors.qml \
    $$PWD/qml/Changelog.qml \
    $$PWD/qml/AboutPage.qml \
    $$PWD/qml/PaypalChooser.qml \
    $$PWD/qml/ChangelogDelegate.qml \
    $$PWD/qml/ContributorsDelegate.qml \
    $$PWD/qml/LicenseDelegate.qml \
    $$PWD/qml/licenses/LicenseBase.qml \
    $$PWD/qml/licenses/LGPLv3.qml \
    $$PWD/qml/licenses/BSD-3.qml \
    $$PWD/qml/licenses/GPLv3.qml \
    $$PWD/qml/licenses/CC-BY-4_0.qml \
    $$PWD/qml/licenses/GPLv2.qml \
    $$PWD/qml/licenses/Apache-2_0.qml \
    $$PWD/qml/licenses/LGPLv2_1.qml \
    $$PWD/qml/licenses/SIL-OFL-1_1.qml \
    $$PWD/qml/licenses/SQLite.qml \
    $$PWD/qml/licenses/OpenSSL.qml \
    $$PWD/qml/licenses/zlib.qml \
    $$PWD/qmldir.in

INCLUDEPATH += $$PWD/src

!contains(CONFIG, clazy) {
    PKGCONFIG *= sailfishsilica
}

hbnscLicenses.path = $$HBNSC_INSTALL_QML_DIR/licenses

isEmpty(HBNSC_LICENSES) {
    hbnscLicenses.files = $$PWD/qml/licenses/*.qml
} else {
    hbnscLicenses.files = $$PWD/qml/licenses/LicenseBase.qml

    for(l, HBNSC_LICENSES) {
        exists($$PWD/qml/licenses/$${l}.qml) {
            hbnscLicenses.files += $$PWD/qml/licenses/$${l}.qml
        }
    }
}

hbnscQml.path = $$HBNSC_INSTALL_QML_DIR
hbnscQml.files = $$PWD/qml/*.qml

hbnscIcons.path = $$HBNSC_INSTALL_ICONS_DIR
hbnscIcons.files = $$PWD/images/z*

hbnscTranslations.path = $$INSTALL_TRANSLATIONS_DIR
hbnscTranslations.files = $$PWD/translations/*.qm

hbnscQmlDir.path = $$HBNSC_INSTALL_QML_DIR
hbnscQmlDir.files = $$PWD/qml/qmldir

INSTALLS += hbnscQml hbnscQmlDir hbnscIcons hbnscTranslations hbnscLicenses
