# LatexTemplate

## What this is

This repository is a template for LaTeX projects. The pipeline builds
[main.tex](main.tex) and deploys the resulting PDF to GitHub Pages on every push
to `master`, available at `https://<your-user>.github.io/<your-repo>/`.

The workflow uses the modern GitHub Pages deployment flow
([`actions/deploy-pages`](https://github.com/actions/deploy-pages)). To enable it:

1. Go to **Settings → Pages** in your repository.
2. Set **Source** to **GitHub Actions**.
3. Push to `master` — the [workflow](.github/workflows/buildTex.yml) handles the rest.

To start from this template,
[create a new repository from it](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template).

## Build LaTeX files locally

A Docker-based build environment is provided so your local toolchain matches the
one used by CI. It uses the official [`texlive/texlive`](https://hub.docker.com/r/texlive/texlive)
image and rebuilds the PDF on every file change via `inotifywait`.

Requirements: [Docker](https://docs.docker.com/get-docker/) with the built-in
Compose v2 plugin.

```sh
docker compose up -d      # start the watcher (PDF appears in ./out)
docker compose logs -f    # follow build output
docker compose down       # stop and remove the container
```

The produced PDF lives in `out/main.pdf`.

Inside the container (via `docker compose exec build_latex sh` or the dev
container terminal) the following helpers are on `$PATH`:

| command | what it does                                       |
| ------- | -------------------------------------------------- |
| `build` | one-shot clean build; exits with latexmk's status  |
| `watch` | clean build, then rebuild on every file change     |
| `clean` | wipe the `out/` directory                          |

Any other LaTeX toolchain (TeX Live, MiKTeX, Tectonic, an IDE like TeXstudio or
the IntelliJ TeXiFy plugin) will also work — the Docker setup is just the most
reproducible option.

### Dev Container

A [Dev Container](https://containers.dev) definition lives in
[.devcontainer/](.devcontainer/). Open the repository with JetBrains Gateway
(or any IntelliJ-based IDE's *Remote Development → Dev Containers* entry point)
and select this repo — you'll get the same TeX Live environment as CI with the
[TeXiFy](https://plugins.jetbrains.com/plugin/9473-texify-idea) plugin
pre-installed.

> **Windows users:** keep the repository inside your WSL filesystem. Hot reload
> relies on inotify events, which do not cross the Windows/Linux filesystem
> boundary. Builds will work from a Windows path, but automatic rebuilds won't.

## Contribution

Pull requests and suggestions are welcome.
