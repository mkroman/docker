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

# Create the atheme user and group.
RUN groupadd -r atheme && useradd -r -g atheme atheme

# Ensure that our package database is up to date.
RUN apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists*

# Grab gosu for simple step-down from root.
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV ATHEME_VERSION 7.9.2
ENV ATHEME_DOWNLOAD_URL "http://atheme.net/downloads/atheme-services-7.2.6.tar.bz2"
ENV ATHEME_SHA256 "c2805f50ac8ea05e35ae2cebb67b59dd5f8c2159ee7dea6842a85cab514b3ba2"

# Build and install Atheme.
RUN build_deps='gcc libc6-dev libssl-dev bzip2 pkg-config make' \
  set -x \
  && apt-get update && apt-get install -y ${build_deps} --no-install-recommends \
  && rm -rf /var/apt/lists* \
  && mkdir -p /usr/src/atheme \
  && curl -sSL "${ATHEME_DOWNLOAD_URL}" -o atheme.tar.bz2 \
  && echo "${ATHEME_SHA256} *atheme.tar.bz2" | sha256sum -c - \
  && tar -xjf atheme.tar.bz2 -C /usr/src/atheme --strip-components=1 \
  && rm atheme.tar.bz2 && cd /usr/src/atheme \
  && ./configure --prefix=/atheme --disable-nls \
  && make -j$(nproc) && make install \
  && rm -r /usr/src/atheme \
  && apt-get purge -y --auto-remove ${build_deps}

RUN chown atheme:atheme /atheme
VOLUME /atheme/etc
WORKDIR /atheme

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
