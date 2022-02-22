FROM danteev/texlive
RUN apt update
RUN apt install inotify-tools -y
ENTRYPOINT while :; do latexmk -pdf -shell-escape -output-directory=/workdir/out main.tex; inotifywait /workdir; done