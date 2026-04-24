FROM texlive/texlive:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        inotify-tools \
        openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Helper commands available both as ENTRYPOINT and inside the devcontainer:
#   build — one-shot clean build, exits with latexmk's status code
#   watch — initial clean build, then rebuild on every change
#   clean — wipe the out directory
RUN printf '%s\n' \
    '#!/bin/sh' \
    'set -e' \
    'cd "${WORKDIR:-/workdir}"' \
    'rm -rf out' \
    'mkdir -p out' \
    'exec latexmk -pdf -shell-escape -interaction=nonstopmode -file-line-error -output-directory=out main.tex' \
    > /usr/local/bin/build \
    && chmod +x /usr/local/bin/build \
    && printf '%s\n' \
    '#!/bin/sh' \
    'set -e' \
    'cd "${WORKDIR:-/workdir}"' \
    'build || true' \
    'while :; do' \
    '    inotifywait -e modify,create,delete -r . --exclude "(^|/)out(/|$)"' \
    '    latexmk -pdf -shell-escape -interaction=nonstopmode -file-line-error -f -output-directory=out main.tex || true' \
    'done' \
    > /usr/local/bin/watch \
    && chmod +x /usr/local/bin/watch \
    && printf '%s\n' \
    '#!/bin/sh' \
    'set -e' \
    'cd "${WORKDIR:-/workdir}"' \
    'rm -rf out' \
    'mkdir -p out' \
    > /usr/local/bin/clean \
    && chmod +x /usr/local/bin/clean

WORKDIR /workdir

ENTRYPOINT ["/usr/local/bin/watch"]
