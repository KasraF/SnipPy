# SnipPy

The source code for SnipPy, the tool created for the [Small-Step Live Programming By Example](https://dl.acm.org/doi/10.1145/3379337.3415869) paper.

This is a meta-repository containing the instructions, build scripts, and necessary submodules to build a version of SnipPy ready to run a local instance of VS Code!

## Content
1. [Modules](#modules)
2. [Setup](#setup)
3. [Building](#building)
4. [Running](#running)
5. [TODOs](#todos) 

## Modules
This repository is meant for simplifying the process of building SnipPy, and is really just the following two repositories:

### Synthesizer
This repository contains the Enumerative Synthesizer that powers SnipPy. It is an implementation of bottom-up enumerative synthesis with observational equivalence.

## VS Code
This repository is a fork of Microsoft's [VS Code Repository](https://github.com/microsoft/vscode) modified to include [Projection Boxes](https://cseweb.ucsd.edu/~lerner/papers/projection-boxes-chi2020.pdf) with SnipPy support. 

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

For building/running the synthesizer, you need:
1. [Scala](https://scala-lang.org/)
2. [SBT](https://www.scala-sbt.org/) 

## Building

> tldr; You can build both modules by running
> 
> ``` sh
> ./build.sh
> ```

To build VS Code, we first need to get the necessary node modules, and then compile the source:

``` sh
cd vscode;
yarn;
yarn compile;
cd ../;
```

To build the synthesizer and wrap it in an executable Jar file, you can just run:

``` sh
cd synthesizer;
sbt assembly;
cd ../;
```

This repo also includes a `build.sh` script that does both for you. :)

## Running

> tldr; You can run SnipPy by running
> ```sh
> ./run.sh
> ```

You can run SnipPy just by running our custom VS Code, but it looks for the following environmental variables, and will throw errors if one or more are not set correctly:

1. `PYTHON3`: Absolute path to your Python 3 executable
2. `SCALA`: Absolute path to your Scala executable
3. `RUNPY`: Absolute path to the `run.py` file in `vscode/src/run.py`
4. `IMGSUM`: Absolute path to the `img-summary.py` file in `vscode/src/run.py`
5. `SYNTH`: Absolute path to the `synthesizer` jar file in `synthesizer/target/scala-2.13/PythonSynthesizer-assembly-0.1.jar`

But you can just use the `./run.sh` script instead :)

## TODOs
2. Write the complete build scripts
3. Add instructions for Windows
