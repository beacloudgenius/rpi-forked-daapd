FROM balenalib/rpi-raspbian:stretch
MAINTAINER Nilesh nilesh@cloudgeni.us
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get update && apt-get install  -y apt-transport-https
RUN rm -f /etc/apt/trusted.gpg~

RUN echo  "deb http://www.gyfgafguf.dk/raspbian/forked-daapd/ stretch contrib \ndeb http://apt.mopidy.com/ stable main contrib non-free" >> /etc/apt/sources.list

RUN curl -O http://www.gyfgafguf.dk/raspbian/forked-daapd.gpg
RUN apt-key add forked-daapd.gpg
RUN curl -O https://apt.mopidy.com/mopidy.gpg
RUN apt-key add mopidy.gpg

RUN apt-get update
RUN apt-get install --no-install-recommends -y avahi-utils libspotify-dev forked-daapd ruby
VOLUME /media
ADD forked-daapd.conf.erb /etc/forked-daapd.conf.erb
ADD start /usr/sbin/start
EXPOSE 3689
CMD ["bash", "/usr/sbin/start"]
