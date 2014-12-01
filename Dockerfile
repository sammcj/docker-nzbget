FROM ubuntu:14.04
MAINTAINER J.R. Arseneau <https://github.com/jrarseneau>

# Set some variables (inc. nzbget version)
ENV LANG en_US.UTF-8
ENV VERSION 14.1

RUN locale-gen $LANG

# To get rid of error messages like "debconf: unable to initialize frontend: Dialog":
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy build-essential pkg-config libxml2-dev libncurses5-dev libsigc++-2.0-dev libpar2-dev libssl-dev p7zip unrar

ADD http://downloads.sourceforge.net/project/nzbget/nzbget-stable/$VERSION/nzbget-$VERSION.tar.gz /tmp/nzbget.tar.gz
RUN tar xf /tmp/nzbget.tar.gz && \
    rm /tmp/nzbget.tar.gz && \
    cd /nzbget-$VERSION && \
    ./configure && \
    make && \
    make install && \
    rm -rf /nzbget-$VERSION

EXPOSE 6789
VOLUME /volumes/config
VOLUME /volumes/media
VOLUME /volumes/downloads

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]
