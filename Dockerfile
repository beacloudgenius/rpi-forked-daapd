FROM resin/rpi-raspbian
MAINTAINER steffen <devnull@snizzle.org>
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN echo  "\n deb http://www.gyfgafguf.dk/raspbian jessie/armhf/ \n deb http://apt.mopidy.com/ stable main contrib non-free" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install --no-install-recommends -y avahi-utils libspotify-dev forked-daapd ruby
VOLUME /media
ADD forked-daapd.conf.erb /etc/forked-daapd.conf.erb
ADD start /usr/sbin/start
EXPOSE 3689
CMD ["bash", "/usr/sbin/start"]
