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
FROM debian
MAINTAINER Mikkel Kroman <mk@maero.dk>

# Create the inspircd user and group.
RUN groupadd -r inspircd && useradd -r -g inspircd inspircd

# Ensure that our package database is up to date.
RUN apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*

# Environment variables needed for download and verification of the package.
ENV INSPIRCD_VERSION 2.0.20
ENV INSPIRCD_DOWNLOAD_URL "https://github.com/inspircd/inspircd/archive/v${INSPIRCD_VERSION}.tar.gz"
ENV INSPIRCD_SHA256 "5156e2da5da4cfa377705ecd633aee41cdcd785d12627497d55cab5f70dd686f"

# Build and install InspIRCd.
RUN build_deps='gcc libc6-dev make libgnutls28-dev pkg-config libfile-copy-link-perl g++' \
  set -x \
  && apt-get update && apt-get install -y ${build_deps} --no-install-recommends \
  && rm -rf /var/apt/lists/* \
  && mkdir -p /usr/src/inspircd \
  && curl -sSL "${INSPIRCD_DOWNLOAD_URL}" -o inspircd.tar.gz \
  && echo "${INSPIRCD_SHA256} *inspircd.tar.gz" | sha256sum -c - \
  && tar -xzf inspircd.tar.gz -C /usr/src/inspircd --strip-components=1 \
  && rm inspircd.tar.gz && cd /usr/src/inspircd \
  && ./configure --prefix=/inspircd --enable-gnutls --enable-epoll --uid inspircd \
  && make -j$(nproc) && make install \
  && rm -r /usr/src/inspircd \
  && apt-get purge -y --auto-remove ${build_deps}

# Ensure that the /inspircd directory is owned by the inspircd user.
RUN chown inspircd:inspircd /inspircd

# Expose a volume to let the user provide configuration.
VOLUME /inspircd/conf

# Expose the required network ports.
#
# 6667 is commonly used for plain (insecure) connections.
# 6697 is commonly used for secure (SSL/TLS) connections.
# 7777 can be used for services.
EXPOSE 6667 6697 7777

# Copy the entrypoint script and set it as our entry point.
WORKDIR /inspircd
ENTRYPOINT ["bin/inspircd", "--nofork"]
