#!/bin/sh

if [ `lsb_release -i -s` = Debian -o `lsb_release -c -s` = debian ]; then
        DISTRO=DEBIAN
else
        echo "Sorry, your Linux distribuition isn't supported. Right now this script works only with Debian." 1>&2
        exit 1
fi

if [ `id -u` != 0 ]; then
        echo "This script should be started with root privileges." 1>&2
        exit 1
fi

echo "Are you going to uninstall debumblebee? (Y/N)"
read ANSWER
case $ANSWER in
        y|Y) ;;
        *) exit 2 ;;
esac

cd install-files
case $DISTRO in
        DEBIAN) sh debian.uninstall ;;
esac
if [ $? -ne 0 ]; then
        exit 1
fi

echo
echo "Uninstallation finished."

exit 0
