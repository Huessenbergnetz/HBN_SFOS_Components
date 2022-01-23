# SPDX-FileCopyrightText: (C) 2015-2021 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.12.4 FATAL_ERROR)
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
set(I18NDIR "${CMAKE_INSTALL_DATADIR}/libHbnSfosComponentsQt${QT_VERSION_MAJOR}/translations" CACHE PATH "Directory to install translations")
set(ICONSDIR "${CMAKE_INSTALL_DATADIR}/libHbnSfosComponentsQt${QT_VERSION_MAJOR}/icons" CACHE PATH "Directory to install icon")
set(QMLDIR "${CMAKE_INSTALL_LIBDIR}/qt${QT_VERSION_MAJOR}/qml" CACHE PATH "Directory to install QML files.")

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/hbnSfosComponents-config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/HbnSfosComponents${QT_VERSION_MAJOR}Config.cmake
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
)

install(EXPORT HbnSfosComponentsTargets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/HbnSfosComponentsQt${QT_VERSION_MAJOR}/
    FILE HbnSfosComponentsQt${QT_VERSION_MAJOR}Targets.cmake
    NAMESPACE HbnSfosComponents::
    COMPONENT development
)

add_subdirectory(src)
add_subdirectory(qml)
