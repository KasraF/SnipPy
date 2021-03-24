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
This repository contains the Enumerative Synthesizer that powers PopPy. It is an implementation of bottom-up enumerative synthesis with observational equivalence partial output specifications.

### VS Code
This repository is a fork of Microsoft's [VS Code Repository](https://github.com/microsoft/vscode) modified to include [Projection Boxes](https://cseweb.ucsd.edu/~lerner/papers/projection-boxes-chi2020.pdf) with PopPy support.

## Setup
To get these submodules, you can run the following git command:

``` sh
git submodule update --init --remote
```

After that, please make sure that the `vscode` and `synthesizer` exist and have files in them. 

Note that this is only for convenience, and as long as you have both repos checked out with the same directory structure (both under the same root) everything else here should still work.

The build scripts provided in this repo assume that certain applications are installed and exist on the `PATH`.

For building/running VS Code and the Projection Boxes, you need:
1. [NodeJS 14](https://nodejs.org/en/)
2. [Yarn](https://yarnpkg.com/)
3. [Python 3](https://www.python.org/downloads/)

For building/running the synthesizer, you need:
1. [Java 11/15](https://www.oracle.com/java/technologies/javase-downloads.html#JDK11)
2. [Maven](https://maven.apache.org/) 

## Building

> tldr; On Unix-like operating systems, you can build both modules by running
> 
> ``` sh
> ./build.sh
> ```

To build VS Code, you first need to get the necessary node modules, then compile the source to the javascript files:

``` sh
cd vscode;
yarn;
yarn compile;
cd ../;
```

To build the synthesizer and wrap it in an executable Jar file, you can just run:

``` sh
cd synthesizer;
mvn clean package -Plocal;
cd ../;
```

The `-Plocal` packages it for the local non-browser build, since PopPy currently doesn't work with the browser-based editor. 

This repo also includes a `build.sh` script that does both for you. :)

## Running

> tldr; On Unix-like operating systems, you can run PopPy using the script 
> 
> ``` sh
> ./run.sh
> ```

To use PopPy, you need to run this custom build of `vscode`, but it requires a set of environment variables to be correctly set before it works:

1. `SNIPPY_UTILS`: Absolute path to `vscode/src/snippy.py`
2. `RUNPY`: Absolute path to `vscode/src/run.py`
3. `IMGSUM`: Absolute path to `vscode/src/img-summary.py`
4. `SYNTH`: Absolute path to `synthesizer/target/snippy-server-0.1-SNAPSHOT-jar-with-dependencies.jar`
5. `PYTHON3`: Absolute path to your `python3` executable.
6. `SCALA`: Absolute path to your `scala` executable.

You can also optionally set these environment variables:
1. `LOG_DIR`: Absolute path to where you would like the logs to be stored. By default, the operating system's temporary directory is used.

Once these are set, you can run PopPy with the `vscode/scripts/code` script for your operating system. 
