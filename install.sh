#!/bin/sh

#    debumblebee. Service for Optimus graphics support.
#    Copyright (C) 2011  Igor Urazov
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

ARCH=`uname -m`

if [ -x "`which lsb_release`" ]; then
	echo "Unable to find lsb_release, which is usually a part of lsb package."
	echo "Please install it in your distro preferred way."
fi

git submodule init && git submodule update

if [ `lsb_release -i -s` = Debian -o `lsb_release -c -s` = debian ]; then
	DISTRO=DEBIAN
else
	echo "Sorry, your Linux distribuition isn't supported. Right now this script works only with" 1>&2
	echo "Debian and LinuxMint based on Debian." 1>&2
	echo "Please check INSTALL file for manual installation instructions." 1>&2
	exit 1
fi

if [ `lsb_release -r -s` = stable ]; then
	echo "Unfortunately this installer supports only Testing and Unstable distributions."
	echo "Feel free to implement stable support yourself and send patches."
	exit 1
fi

if [ `id -u` != 0 ]; then
	echo "This script should be started with root privileges." 1>&2
	exit 1
fi

echo "Welcome to the debumblebee installation v"`cat VERSION`"."
echo "This script will configure your system to utilize both Intel and nVidia graphics cards."
echo "Are you sure you want to proceed? (y/N)"
read ANSWER
case $ANSWER in
	y|Y) ;;
	*) exit 2 ;;
esac

cd install-files
case $DISTRO in
	DEBIAN) sh debian.install ;;
esac
if [ $? -ne 0 ]; then
	exit 1
fi

echo
echo "Installation complete."
echo "After reboot you should be able to start applications with \"optirun <application>\"."
echo "You may check the output of \"optirun glxgears -info\" for confirmation that installation was successfull.\n"
echo "                  https://github.com/z0rc3r/debumblebee\n"

exit 0
