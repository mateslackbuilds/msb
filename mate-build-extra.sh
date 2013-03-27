#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Copyright 2013 Chess Griffin <chess.griffin@gmail.com> Raleigh, NC
# All rights reserved.
#
# Based on the xfce-build-all.sh script by Patrick J. Volkerding
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Set to 1 if you'd like to install/upgrade package as they are built.
# This is recommended.
INST=1

TMP=${TMP:-/tmp}

MSBROOT=$(pwd)

for dir in \
  extra/libmatekeyring \
  extra/mate-keyring \
  extra/mate-applets \
  extra/mate-calc \
  extra/mate-character-map \
  extra/mate-document-viewer \
  extra/mate-file-archiver \
  extra/mate-file-manager-open-terminal \
  extra/mate-file-manager-image-converter \
  extra/mate-file-manager-sendto \
  extra/mate-icon-theme-faenza \
  extra/mate-image-viewer \
  extra/mate-media \
  extra/mate-menu-editor \
  extra/mate-power-manager \
  extra/mate-sensors-applet \
  extra/mate-terminal \
  deps/gtksourceview \
  extra/mate-text-editor \
    ; do
  package=$(echo $dir | cut -f2- -d /)
  cd $MSBROOT/$dir || exit 1
  sh ${package}.SlackBuild || ( touch /tmp/${package}.failed ; exit 1 ) || exit 1
  if [ "$INST" = "1" ]; then
    PACKAGE="$(ls -t $TMP/$(ls ${package}-*.tar.?z* | rev | cut -f2- -d - | rev)-*txz | head -n 1)"
    if [ -f $PACKAGE ]; then
      upgradepkg --install-new --reinstall $PACKAGE
    else
      echo "Error:  package to upgrade "$PACKAGE" not found in $TMP"
      exit 1
    fi
  fi
  cd $MSBROOT
done
