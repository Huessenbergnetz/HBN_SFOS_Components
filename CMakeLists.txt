# SPDX-FileCopyrightText: (C) 2015-2022 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.14.0 FATAL_ERROR)
cmake_policy(SET CMP0048 NEW)
cmake_policy(SET CMP0077 NEW)

project(libHbnSfosComponents
        VERSION 1.6.6
        DESCRIPTION "A set of QML components to use on Sailfish OS."
        LANGUAGES CXX)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Qml Gui Quick LinguistTools)
find_package(Qt${QT_VERSION_MAJOR} 5.6.0 REQUIRED COMPONENTS Core Qml Gui Quick LinguistTools)

# Include our cmake modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

# Auto generate moc files
set(CMAKE_AUTOMOC ON)

# As moc files are generated in the binary dir, tell CMake
# to always look for includes there:
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Forbid in-tree building
if(${CMAKE_SOURCE_DIR} MATCHES ${CMAKE_BINARY_DIR})
      message(STATUS "Please do an out-of-tree build:")
      message(STATUS "rm -f CMakeCache.txt && mkdir build && cd build; cmake .. && make")
      message(FATAL_ERROR "In-tree-build detected!")
endif(${CMAKE_SOURCE_DIR} MATCHES ${CMAKE_BINARY_DIR})

include(GNUInstallDirs)

option(BUILD_SHARED_LIBS "Enable the build of shared libraries" ON)
option(ENABLE_MAINTAINER_FLAGS "Enables some build flags used for development" OFF)
set(HBNSC_APPNAME "" CACHE STRING "Name of the application the HBN SFOS Components are used for. Used for installation values.")
set(HBNSC_BASEDIR ${CMAKE_INSTALL_DATADIR}/${HBNSC_APPNAME})
set(HBNSC_I18NDIR ${HBNSC_BASEDIR}/translations CACHE PATH "Directory to install translations")
set(HBNSC_ICONSDIR ${HBNSC_BASEDIR}/icons CACHE PATH "Directory to install icon")
set(HBNSC_QMLDIR ${HBNSC_BASEDIR} CACHE PATH "Directory to install QML files.")
set(HBNSC_ICONSIZES "s" CACHE STRING "Semicolon separated list of icon sizes to generate. HBNSC itself only requires small icons.")
set(HBNSC_LICENSES "" CACHE STRING "Semicolon separated list of licenses to include. By default, all licenses will be included.")

option(HBNSC_WITH_OPENSSL "Adds the OpenSSL license information to the licenses model. Requires openssl header files." ON)
option(HBNSC_WITH_NEMONOTIFY "Adds the Nemo Notify lib license information to the licenses model." OFF)
option(HBNSC_WITH_FIRFUORIDA "Add libfirfuorida lincense information to the licenses model." OFF)
option(HBNSC_WITH_SQLITE "Adds the SQLite license information to the licenses model. Requires the sqlite header files." ${HBNSC_WITH_FIRFUORIDA})
option(HBNSC_WITH_DBUS "Adds hhe DBus license information to the licenses model. Requires the dbus header files." OFF)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/hbnSfosComponents-config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/HbnSfosComponentsQt${QT_VERSION_MAJOR}Config.cmake
    @ONLY
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/hbnSfosComponents-config-version.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/HbnSfosComponentsQt${QT_VERSION_MAJOR}ConfigVersion.cmake
    @ONLY
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/HbnSfosComponentsQt${QT_VERSION_MAJOR}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/HbnSfosComponentsQt${QT_VERSION_MAJOR}ConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/HbnSfosComponentsQt${QT_VERSION_MAJOR}/
    COMPONENT development
    EXCLUDE_FROM_ALL
)

install(EXPORT HbnSfosComponentsTargets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/HbnSfosComponentsQt${QT_VERSION_MAJOR}/
    FILE HbnSfosComponentsQt${QT_VERSION_MAJOR}Targets.cmake
    NAMESPACE HbnSfosComponents::
    COMPONENT development
    EXCLUDE_FROM_ALL
)

add_subdirectory(src)
add_subdirectory(qml)
add_subdirectory(images)
add_subdirectory(translations)
