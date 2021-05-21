# LooPy

The source code for LooPy.

This is a meta-repository containing the instructions, build scripts, and necessary submodules to build the web version of LooPy.

## Content
1. [Modules](#modules)
2. [Setup](#setup)
3. [Building](#building)
4. [Running](#running)
5. [TODOs](#todos) 

## Modules
This repository is meant for simplifying the process of building LooPy, and is really just the following two repositories:

### Synthesizer
This repository contains the Enumerative Synthesizer that powers LooPy. It is an implementation of bottom-up enumerative synthesis with observational equivalence.

### VS Code
This repository is a fork of Microsoft's [VS Code Repository](https://github.com/microsoft/vscode) modified to include [Projection Boxes](https://cseweb.ucsd.edu/~lerner/papers/projection-boxes-chi2020.pdf) with LooPy support.

## Monaco Editor
This is a wrapper for VS Code's Monaco Editor that allows us to run the editor in the browser.

## Setup

> tldr; On Unix-like operating systems, you can build both modules by running
> 
> ``` sh
> ./init.sh
> ```

The build scripts provided in this repo assume that certain applications are installed and exist on the `PATH`.

For building/running VS Code and the Projection Boxes, you need:
1. [NodeJS 14](https://nodejs.org/en/)
2. [Yarn](https://yarnpkg.com/)
3. [Python 3](https://www.python.org/downloads/)

For building/running the synthesizer, you need:
1. [Java 11/15](https://www.oracle.com/java/technologies/javase-downloads.html#JDK11)
2. [Maven](https://maven.apache.org/)
3. [wget](https://www.gnu.org/software/wget/) (This is just the download tool used in the scripts. Feel free to replace it with your download tool of choice!)

Once you have these applications, you can initialize this meta-repo with all its submodules by running

```sh
./init.sh
```

If you would like to do this manually, you need to:
1. Initialize the submodules by running 
   ``` sh
   git submodule update --remote --init
   ```
2. Build `vscode`:
   ``` sh
   cd vscode;
   yarn;
   yarn run gulp editor-distro;
	```
3. Link the monaco editor code in yarn:
   ```sh
   cd out-monaco-editor-core;
   yarn link;
```
4. Build the monaco editor module:
   ``` sh
   cd ../../monaco-editor;
   yarn link monaco-editor-core;
   yarn;
   yarn release;
   ```
5. Link the monaco editor module:
   ``` sh
   cd release;
   yarn link;
	```
6. Download [pyodide](https://pyodide.readthedocs.io/en/latest/):
   ```sh
   cd ../../synthesizer/src/main/resources/static/;
   wget 'https://github.com/pyodide/pyodide/releases/download/0.17.0/pyodide-build-0.17.0.tar.bz2';
   tar --wildcards -xvf 'pyodide-build-0.17.0.tar.bz2' 'pyodide/pyodide*' 'pyodide/packages.json';
   rm 'pyodide-build-0.17.0.tar.bz2';
   ```
7. And finally, build the synthesizer/server:
   ```sh
   cd ../../../..;
   yarn link monaco-editor;
   yarn;
   mvn clean package -Pserver; 
   ```

## Building

> tldr; On Unix-like operating systems, you can build both modules by running
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

Finally, to build the synthesizer and wrap it in an executable Jar file, we can just run:

``` sh
cd synthesizer;
yarn link monaco-editor;
mvn clean install;
cd ../;
```

This repo also includes a `build.sh` script that does all of this for you. :)

## Running

> tldr; You can run LooPy by running
> ```sh
> ./run.sh
> ```
> And opening http://localhost:8080/ in your favorite browser. Yes, even Safari! 

You can run SnipPy just by running the Jar file `synthesizer/target/snippy-server-0.1-SNAPSHOT.jar`. This will start up the server in port 8080.

To change the port on which the server runs, you can set the `SERVER_PORT` environment variable.`

To make this more convenient, you can instead set the `SERVER_PORT` variable in the `./run.sh` script and use that instead. :)

After running the Jar file, you can open SnipPy in your favorite browser by going to https://localhost:8080/ (or the port you set it to). 
