isEmpty(BTSC_APP_NAME): BTSC_APP_NAME = buschtrommel
BTSC_MODULE_NAME = harbour.$${BTSC_APP_NAME}.btsc
BTSC_INSTALL_QML_DIR = /usr/share/harbour-$$BTSC_APP_NAME/harbour/$$BTSC_APP_NAME/btsc
isEmpty(BTSC_INSTALL_ICONS_DIR): BTSC_INSTALL_ICONS_DIR = $$BTSC_INSTALL_QML_DIR/icons
isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/harbour-$$BTSC_APP_NAME/translations

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
        btscLicenses.files += $$PWD/qml/licenses/$${l}.qml
    }
}

btscQml.path = $$BTSC_INSTALL_QML_DIR
btscQml.files = qml/*.qml

btscIcons.path = $$BTSC_INSTALL_ICONS_DIR
btscIcons.files = $$PWD/images/z*

btscTranslations.path = $$INSTALL_TRANSLATIONS_DIR
btscTranslations.files = translations/*.qm

btscQmlDir.input = $$PWD/qmldir.in
btscQmlDir.output = qmldir
btscQmlDir.path = $$BTSC_INSTALL_QML_DIR
btscQmlDir.files = $$btscQmlDir.output

QMAKE_SUBSTITUTES += btscQmlDir

INSTALLS = btscQml btscQmlDir btscIcons btscTranslations btscLicenses
