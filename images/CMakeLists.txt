include(HBNSfosGenerateIcons)

set(ICONSIZES "s")

hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/bitbucket.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/browser.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/facebook.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/github.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/linkedin.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/tmo.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/twitter.svg)
hbn_sfos_gen_icons(hbnsfoscompicons SIZES ${ICONSIZES} INSTALL_DESTINATION ${HBNSC_ICONSDIR} INPUT_FILE src/weibo.svg)
