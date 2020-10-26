#!/usr/bin/env bash
set -euo pipefail

if [[ -d vscode ]]; then

    echo "------------------------------"
    echo "-- Building VS Code ----------"
    echo "------------------------------"

    cd vscode;
    yarn && yarn compile;
    cd ../;

else
    echo "vscode directory not found. Did you initialize the submodules?";
fi;

if [[ -d synthesizer ]]; then

    echo "------------------------------"
    echo "-- Building the synthesizer --"
    echo "------------------------------"

    cd synthesizer;
    sbt assembly;
    cd ../;

else
    echo "synthesizer directory not found. Did you initialize the submodules?";
fi;
