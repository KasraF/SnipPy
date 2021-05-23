#!/usr/bin/env bash
set -euo pipefail

# The environment variables
SERVER_PORT=8080

if [[ -d server ]]; then
	cd server &&
    SERVER_PORT=$SERVER_PORT java -jar target/snippy-server-0.1-SNAPSHOT.jar;
else
    echo "server directory not found. Did you initialize the submodules and build them first?";
fi;
