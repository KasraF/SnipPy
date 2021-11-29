#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd $SCRIPT_DIR/vscode;
SNIPPY_UTILS=src/snippy.py RUNPY=src/run.py IMGSUM=src/img-summary.py SYNTH=../synthesizer/target/snippy-server-0.1-SNAPSHOT-jar-with-dependencies.jar LOG_DIR=../logs PYTHON3=$(which python3) JAVA=$(which java) HEAP=20G ./scripts/code.sh
