#!/bin/bash

lrelease-qt5 -idbased translations/btsc.ts

for LANG in de
do
lrelease-qt5 -idbased translations/btsc_$LANG.ts
done
