#!/bin/bash

if [ ! -d translations ]; then
    mkdir translations
fi

lupdate-qt5 -no-obsolete -source-language en -target-language en -locations none qml -ts translations/hbnsc.ts
