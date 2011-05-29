#!/bin/sh

dkms uninstall -m acpi_call -v 0.0.1
dkms remove -m acpi_call -v 0.0.1
rm -rf /usr/src/acpi_call-0.0.1
