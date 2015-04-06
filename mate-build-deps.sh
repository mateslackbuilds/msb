#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Copyright 2014 Willy Sudiarto Raharjo <willysr@slackware-id.org>
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

# This is where all the compilation and final results will be placed
TMP=${TMP:-/tmp}

# This is the original directory where you started this script
MSBROOT=$(pwd)

# Loop for all dependency packages
for dir in \
  deps/libgnomecanvas \
  deps/zenity \
  deps/rarian \
  deps/yelp-xsl \
  deps/yelp-tools \
  deps/libunique \
  deps/pangox-compat \
  deps/gtk-engines \
  deps/murrine \
  deps/pygobject3 \
  deps/gtksourceview \
  deps/pygtksourceview \
  deps/libgtop \
  deps/libgksu \
  deps/gksu \
  deps/gssdp \
  deps/gupnp \
  deps/libsigc++ \
  deps/glibmm \
  deps/cairomm \
  deps/pangomm \
  deps/atkmm \
  deps/mm-common \
  deps/gtkmm \
  deps/perl-xml-twig \
  deps/perl-net-dbus \
  deps/system-tools-backends \
  deps/liboobs \
  deps/docutils \
  ; do
  # Get the package name
  package=$(echo $dir | cut -f2- -d /)

  # Change to package directory
  cd $MSBROOT/$dir || exit 1

  # Get the version
  version=$(cat ${package}.SlackBuild | grep "VERSION:" | head -n1 | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # Get the build
  build=$(cat ${package}.SlackBuild | grep "BUILD:" | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # Check for duplicate sources
  sourcefile="$(ls -l $MSBROOT/$dir/${package}-*.tar.?z* 2>/dev/null | wc -l)"
  if [ $sourcefile -gt 1 ]; then
    echo "You have following duplicate sources:"
    ls $MSBROOT/$dir/${package}-*.tar.?z* | cut -d " " -f1
    echo "Please delete sources other than ${package}-$version to avoid problems"
    exit 1
  fi

  # The real build starts here
  sh ${package}.SlackBuild || exit 1
  if [ "$INST" = "1" ]; then
    PACKAGE=$(ls $TMP/${package}-${version}-*-${build}*.txz 2>/dev/null)
    if [ -f "$PACKAGE" ]; then
      upgradepkg --install-new --reinstall "$PACKAGE"
    else
      echo "Error:  package to upgrade "$PACKAGE" not found in $TMP"
      exit 1
    fi
  fi

  # back to original directory
  cd $MSBROOT
done
