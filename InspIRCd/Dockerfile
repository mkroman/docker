FROM debian:wheezy

MAINTAINER Mikkel Kroman <mk@maero.dk>

ADD https://github.com/inspircd/inspircd/archive/v2.0.18.tar.gz /src/

# Install InspIRCd.
RUN apt-get update && \
  useradd -r inspircd -d /srv/inspircd -s /bin/false && \
  apt-get install -y build-essential libgnutls-dev pkg-config && \
  cd /src && \
  tar xvzf v*.tar.gz && \
  cd inspircd-* && \
  ./configure --prefix=/srv/inspircd --uid inspircd --enable-gnutls --enable-epoll && \
  make && make install && \
  rm -rf /src && \
  apt-get purge -y build-essential libgnutls-dev pkg-config && apt-get autoremove -y && apt-get clean autoclean

USER inspircd
EXPOSE 6667 6697
ENTRYPOINT ["/srv/inspircd/inspircd", "start"]
