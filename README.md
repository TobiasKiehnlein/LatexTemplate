# LatexTemplate

## What this is

This repository is meant to be a template for any Latex project. I personally use it for my papers in university, but it
can be used for pretty much any latex document.

This projects pipeline will automatically build and deploy your pdf document ([main.tex](main.tex) -> main.pdf) in
GitHub pages on every change on the master branch. [yourusername.github.io/yourrepositoryname]. To adjust this behaviour
just edit the [github action](.github/workflows/buildTex.yml).

To use this repository
just [create a new repository from this template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template)
.

## Build Latex files

There are many ways to compile your latex documents. You can find some docker related files in this repository. These
can be used to compile your latex document and reload them as soon as changes are detected. The major advantage using
this docker based approach is the consistency between the local development machines and the build/deployment machine (
GitHub runners). Since the same base image is used in the final workflow everything should work exactly as it did
locally. Another benefit is that you don't have to have latex installed on your local machine. Every other method to
compile your latex files locally should also work fine but errors and functionality may differ from th final deployment.

To get the build environment running make sure to have [docker and docker-compose](https://docs.docker.com/get-docker/)
installed. After that run `docker-compose up -d` in the repository folder. To stop the build environment you can just
use `docker-compose stop` as you would with every other docker-compose stack.

> :warning: **If you are using Windows**:
> When using Windows, you need to make sure that all files are downloaded to a local wsl installation and run docker from there.
> While compilation will work on Windows (without wsl) as well hot reloading will fail due to different file processing in Linux and Windows.
> If that's not an issue, you can run it directly in Windows, otherwise it's recommended to use wsl.

## Contribution

Feel free to contribute any changes, ideas or optimizations you have to this repository.
