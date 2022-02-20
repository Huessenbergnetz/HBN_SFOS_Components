# SPDX-FileCopyrightText: (C) 2015-2022 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

include(HBNSfosGenerateTranslations)

hbn_sfos_gen_translation(hbnsfoscomptrans IDBASED INSTALL_DESTINATION ${HBNSC_I18NDIR} INPUT_FILE hbnsc.ts)

set(_langs da de en_GB en_US es es_419 fr nl sv zh)
foreach(_lang ${_langs})
    hbn_sfos_gen_translation(hbnsfoscomptrans IDBASED INSTALL_DESTINATION ${HBNSC_I18NDIR} INPUT_FILE hbnsc_${_lang}.ts)
endforeach()
