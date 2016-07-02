# Copyright (c) 2015, Mikkel Kroman <mk@maero.dk>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
FROM debian:latest
MAINTAINER Mikkel Kroman <mk@maero.dk>

# Create the inspircd user and group.
RUN groupadd -r factorio && useradd -r -g factorio factorio

# Ensure that our package database is up to date.
RUN apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*

# Environment variables needed for download and verification of the package.
ENV FACTORIO_VERSION 0.13.3
ENV FACTORIO_DOWNLOAD_URL "https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64"
ENV FACTORIO_SHA256 "10fbe2968ecf79cb444abf2f0c043bd6294aa515ba430bc8c010d9c339e60cab"

# Download factorio.
RUN set -x \
  && rm -rf /var/apt/lists/* \
  && mkdir -p /srv/factorio \
  && curl -sSL "${FACTORIO_DOWNLOAD_URL}" -o factorio.tar.gz \
  && echo "${FACTORIO_SHA256} *factorio.tar.gz" | sha256sum -c - \
  && tar -xzf factorio.tar.gz -C /srv/factorio --strip-components=1 \
  && rm factorio.tar.gz && cd /srv/factorio

# Ensure that the /inspircd directory is owned by the inspircd user.
RUN chown factorio:factorio /srv/factorio

# Expose a volume to let the user provide saves.
VOLUME /srv/factorio/saves

# Expose the required network ports.
EXPOSE 34197

# Copy the entrypoint script and set it as our entry point.
USER factorio
WORKDIR /srv/factorio
ENTRYPOINT ["bin/x64/factorio"]
