#!/usr/bin/env bash

# First, set up all submodules
git submodule update --remote --init &&

cd vscode &&
git checkout loopy-web &&
yarn &&
yarn run gulp editor-distro &&
cd out-monaco-editor-core &&
yarn link &&
cd ../../ &&

cd monaco-editor &&
git checkout main &&
yarn link monaco-editor-core &&
yarn &&
yarn release &&
cd release &&
yarn link &&
cd ../../ &&

cd synthesizer &&
git checkout loopy-web &&
mvn clean install &&
cd ../ &&

cd server &&
git checkout main &&
yarn link monaco-editor &&
yarn &&
cd src/main/resources/static/ &&
wget 'https://github.com/pyodide/pyodide/releases/download/0.17.0/pyodide-build-0.17.0.tar.bz2' &&
tar --wildcards -xvf 'pyodide-build-0.17.0.tar.bz2' 'pyodide/pyodide*' 'pyodide/packages.json' &&
rm 'pyodide-build-0.17.0.tar.bz2' &&
cd ../../../.. &&
mvn clean package &&
cd ../ &&

echo "Done!"
