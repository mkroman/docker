FROM debian:wheezy

MAINTAINER Mikkel Kroman <mk@maero.dk>

ENV INSPIRCD_VERSION 2.0.18

# Install InspIRCd.
RUN apt-get update && \
  useradd -r inspircd -d /inspircd -s /bin/false && \
  apt-get install -y build-essential wget libgnutls-dev pkg-config && \
  mkdir /src && cd /src && \
  wget --no-check-certificate https://github.com/inspircd/inspircd/archive/v${INSPIRCD_VERSION}.tar.gz && \
  tar xvzf v${INSPIRCD_VERSION}.tar.gz && \
  cd inspircd-* && \
  ./configure --prefix=/inspircd --uid inspircd --enable-gnutls --enable-epoll && \
  make && make install && \
  rm -rf /src && \
  apt-get purge -y gcc g++ perl build-essential libgnutls-dev wget pkg-config \
    binutils cpp patch *-dev libc-bin libc-dev-bin && \
  apt-get autoremove -y && apt-get clean autoclean

VOLUME ["/inspircd/conf", "/inspircd/data"]
USER inspircd
EXPOSE 6667 6697
ENTRYPOINT ["/inspircd/inspircd", "start"]
