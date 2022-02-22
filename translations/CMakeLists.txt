# SPDX-FileCopyrightText: (C) 2015-2022 Matthias Fehring / www.huessenbergnetz.de
# SPDX-License-Identifier: BSD-3-Clause

include(HBNSfosGenerateTranslations)

set(TS_FILES
    hbnsc.ts
    hbnsc_da.ts
    hbnsc_de.ts
    hbnsc_en_GB.ts
    hbnsc_en_US.ts
    hbnsc_es.ts
    hbnsc_es_419.ts
    hbnsc_fr.ts
    hbnsc_nl.ts
    hbnsc_sv.ts
    hbnsc_zh.ts)

hbn_sfos_add_translation(QM_FILES ${TS_FILES} OPTIONS -idbased)

add_custom_target(hbnsfoscomptrans ALL
                  DEPENDS ${QM_FILES}
                  COMMENT "Compiles HBN SFOS Components translation messages"
                  SOURCES ${TS_FILES})

install(FILES ${QM_FILES}
        DESTINATION ${HBNSC_I18NDIR}
        COMPONENT runtime)
