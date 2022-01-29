set(QML_FILES
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

if(HBNSC_LICENSES)
    set(QML_LICENSE_FILES
        licenses/LicenseBase.qml
        licenses/LGPLv2_1.qml
        licenses/LGPLv3.qml
        licenses/BSD-3.qml
        licenses/CC-BY-4_0.qml
    )

    foreach(_license ${HBNSC_LICENSES})
        list(APPEND QML_LICENSE_FILES licenses/${_license}.qml)
    endforeach()

    if(HBNSC_WITH_OPENSSL)
        list(APPEND QML_LICENSE_FILES licenses/OpenSSL.qml)
    endif()

    if(HBNSC_WITH_SQLITE)
        list(APPEND QML_LICENSE_FILES licenses/SQLite.qml)
    endif()

    if(HBNSC_WITH_DBUS)
        list(APPEND QML_LICENSE_FILES licenses/GPLv2.qml)
    endif()

    list(REMOVE_DUPLICATES HBNSC_LICENSES)
else()
    set(QML_LICENSE_FILES
        licenses/Apache-2_0.qml
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
    )
endif()

add_custom_target(hbnsfoscomponentsqmlfiles
    SOURCES
        ${QML_FILES}
        ${QML_LICENSE_FILES}
)

install(FILES ${QML_FILES}
        DESTINATION "${HBNSC_QMLDIR}/de/huessenbergnetz/hbnsc")

install(FILES ${QML_LICENSE_FILES}
        DESTINATION "${HBNSC_QMLDIR}/de/huessenbergnetz/hbnsc/licenses")
