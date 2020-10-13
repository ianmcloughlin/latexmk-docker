FROM thomasweise/docker-texlive-full

RUN apt update \
    && apt upgrade -y \
    && apt install -y python3-pygments \
    && apt install -y gnuplot \
    && apt install -y git