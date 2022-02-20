# SPDX-FileCopyrightText: (C) 2015-2022 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

include(HBNSfosGenerateIcons)

if (HBNSC_ICONSIZES)
    set(ICONSIZES ${HBNSC_ICONSIZES})
else()
    set(ICONSIZES s)
endif()

hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/bitbucket.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/browser.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/facebook.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/github.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/linkedin.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/tmo.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/twitter.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/weibo.svg)
