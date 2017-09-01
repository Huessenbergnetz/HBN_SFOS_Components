TEMPLATE = aux

DISTFILES += \
    qml/InfoHint.qml \
    qml/IconWithHint.qml \
    qml/Contributors.qml \
    qml/Changelog.qml \
    qml/AboutPage.qml \
    qml/PaypalChooser.qml \
    qml/ChangelogDelegate.qml \
    qml/ContributorsDelegate.qml \
    qml/LicenseDelegate.qml \
    qml/licenses/LicenseBase.qml \
    qml/licenses/LGPLv3.qml \
    qml/licenses/BSD-3.qml \
    qml/licenses/GPLv3.qml \
    qml/licenses/CC-BY-4_0.qml \
    qml/licenses/GPLv2.qml \
    qml/licenses/Apache-2_0.qml

OTHER_FILES += \
    qmldir.in

isEmpty(BTSC_APP_NAME): BTSC_APP_NAME = buschtrommel
BTSC_MODULE_NAME = harbour.$${BTSC_APP_NAME}.btsc
BTSC_INSTALL_QML_DIR = /usr/share/harbour-$$BTSC_APP_NAME/harbour/$$BTSC_APP_NAME/btsc
isEmpty(BTSC_INSTALL_ICONS_DIR): BTSC_INSTALL_ICONS_DIR = $$BTSC_INSTALL_QML_DIR/icons
isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = /usr/share/harbour-$$BTSC_APP_NAME/translations

licenseFiles.path = $$BTSC_INSTALL_QML_DIR/licenses

isEmpty(BTSC_LICENSES) {
    licenseFiles.files = qml/licenses/*.qml
} else {
    licenseFiles.files = qml/licenses/LicenseBase.qml

    for(l, BTSC_LICENSES) {
        licenseFiles.files += qml/licenses/$${l}.qml
    }
}


qmlFiles.path = $$BTSC_INSTALL_QML_DIR
qmlFiles.files = qml/*.qml

iconFiles.path = $$BTSC_INSTALL_ICONS_DIR
iconFiles.files = images/*.png

l10nFiles.path = $$INSTALL_TRANSLATIONS_DIR
l10nFiles.files = translations/*.qm

qmlDir.input = qmldir.in
qmlDir.output = qmldir
qmlDir.path = $$BTSC_INSTALL_QML_DIR
qmlDir.files = $$qmlDir.output

QMAKE_SUBSTITUTES += qmlDir

INSTALLS = qmlFiles qmlDir iconFiles l10nFiles licenseFiles
