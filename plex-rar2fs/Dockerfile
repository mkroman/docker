# This is a Dockerfile for the Plex Media Server with rar2fs support.

# Import the plex image
FROM timhaak/plex

# Set the maintainer of this image
MAINTAINER Mikkel Kroman <mk@maero.dk>

RUN apt-get update && apt-get install -y wget build-essential libfuse2 libfuse-dev && \
  mkdir /src && cd /src && \
  wget "https://docs.google.com/uc?export=download&id=0B-2uEqYiZg3zR1F0b0tmRktiaXc" -O rar2fs.tar.gz && \
  wget "http://www.rarlab.com/rar/unrarsrc-5.2.3.tar.gz" && \
  tar xvzf unrarsrc-5.2.3.tar.gz && cd unrar && \
  make lib && make install-lib && cd /src && \
  tar xvzf rar2fs.tar.gz && cd rar2fs-* && \
  ./configure --with-unrar=../unrar --prefix=/usr && \
  make && make install && \
  cd /src && rm -rf *.tar.gz unrar/ rar2fs-*/ && \
  apt-get remove -y build-essential libfuse-dev && apt-get autoremove -y && apt-get clean

CMD rar2fs /data /data_unrared && ./start
