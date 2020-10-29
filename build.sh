#!/usr/bin/env bash
set -euo pipefail

if [[ -d vscode ]]; then

    echo "------------------------------"
    echo "-- Building VS Code ----------"
    echo "------------------------------"

    cd vscode;
    yarn && yarn run gulp editor-distro;

    if [[ -d out-monaco-editor-core ]]; then
        cd out-monaco-editor-core &&
        yarn link &&
        cd ../;
    fi;

    cd ../;

else
    echo "vscode directory not found. Did you initialize the submodules?";
fi;

if [[ -d monaco-editor ]]; then

    echo "------------------------------"
    echo "-- Building Monaco Editor ----"
    echo "------------------------------"

    cd monaco-editor;

    # Clean existing build
    if [[ -d release ]]; then rm -rf release; fi;

    yarn link monaco-editor-core;
    yarn && yarn release;

    if [[ -d release ]]; then
        cd release/;
        yarn link;
        cd ../;
    fi;

    cd ../;

else
    echo "monaco-editor directory not found. Did you initialize the submodules?";
fi;

if [[ -d synthesizer ]]; then

    echo "------------------------------"
    echo "-- Building the synthesizer --"
    echo "------------------------------"

    cd synthesizer;
    yarn link monaco-editor;
    yarn;

    if [[ ! -e src/main/resources/static/pyodide/astropy.data ]]; then
       echo "We need to download Pyodide"
       cd src/main/resources/static/pyodide;
       wget https://github.com/KasraF/pyodide/releases/download/monaco/pyodide_with_pillow.zip;
       unzip pyodide_with_pillow.zip;
       rm pyodide_with_pillow.zip;
       cd ../../../../../;
    else
        echo "Pyodide already exists.";
    fi;

    mvn clean package -DskipTests;
    cd ../;

else
    echo "synthesizer directory not found. Did you initialize the submodules?";
fi;
