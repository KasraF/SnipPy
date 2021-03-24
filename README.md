# PopPy

This `poppy` branch contains source code for PopPy, an extension to SnipPy, the tool created for the [Small-Step Live Programming By Example](https://dl.acm.org/doi/10.1145/3379337.3415869) paper, that accepts partial output specifications.

This is a meta-repository containing the instructions, build scripts, and necessary submodules to build a local version of PopPy.

## Content
1. [Modules](#modules)
2. [Setup](#setup)
3. [Building](#building)
4. [Running](#running)
5. [TODOs](#todos) 

## Modules
This repository is meant for simplifying the process of building PopPy, and is really just the following two repositories:

### Synthesizer
This repository contains the server that will eventually serve the editor, combined with the Enumerative Synthesizer that powers SnipPy and hence PopPy. It is an implementation of bottom-up enumerative synthesis with observational equivalence.

## VS Code
This repository is a fork of Microsoft's [VS Code Repository](https://github.com/microsoft/vscode) modified to include [Projection Boxes](https://cseweb.ucsd.edu/~lerner/papers/projection-boxes-chi2020.pdf) with SnipPy support.

## Monaco Editor
This is a wrapper for VS Code's Monaco Editor that allows us to run the editor in the browser.

## Setup
To get these submodules, you can run the following git command:

``` sh
git submodule update --init --remote
```

After that, please make sure that the `vscode` and `synthesizer` exist.

The build scripts provided in this repo assume that certain applications are installed and exist on the `PATH`.

For building/running VS Code and the Projection Boxes, you need:
1. [NodeJS 12](https://nodejs.org/en/)
2. [Yarn](https://yarnpkg.com/)
3. [Python 3](https://www.python.org/downloads/)
4. [The `numpy` Python library](https://numpy.org/install/)
5. [The `Pillow` Python library](https://pillow.readthedocs.io/en/stable/installation.html)  

For building/running the synthesizer/server, you need:
1. [Scala](https://scala-lang.org/)
2. [Maven](https://maven.apache.org/)
3. [wget](https://www.gnu.org/software/wget/) [Optional: See below for alternative] 

## Building

Build the synthesizer
```
cd synthesizer
git checkout poppy
mvn clean install -Plocal
```

Build the editor
```
cd ../vscode
git checkout poppy
yarn
yarn compile
```


## Running

Make sure you are in the `vscode` directory before executing the following command.
```
SNIPPY_UTILS=src/snippy.py RUNPY=src/run.py IMGSUM=src/img-summary.py SYNTH=../synthesizer/target/snippy-server-0.1-SNAPSHOT-jar-with-dependencies.jar PYTHON3=$(which python3) SCALA=$(which scala) ./scripts/code.sh
```

## TODOs
1. Cleanup the build process. Currently, `vscode` builds much more than it needs, and the compilation takes a long time.
2. Add instructions for Windows
