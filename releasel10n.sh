#!/bin/bash

lrelease-qt5 -idbased translations/btsc.ts

for LANG in da de sv
do
lrelease-qt5 -idbased translations/btsc_$LANG.ts
done
