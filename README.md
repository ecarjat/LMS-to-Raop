# LMS-to-Raop
LMS to AirPlay bridge

Allows AirPlay players to be used by Logitech Media Server, as a normal Logitech 
Hardware. It provides synchronisation, replaygain, gapless, fade in/out/cross and 
all other LMS goodies. AirPlay remotes can be used as well.

This is a FreeBSD/FreeNAS fork tested on FreeBSD 11.3.

Credit for the software should be given to https://github.com/philippe44 and the authors of the submodules.

Support thread of the original software is here: http://forums.slimdevices.com/showthread.php?105198-ANNOUNCE-AirPlay-Bridge-integrate-AirPlay-devices-with-LMS-(squeeze2raop)&p=846204&viewfull=1#post846204


##Compilation and instalation

###Create a buildhost
Create a jail for the buildhost. Alternatively this can be done on the jail used for LMS.
Change `NAME` below to your buildhost name

```
export NAME=buildhost
export RELEASE=11.3-RELEASE 
iocage create \
    -n $NAME \
    -r $RELEASE \
    boot=on \
    vnet=on \
    allow_tun=1 \
    dhcp=on
```

###Create a pool for the artefacts
Change `POOL` below to a pool name
Change `ART` to the volume you want to create 
```
export POOL=Pool1
export ART=artefacts

zfs create ${POOL}/${ART}
zfs set atime=off ${POOL}/${ART}
zfs set compression=on ${POOL}/${ART}
zfs set primarycache=metadata ${POOL}/${ART}
zfs set recordsize=16K ${POOL}/${ART}
```

Mount the volume in the jail, start the jail and console into it

```
export MNT=/mnt/${POOL}/${ART}
iocage exec ${NAME} -- mkdir /mnt/artefacts
iocage stop ${NAME}
iocage fstab ${NAME} --add ${MNT} /mnt/artefacts nullfs rw 0 0
iocage start ${NAME}
iocage console ${NAME}
```

### Install the pre-requisite software and build LMS-to-RAOP

From the jail console

```
pkg update
pkg install -y upnp libvorbis opus opusfile openssl alac libsoxr libmad faad2 cmake git flac mpg123

git clone --recursive https://github.com/ecarjat/LMS-to-Raop.git
cd LMS-to-Raop/
mkdir build
cd build
cmake ..
make
```

###Copy LMS-to-RAOP 
Copy the software to the artefact volume
From there it needs to be copied to the LMS jail

```
copy squeeze2raop /mnt/artefacts
```