# SPDX-FileCopyrightText: (C) 2015-2022 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

include(HBNSfosGenerateIcons)

if (HBNSC_ICONSIZES)
    set(ICONSIZES ${HBNSC_ICONSIZES})
else()
    set(ICONSIZES s)
endif()

set(SVG_ICONS
    src/bitbucket.svg
    src/browser.svg
    src/facebook.svg
    src/github.svg
    src/linkedin.svg
    src/tmo.svg
    src/twitter.svg
    src/weibo.svg)

hbn_sfos_add_icon(pngFiles SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} ${SVG_ICONS})

add_custom_target(hbnSfosCompIcons ALL
    DEPENDS ${pngFiles}
    COMMENT "Generating HBN SFOS Component icons"
    SOURCES ${SVG_ICONS})
