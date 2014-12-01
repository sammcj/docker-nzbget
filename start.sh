#! /bin/sh

set -e

[ ! -f /volumes/config/nzbget.conf ] && cp /usr/local/share/nzbget/nzbget.conf /volumes/config/nzbget.conf

nzbget --configfile /volumes/config/nzbget.conf --daemon
