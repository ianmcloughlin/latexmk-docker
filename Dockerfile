# Adapted from: https://raw.githubusercontent.com/thomasWeise/docker-texlive-full/master/image/Dockerfile
# That was adapted from: https://askubuntu.com/questions/129566

FROM thomasweise/docker-texlive-full

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Idea is based on: 
RUN    echo "Running update..." \
    && apt update \
    && echo "Avoiding docs..." \
    && printf 'path-exclude /usr/share/doc/*\npath-include /usr/share/doc/*/copyright\npath-exclude /usr/share/man/*\npath-exclude /usr/share/groff/*\npath-exclude /usr/share/info/*\npath-exclude /usr/share/lintian/*\npath-exclude /usr/share/linda/*\npath-exclude=/usr/share/locale/*' > /etc/dpkg/dpkg.cfg.d/01_nodoc \
    && rm -rf /usr/share/groff/* /usr/share/info/* \
    && rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/* \
    && rm -rf /usr/share/man \
    && mkdir -p /usr/share/man \
    && find /usr/share/doc -depth -type f ! -name copyright -delete \
    && find /usr/share/doc -type f -name "*.pdf" -delete \
    && find /usr/share/doc -type f -name "*.gz" -delete \
    && find /usr/share/doc -type f -name "*.tex" -delete \
    && (find /usr/share/doc -type d -empty -delete || true) \
    && mkdir -p /usr/share/doc \
    && mkdir -p /usr/share/info \
    && echo "Upgrading..." \
    && apt upgrade -y \
    && apt install --no-install-recommends -y python3-pygments \
    && apt install --no-install-recommends -y gnuplot \
    && apt install --no-install-recommends -y git \
    && echo "Deleting TeX sources..." \
    && (rm -rf /usr/share/texmf/source || true) \
    && (rm -rf /usr/share/texlive/texmf-dist/source || true) \
    && find /usr/share/texlive -type f -name "readme*.*" -delete \
    && find /usr/share/texlive -type f -name "README*.*" -delete \
    && (rm -rf /usr/share/texlive/release-texlive.txt || true) \
    && (rm -rf /usr/share/texlive/doc.html || true) \
    && (rm -rf /usr/share/texlive/index.html || true) \
    && echo "Updating font cache..." \
    && fc-cache -fv \
    && echo "Cleaning up temporary files..." \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /etc/ssh/ssh_host_* \
    && echo "Deleting man pages and documentation..." \
    && rm -rf /usr/share/man \
    && mkdir -p /usr/share/man \
    && find /usr/share/doc -depth -type f ! -name copyright -delete \
    && find /usr/share/doc -type f -name "*.pdf" -delete \
    && find /usr/share/doc -type f -name "*.gz" -delete \
    && find /usr/share/doc -type f -name "*.tex" -delete \
    && (find /usr/share/doc -type d -empty -delete || true) \
    && mkdir -p /usr/share/doc \
    && rm -rf /var/cache/apt/archives \
    && mkdir -p /var/cache/apt/archives \
    && rm -rf /tmp/* /var/tmp/* \
    && (find /usr/share/ -type f -empty -delete || true) \
    && (find /usr/share/ -type d -empty -delete || true) \
    && mkdir -p /usr/share/texmf/source \
    && mkdir -p /usr/share/texlive/texmf-dist/source \
    && echo "All done."
