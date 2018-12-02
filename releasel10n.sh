#!/bin/bash

lrelease-qt5 -idbased translations/hbnsc.ts

for LANG in da de en_GB en_US es es_419 fr nl sv zh
do
lrelease-qt5 -idbased translations/hbnsc_$LANG.ts
done
