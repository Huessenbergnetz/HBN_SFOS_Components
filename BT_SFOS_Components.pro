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
    qml/licenses/GPLv3.qml

OTHER_FILES += \
    qmldir.in


isEmpty(BTSC_MODULE_NAME): BTSC_MODULE_NAME = harbour.buschtrommel.btsc
MODULE_NAME_PARTS = $$split(BTSC_MODULE_NAME, .)
APP_NAME = $$member(MODULE_NAME_PARTS, 1)
COMP_NAME = $$member(MODULE_NAME_PARTS, 2)
isEmpty(BTSC_INSTALL_QML_DIR): BTSC_INSTALL_QML_DIR = /usr/share/harbour-$$APP_NAME/harbour/$$APP_NAME/$$COMP_NAME
isEmpty(BTSC_INSTALL_ICONS_DIR): BTSC_INSTALL_ICONS_DIR = $$BTSC_INSTALL_QML_DIR/icons
isEmpty(INSTALL_TRANSLATIONS_DIR): INSTALL_TRANSLATIONS_DIR = $$[QT_INSTALL_TRANSLATIONS]

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
