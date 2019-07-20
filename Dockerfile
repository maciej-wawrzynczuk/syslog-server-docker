FROM debian:buster
MAINTAINER Maciej Wawrzynczuk <maciej.wawrzynczuk@gmail.com>
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections 
RUN apt-get update && apt-get upgrade && \
    apt-get install --yes apt-utils && \
    apt-get install --yes syslog-ng

RUN rm -rf /etc/syslog-ng/
COPY . /etc/
RUN find /etc/syslog-ng/ -type f -exec md5sum {} \;

EXPOSE 601
EXPOSE 514/udp
EXPOSE 514
EXPOSE 6514

ENTRYPOINT ["/usr/sbin/syslog-ng", "--no-caps", "--foreground", "--stderr", "--verbose"]
