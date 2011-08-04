#!/bin/sh

dkms remove -m acpi_call -v 0.0.1 --all
rm -rf /usr/src/acpi_call-0.0.1
