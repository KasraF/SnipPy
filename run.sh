#!/usr/bin/env bash
set -euo pipefail

# The environment variables
SERVER_PORT=8080

if [[ -d synthesizer ]]; then
    SERVER_PORT=$SERVER_PORT java -jar synthesizer/target/snippy-server-0.1-SNAPSHOT.jar;
else
    echo "synthesizer directory not found. Did you initialize the submodules and build them first?";
fi;
