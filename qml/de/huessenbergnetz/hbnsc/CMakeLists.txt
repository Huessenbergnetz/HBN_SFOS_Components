set(QML_FILES licenses/Apache-2_0.qml
        licenses/BSD-3.qml
        licenses/CC-BY-3_0.qml
        licenses/CC-BY-4_0.qml
        licenses/CC-BY-NC-SA-4_0.qml
        licenses/CC-SP-1_0.qml
        licenses/CC0-1_0.qml
        licenses/GPLv2.qml
        licenses/GPLv3.qml
        licenses/LGPLv2_1.qml
        licenses/LGPLv3.qml
        licenses/LicenseBase.qml
        licenses/OpenSSL.qml
        licenses/SIL-OFL-1_1.qml
        licenses/SQLite.qml
        licenses/zlib.qml
        AboutPage.qml
        Changelog.qml
        ChangelogDelegate.qml
        Contributors.qml
        ContributorsDelegate.qml
        IconWithHint.qml
        InfoHint.qml
        LanguagePicker.qml
        LicenseDelegate.qml
        PaypalChooser.qml
        qmldir)

add_custom_target(hbnsfoscomponentsqmlfiles
    SOURCES
        ${QML_FILES})

install(FILES ${QML_FILES}
        DESTINATION "${HBNSC_QMLDIR}/de/huessenbergnetz/hbnsc")
