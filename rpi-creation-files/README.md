# Create Raspberry Pi 4 Base Image (4GB)

These are instructions on how the Raspberry Pi (RPi) 4 Base image was created.  

## Start with Ubuntu Pre-configured Image from Ubuntu

1) Download a complete pre-configured image (Ubuntu 18.04.4, RPi 4, 64 bit) onto the SD Card. Below is an example of a version used previously, beware that the available versions can change.  Choose the latest version available.  Note: current download of RPi 4 and RPi 3 seem to be the same.
```
wget https://ubuntu.com/download/raspberry-pi/thank-you?version=18.04&versionPatch=.4&architecture=arm64+raspi3
```

2) Unpack image and change into the directory (unxz file, then tar xf)

3) Install image on SD card

## Installation of RIAPS Base Configuration on Pre-configured RPi

1) With the SD Card installed in the RPi, log into using ssh with user account being 'ubuntu'

```
Username:  ubuntu
Password:  ubuntu
Kernel:    5.3.0-1017-raspi2 #19~18.04.1-Ubuntu
```

2) Download and compress the [rpi-creation-files folder](https://github.com/RIAPS/riaps-integration/tree/master/rpi-creation-files) and transfer it to the RPi.

3) On the RPi, unpack the creation files and move into the folder

```
tar -xzvf rpi-creation-files.tar.gz
cd rpi-creation-files
```

4) Create a swapfile on the RPi to allow larger packages to run (such as spdlog).  Instructions used for this are at http://manpages.ubuntu.com/manpages/focal/man8/dphys-swapfile.8.htmls

    a) Apt install dphys-swapfile

    b) Edit /etc/dphys-swapfile to adjust default settings

```
CONF_SWAPFILE=/var/swap
CONF_SWAPSIZE=1024
CONF_MAXSWAP=2048
```

    c) Turn on swapfile

```
/sbin/dphys-swapfile setup
/sbin/dphys-swapfile swapon
```

5) Reboot the RPi and still sign in as 'ubuntu'

6) Move to 'root' user

```
sudo su
```

7) Add 'ubuntu' hostname to the /etc/hosts file. Add following line to the file.

```
127.0.0.1 ubuntu
```

8) Run the installation script. Provide the name of the ssh key pair added in step 5, your key filename can be any name desired. The 'tee' with a filename (and 2>&1) allows you to record the installation process and any errors received. If you have any issues during installation, this is a good file to send with your questions.

```
./base_rpi_bootstrap.sh 2>&1 | tee install-rpi.log
```

9) Remove install files from /home/ubuntu

10) Place the [RIAPS Install script](https://github.com/RIAPS/riaps-integration/blob/master/riaps-bbbruntime/riaps_install_bbb.sh) in /home/riaps/ to allow updating of the RIAPS platform by script

11) Optional:  Remove the swapfile.  If you want to compile large third party libraries on this platform later, leave the swapfile (it does cost file space).

```
/sbin/dphys-swapfile swapoff
```

12) Reboot RPi and sign in as 'riaps' user

13) Remove the 'ubuntu' user

```
sudo su
userdel -r ubuntu
```

14) Add the RIAPS packages to the BBBs by using the following command (on the BBB).

```bash
./riaps_install_bbb.sh 2>&1 | tee install-bbb-riaps.log
```


### Usage of BBB Image

Users of this image will ssh using the following:

```
Username:  riaps
Password:  riaps
```
