# rpi-forked-daapd with spotify and mpd support

Run an iTunes server on your Raspberry Pi in a Docker container.

## Container variables

- **DAAPD_NAME** - name of the iTunes server, default 'My music on %h'
- **DAAPD_PORT** - port used, default 3689

## Container volumes

### Media files volume

The mount point of the media files in the container is `/media`, so you have to add a `-v /path/to/your/mediafiles:/media` switch.
This directory tree is also used for the pairing files `*.remote`

### Database volume

The forked-daapd server stores its data and minipics in a sqlite database. This should be stored outside of the container. Add a
`-v /path/to/dbfiles/stored/on/your/host:/var/cache/forked-daapd` switch.

## Build the container

```bash
docker build -t forked-daapd .
```

## Run the container

As the iTunes server depends on mDNS / avahi we need to start the container with connection to the host's network interface.

```bash
docker run -d --net host --name forked-daapd -v /home/media:/media -e DAAPD_NAME=Dockerized -v /home/localdb:/var/cache/forked-daapd forked-daapd
```

## Docker-Compose

```
docker-compose up -d
```

## open browser http://ip:3689

```
login admin
pass  usused
```

## Pair your iOS device with the iTunes server

1. Download the Remote app from the App Store.
2. Add a new iTunes-Mediathek, a four digit code will appear.
3. Now watch the output of the container with `docker logs forked-daapd`
4. Edit a file in your media folder on the host machine.
   - Put the name of the iOS device in the first line
   - Put the four digit code into the second line
   - save the file
5. Now the iOS device is paired with the iTunes server.

## Acknowledgements

This is based on StefanScherer/rpi-forked-daapd (https://github.com/StefanScherer/rpi-forked-daapd)

Many thanks to John Bintz's repo https://github.com/johnbintz/johns-docker-stuff for inspiration.

ssh pi@raspberrypi
login pi
pass raspberry

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y libssl-dev libffi-dev python-pip git-core
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
sudo usermod -aG docker pi

sudo apt autoremove -y --purge
sudo pip install docker-compose

wpasupplicant (2:2.6-19) unstable; urgency=medium

With this release, wpasupplicant no longer respects the system
default minimum TLS version, defaulting to TLSv1.0, not TLSv1.2. If
you're sure you will never connect to EAP networks requiring anything less
than 1.2, add this to your wpasupplicant configuration:

    tls_disable_tlsv1_0=1
    tls_disable_tlsv1_1=1

wpasupplicant also defaults to a security level 1, instead of the system
default 2. Should you need to change that, change this setting in your
wpasupplicant configuration:

    openssl_ciphers=DEFAULT@SECLEVEL=2

Unlike wpasupplicant, hostapd still respects system defaults.

also read
https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=49928

https://github.com/StefanScherer/logbook/blob/master/Install-forked-daapd-on-Raspberry-Pi.md

https://github.com/ejurgensen/forked-daapd

https://ejurgensen.github.io/forked-daapd/

https://github.com/ejurgensen/forked-daapd/blob/master/INSTALL
