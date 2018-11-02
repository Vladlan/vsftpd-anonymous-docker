#!/bin/bash

set -eu

docker rm -f vsftpd-docker || true
docker build -t vsftpd-anonymous-upload-docker .
docker run -it --rm --name=vsftpd-docker -p 32021:21 -p 32022-32041:32022-32041 -v FtpVolume:/var/lib/ftp/incoming vsftpd-anonymous-upload-docker
# sleep 5

# Note ftp returns exit code 0 even if an error occurred
# ftp -n localhost 32021 << EOF
# user anonymous allowed@example.org
# passive
# cd incoming
# put test.sh
# quit
# EOF

# docker logs vsftpd-docker

# CHECK=$(docker exec vsftpd-docker find /var/lib/ftp/incoming | tr '\n' ' ')
# test "$CHECK" = '/var/lib/ftp/incoming /var/lib/ftp/incoming/test.sh '
# docker rm -f vsftpd-docker
