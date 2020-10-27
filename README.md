# SnipPy

The source code for SnipPy, the tool created for the [Small-Step Live Programming By Example](https://dl.acm.org/doi/10.1145/3379337.3415869) paper.

This is a meta-repository containing the instructions, build scripts, and necessary submodules to build a version of SnipPy ready to run in your browser! (For the local version see [here](https://github.com/KasraF/SnipPy)).

## Content
1. [Modules](#modules)
2. [Setup](#setup)
3. [Building](#building)
4. [Running](#running)
5. [TODOs](#todos) 

## Modules
This repository is meant for simplifying the process of building SnipPy, and is really just the following two repositories:

### Synthesizer
This repository contains the server that will eventually serve the editor, combined with the Enumerative Synthesizer that powers SnipPy. It is an implementation of bottom-up enumerative synthesis with observational equivalence.

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

> tldr; You can build both modules by running
> 
> ``` sh
> ./build.sh
> ```

To build VS Code, we first need to get the necessary node modules, compile the source to the javascript files that `monaco-editor` needs, and finally link it so that `monaco-editor` uses our build instead of downloading the package from the Node package repository:`

``` sh
cd vscode;
yarn;
yarn run gulp editor-distro;
cd out-monaco-editor-core;
yarn link;
cd ../../;
```

We can then build the editor that can be loaded in the browser:

``` sh
cd monaco-editor;
link monaco-editor-core;
yarn;
yarn release;
cd release;
yarn link;
cd ../../;
```

SnipPy uses [Pyodide](https://pyodide.readthedocs.io/en/latest/) to run Python directly in the browser. Before building the server, we need to download it and unzip it in the right directory to be served statically by the browser:

``` sh
cd synthesizer/src/main/resources/static/pyodide;
wget https://github.com/KasraF/pyodide/releases/download/monaco/pyodide_with_pillow.zip;
unzip pyodide_with_pillow.zip;
rm pyodide_with_pillow.zip;
cd ../../../../../../;
```

If you don't have `wget`, you can download that link however you like and unzip it in that directory. At the end, make sure that all files in that zip file are directly in `resources/static/pyodide` and not in a subdirectory.`

Finally, to build the synthesizer and wrap it in an executable Jar file, we can just run:

``` sh
cd synthesizer;
yarn link monaco-editor;
mvn clean install;
cd ../;
```

This repo also includes a `build.sh` script that does both for you. :)

## Running

> tldr; You can run SnipPy by running
> ```sh
> ./run.sh
> ```
> And opening http://localhost:8080/ in your favorite (non-Safari) browser.

You can run SnipPy just by running the Jar file `synthesizer/target/snippy-server-0.1-SNAPSHOT.jar`. This will start up the server in port 8080.

To change the port on which the server runs, you can set the `SERVER_PORT` environment variable.`

To make this more convenient, you can instead set the `SERVER_PORT` variable in the `./run.sh` script and use that instead. :)

After running the Jar file, you can open SnipPy in your favorite browser by going to https://localhost:8080/ (or the port you set it to). But please note that SnipPy does not work in Safari, because the Python interpreter crashes and the editor never fully loads. Any other browser should work. 

## TODOs
1. Cleanup the build process. Currently, `vscode` builds much more than it needs, and the compilation takes a long time.
2. Add instructions for Windows
