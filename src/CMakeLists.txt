# SPDX-FileCopyrightText: (C) 2015-2021 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier:  BSD-3-Clause

include(FindPkgConfig)
pkg_search_module(Sailfish sailfishapp REQUIRED IMPORTED_TARGET)
pkg_search_module(Silica sailfishsilica REQUIRED IMPORTED_TARGET)

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
        HBNSC_ICONS_DIR="${ICONSDIR}"
        HBNSC_L10N_DIR="${I18NDIR}"
)

if(ENABLE_MAINTAINER_FLAGS)
    target_compile_definitions(HbnSfosComponentsQt${QT_VERSION_MAJOR}
        PRIVATE
            QT_DEPRECATED_WARNINGS
            $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    )
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
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT runtime
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT runtime
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/HbnSfosComponents-qt${QT_VERSION_MAJOR} COMPONENT development
)
