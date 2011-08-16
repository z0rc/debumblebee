#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
mkdir /usr/src/acpi_call-0.0.1
cp $DIR/dkms.conf $DIR/src/* /usr/src/acpi_call-0.0.1
dkms add -m acpi_call -v 0.0.1
dkms build -m acpi_call -v 0.0.1
dkms install -m acpi_call -v 0.0.1
