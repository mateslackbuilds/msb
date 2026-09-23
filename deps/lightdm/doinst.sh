#!/bin/bash

if ! getent group lightdm 1>/dev/null 2>/dev/null ; then
  groupadd -g 380 lightdm
elif ! getent passwd lightdm 1>/dev/null 2>/dev/null ; then
  useradd -d /var/lib/lightdm -s /bin/false -u 380 -g 380 lightdm
fi
