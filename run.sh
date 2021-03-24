#!/usr/bin/env bash
set -euo pipefail

cd vscode;
SNIPPY_UTILS=src/snippy.py RUNPY=src/run.py IMGSUM=src/img-summary.py SYNTH=../synthesizer/target/snippy-server-0.1-SNAPSHOT-jar-with-dependencies.jar PYTHON3=$(which python3) SCALA=$(which scala) ./scripts/code.sh
