# Base docker image
FROM debian:sid
MAINTAINER Jessica Frazelle <jess@docker.com>

ADD  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /src/google-chrome-stable_current_amd64.deb

# Install Chromium
RUN sed -i.bak 's/sid main/sid main contrib non-free/g' /etc/apt/sources.list && \
    mkdir -p /usr/share/icons/hicolor && \
    apt-get update && apt-get install -y \
    ca-certificates \
    gconf-service \
    hicolor-icon-theme \
    libappindicator1 \
    libasound2 \
    libcanberra-gtk-module \
    libcurl3 \
    libexif-dev \
    libgconf-2-4 \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libv4l-0 \
    libxss1 \
    libxtst6 \
    wget \
    xdg-utils \
    --no-install-recommends && \
    dpkg -i '/src/google-chrome-stable_current_amd64.deb' && \
    apt-get install -y \
    pepperflashplugin-nonfree \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY local.conf /etc/fonts/local.conf

ADD . /slides

# Autorun chrome
ENTRYPOINT [ "/usr/bin/google-chrome-stable" ]
CMD [ "--user-data-dir=/data", "--no-sandbox", "file:///slides/index.html" ]
