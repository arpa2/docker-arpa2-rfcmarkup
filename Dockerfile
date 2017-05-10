FROM arpa2:base

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y python-minimal rsync

RUN mkdir -p /var/www/ietf.org/rfc

# Bad, invasive, obnoxious -- please mount the volume to a shared place
# RUN rsync -avz rsync.ietf.org::rfc /var/www/ietf.org/rfc

COPY rfcmarkup.rvr   /usr/bin
COPY rfc2idx         /usr/bin
COPY ietf-rfc-update /usr/bin
COPY rfc-run         /usr/bin

EXPOSE 7059:7059

VOLUME ["/var/www/ietf.org"]

CMD rfc-run
