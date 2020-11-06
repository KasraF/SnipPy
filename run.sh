#!/usr/bin/env bash
set -euo pipefail

# The environment variables
PYTHON3="$(which python3)"
SCALA="$(which scala)"
RUNPY="$(pwd)/vscode/src/run.py"
IMGSUM="$(pwd)/vscode/src/img-summary.py"
SYNTH="$(pwd)/synthesizer/target/scala-2.13/SnippySynthesizer-assembly-0.1.jar"

if [[ -d vscode ]]; then
    PYTHON3="$PYTHON3" SCALA="$SCALA" RUNPY="$RUNPY" IMGSUM="$IMGSUM" SYNTH="$SYNTH" ./vscode/scripts/code.sh;
else
    echo "vscode directory not found. Did you initialize the submodules and build them first?";
fi;
