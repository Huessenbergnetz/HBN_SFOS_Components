#!/bin/bash

lrelease-qt5 -idbased translations/btsc.ts

for LANG in da de en_GB en_US es es_419 fr nl sv
do
lrelease-qt5 -idbased translations/btsc_$LANG.ts
done
