#!/usr/bin/env bash
set -euo pipefail

if [[ -d vscode ]]; then
	echo "------------------------------"
    echo "-- Building VS Code ----------"
	echo "------------------------------"

    cd vscode;
    yarn && yarn compile && yarn run gulp editor-distro;
	cd ../;
else
    echo "vscode directory not found. Did you initialize the submodules?";
	exit 1;
fi;

if [[ -d monaco-editor ]]; then

	echo "------------------------------"
    echo "-- Building monaco-editor --"
    echo "------------------------------"

    cd monaco-editor;
    yarn release;
    cd ../;
else
	echo "monaco-editor directory not found. Did you initialize the submodule?";
	exit 1;
fi;

if [[ -d synthesizer ]]; then

    echo "------------------------------"
    echo "-- Building the synthesizer --"
    echo "------------------------------"

    cd synthesizer;
    mvn clean package -Pserver;
    cd ../;
else
    echo "synthesizer directory not found. Did you initialize the submodules?";
	exit 1;
fi;

echo "------------------------------"
echo "-- Build complete ------------"
echo "------------------------------"
