BTSC_INSTALL_QML_DIR = /usr/share/$$TARGET/de/huessenbergnetz/btsc
isEmpty(BTSC_INSTALL_ICONS_DIR): BTSC_INSTALL_ICONS_DIR = $$BTSC_INSTALL_QML_DIR/icons
isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/$$TARGET/translations

DEFINES += BTSC_ICONS_DIR=\"\\\"$${BTSC_INSTALL_ICONS_DIR}/\\\"\"

HEADERS += \
    $$PWD/src/btsciconprovider.h

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
    $$PWD/qml/licenses/SIL-OFL-1_1.qml
    $$PWD/qmldir.in

INCLUDEPATH += $$PWD/src

btscLicenses.path = $$BTSC_INSTALL_QML_DIR/licenses

isEmpty(BTSC_LICENSES) {
    btscLicenses.files = $$PWD/qml/licenses/*.qml
} else {
    btscLicenses.files = $$PWD/qml/licenses/LicenseBase.qml

    for(l, BTSC_LICENSES) {
        exists($$PWD/qml/licenses/$${l}.qml) {
            btscLicenses.files += $$PWD/qml/licenses/$${l}.qml
        }
    }
}

btscQml.path = $$BTSC_INSTALL_QML_DIR
btscQml.files = $$PWD/qml/*.qml

btscIcons.path = $$BTSC_INSTALL_ICONS_DIR
btscIcons.files = $$PWD/images/z*

btscTranslations.path = $$INSTALL_TRANSLATIONS_DIR
btscTranslations.files = $$PWD/translations/*.qm

btscQmlDir.path = $$BTSC_INSTALL_QML_DIR
btscQmlDir.files = $$PWD/qml/qmldir

INSTALLS = btscQml btscQmlDir btscIcons btscTranslations btscLicenses
