# SPDX-FileCopyrightText: (C) 2015-2021 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.14.0 FATAL_ERROR)
cmake_policy(SET CMP0048 NEW)

project(libHbnSfosComponents
        VERSION 1.5.7
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

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "/usr/local" CACHE PATH "libfuoten default install prefix" FORCE)
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)


option(BUILD_SHARED_LIBS "Enable the build of shared libraries" ON)
option(ENABLE_MAINTAINER_FLAGS "Enables some build flags used for development" OFF)
set(HBNSC_APPNAME "" CACHE STRING "Name of the application the HBN SFOS Components are used for. Used for installation values.")
set(HBNSC_LIBDIR ${CMAKE_INSTALL_DATADIR}/${HBNSC_APPNAME}/lib CACHE PATH "Directory to install libraries.")
set(HBNSC_I18NDIR ${CMAKE_INSTALL_DATADIR}/${HBNSC_APPNAME}/translations CACHE PATH "Directory to install translations")
set(HBNSC_ICONSDIR ${CMAKE_INSTALL_DATADIR}/${HBNSC_APPNAME}/icons CACHE PATH "Directory to install icon")
set(HBNSC_QMLDIR ${CMAKE_INSTALL_DATADIR}/${HBNSC_APPNAME} CACHE PATH "Directory to install QML files.")

option(HBNSC_WITH_OPENSSL "Adds the OpenSSL license information to the licenses model. Requires openssl header files." ON)
option(HBNSC_WITH_NEMONOTIFY "Adds the Nemo Notify lib license information to the licenses model." OFF)
option(HBNSC_WITH_SQLITE "Adds the SQLite license information to the licenses model. Requires the sqlite header files." OFF)
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
