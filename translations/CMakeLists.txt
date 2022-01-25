include(HBNSfosGenerateTranslations)

hbn_sfos_gen_translation(hbnsfoscomptrans IDBASED INPUT_FILE hbnsc.ts)

set(_langs da de en_GB en_US es es_419 fr nl sv zh)
foreach(_lang ${_langs})
    hbn_sfos_gen_translation(hbnsfoscomptrans IDBASED INPUT_FILE hbnsc_${_lang}.ts)
endforeach()
