# SPDX-FileCopyrightText: (C) 2015-2021 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier:  BSD-3-Clause

include(FindPkgConfig)
pkg_search_module(Sailfish sailfishapp REQUIRED IMPORTED_TARGET)
pkg_search_module(Silica sailfishsilica REQUIRED IMPORTED_TARGET)

if(HBNSC_WITH_OPENSSL)
    find_package(OpenSSL COMPONENTS SSL REQUIRED)
endif(HBNSC_WITH_OPENSSL)

if(HBNSC_WITH_NEMONOTIFY)
    pkg_search_module(NemoNotify nemonotifications-qt5 REQUIRED IMPORTED_TARGET)
endif(HBNSC_WITH_NEMONOTIFY)

if(HBNSC_WITH_SQLITE)
    find_package(SQLite3 REQUIRED)
endif(HBNSC_WITH_SQLITE)

if(HBNSC_WITH_DBUS)
    pkg_search_module(DBus dbus-1 REQUIRED IMPORTED_TARGET)
endif(HBNSC_WITH_DBUS)

set(HBN_SFOS_Comps_SRCS
   hbnsciconprovider.cpp
   hbnsclicensemodel.cpp
   hbnsclanguagemodel.cpp
   hbnsc.cpp)

set(HBN_SFOS_Comps_HEADERS
   hbnsciconprovider.h
   hbnsclicensemodel.h
   hbnsclanguagemodel.h
   hbnsc.h)

add_library(HbnSfosComponentsQt${QT_VERSION_MAJOR}
    ${HBN_SFOS_Comps_SRCS}
    ${HBN_SFOS_Comps_HEADERS}
)

add_library(HbnSfosComponentsQt${QT_VERSION_MAJOR}::Core ALIAS HbnSfosComponentsQt${QT_VERSION_MAJOR})

target_compile_features(HbnSfosComponentsQt${QT_VERSION_MAJOR} PUBLIC cxx_std_14)

target_link_libraries(HbnSfosComponentsQt${QT_VERSION_MAJOR}
    PUBLIC
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Quick
    PRIVATE
        $<$<BOOL:${HBNSC_WITH_OPENSSL}>:OpenSSL::SSL>
        $<$<BOOL:${HBNSC_WITH_NEMONOTIFY}>:PkgConfig::NemoNotify>
        $<$<BOOL:${HBNSC_WITH_SQLITE}>:SQLite::SQLite3>
        $<$<BOOL:${HBNSC_WITH_DBUS}>:PkgConfig::DBus>
        $<$<BOOL:${HBNSC_WITH_FIRFUORIDA}>:FirfuoridaQt${QT_VERSION_MAJOR}::Core>
        PkgConfig::Sailfish
        PkgConfig::Silica
)

target_compile_definitions(HbnSfosComponentsQt${QT_VERSION_MAJOR}
    PRIVATE
        QT_NO_CAST_TO_ASCII
        QT_NO_CAST_FROM_ASCII
        QT_STRICT_ITERATORS
        QT_NO_URL_CAST_FROM_STRING
        QT_NO_CAST_FROM_BYTEARRAY
        QT_USE_QSTRINGBUILDER
        QT_USE_FAST_OPERATOR_PLUS
        QT_DISABLE_DEPRECATED_BEFORE=0x050500
        HBNSC_VERSION="${PROJECT_VERSION}"
        HBNSC_ICONS_DIR="${HBNSC_ICONSDIR}"
        HBNSC_L10N_DIR="${HBNSC_I18NDIR}"
        $<$<BOOL:${HBNSC_WITH_OPENSSL}>:HBNSC_WITH_OPENSSL>
        $<$<BOOL:${HBNSC_WITH_NEMONOTIFY}>:HBNSC_WITH_NEMONOTIFY>
        $<$<BOOL:${HBNSC_WITH_SQLITE}>:HBNSC_WITH_SQLITE>
        $<$<BOOL:${HBNSC_WITH_DBUS}>:HBNSC_WITH_DBUS>
        $<$<BOOL:${HBNSC_WITH_FIRFUORIDA}>:HBNSC_WITH_FIRFUORIDA>
        $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
        $<$<NOT:$<CONFIG:Debug>>:QT_NO_DEBUG_OUTPUT>
        $<$<NOT:$<CONFIG:Debug>>:QT_DEPRECATED_WARNINGS>
)

if(ENABLE_MAINTAINER_FLAGS)
    target_compile_options(HbnSfosComponentsQt${QT_VERSION_MAJOR}
        PRIVATE
            -Wall
            -Wcast-align
            -Wno-uninitialized
            -Wempty-body
            -Wformat-security
            -Wformat
            -Winit-self
    )
endif(ENABLE_MAINTAINER_FLAGS)

target_include_directories(HbnSfosComponentsQt${QT_VERSION_MAJOR} PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/HbnSfosComponents-qt${QT_VERSION_MAJOR}>"
)

set_target_properties(HbnSfosComponentsQt${QT_VERSION_MAJOR} PROPERTIES
    EXPORT_NAME Core
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    PUBLIC_HEADER "${HBN_SFOS_Comps_HEADERS}"
)

install(TARGETS HbnSfosComponentsQt${QT_VERSION_MAJOR}
    EXPORT HbnSfosComponentsTargets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT runtime
    LIBRARY DESTINATION ${HBNSC_LIBDIR} COMPONENT runtime
    ARCHIVE DESTINATION ${HBNSC_LIBDIR} COMPONENT runtime
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/HbnSfosComponents-qt${QT_VERSION_MAJOR} COMPONENT development EXCLUDE_FROM_ALL
)
