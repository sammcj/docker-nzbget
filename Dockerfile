FROM debian:jessie
MAINTAINER Sam McLeod <https://github.com/sammcj>

# Set some variables (inc. nzbget version)
ENV LANG en_AU.UTF-8

RUN apt-get update && \
    apt-get install -qy build-essential pkg-config libxml2-dev libncurses5-dev libsigc++-2.0-dev libpar2-dev libssl-dev p7zip unrar-free locales nzbget

RUN locale-gen $LANG

EXPOSE 6789
VOLUME /volumes/config
VOLUME /volumes/media
VOLUME /volumes/downloads

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]
