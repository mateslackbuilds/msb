#!/bin/sh

# Copyright 2012  Patrick J. Volkerding, Sebeka, Minnesota, USA
# All rights reserved.
#
# Copyright 2013 Chess Griffin <chess.griffin@gmail.com> Raleigh, NC
# Copyright 2013-2018 Willy Sudiarto Raharjo <willysr@slackware-id.org>
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
TMP=${TMP:-/tmp/msb}
OUTPUT=${OUTPUT:-/tmp}

# This is the original directory where you started this script
MSBROOT=$(pwd)

# Check for duplicate sources (default: OFF)
CHECKDUPLICATE=0

# Check md5 sums of the downloaded sources
CHECKMD5SUM=0


# Check for duplicate sources
function checkdups()
{
    sourcefile="$(ls -l $MSBROOT/$dir/${package}-*.tar.?z* 2>/dev/null | wc -l)"
    if [ $sourcefile -gt 1 ]; then
      echo "You have following duplicate sources:"
      ls $MSBROOT/$dir/${package}-*.tar.?z* | cut -d " " -f1
      echo "Please delete sources other than ${package}-$version to avoid problems"
      exit 1
    fi
}

# Install package
function install_package()
{
    PACKAGE=$(ls $OUTPUT/${package}-${version}-*-${build}*msb.txz 2>/dev/null)
    if [ -f "$PACKAGE" ]; then
      upgradepkg --install-new --reinstall "$PACKAGE"
    else
      echo "Error:  package to upgrade "$PACKAGE" not found in $OUTPUT"
      exit 1
    fi
}

# Check MD5Sum
function check_md5sum()
{
  WGET_DOWNLOAD=$(echo $DOWNLOAD | rev | cut -d/ -f1 | rev)
  NMD5SUM=$(md5sum $MSBROOT/$dir/$WGET_DOWNLOAD | awk '{print $1}')
  if [ "$NMD5SUM" == "$MD5SUM" ]; then
    echo "$WGET_DOWNLOAD md5 - OK!"
  else
    echo "$WGET_DOWNLOAD - md5sum ERROR!"
    exit 1
  fi
}


# Loop for all dependency packages
for dir in \
  deps/zenity \
  deps/graphviz \
  deps/vala \
  deps/rarian \
  deps/yelp-xsl \
  deps/yelp-tools \
  deps/libwnck3 \
  deps/libunique \
  deps/libunique3 \
  deps/pangox-compat \
  deps/gtk-engines \
  deps/murrine \
  deps/glade \
  deps/libpeas \
  deps/gtksourceview3 \
  deps/libgtop \
  deps/libgksu \
  deps/gksu \
  deps/gssdp \
  deps/gupnp \
  deps/libgxps \
  ; do
  # Get the package name
  package=$(echo $dir | cut -f2- -d /)

  # Change to package directory
  cd $MSBROOT/$dir || exit 1

  # Get the version
  version=$(grep "VERSION:" ${package}.SlackBuild | head -n1 | cut -d "-" -f2 | rev | cut -c 2- | rev)

  # Get the build
  build=$(grep "BUILD:" ${package}.SlackBuild | cut -d "-" -f2 | rev | cut -c 2- | rev)

  if [ $CHECKDUPLICATE -eq 1 ]; then
    checkdups
  fi

  # Download sources
  source "$MSBROOT/$dir/${package}.info" || exit 1
  wget -c $DOWNLOAD || exit 1
  # Check md5sum of the downloaded source
  if [ $CHECKMD5SUM -eq 1 ]; then
    check_md5sum
  fi

  # The real build starts here
  TMP=$TMP OUTPUT=$OUTPUT sh ${package}.SlackBuild || exit 1

  # Should we install the package?
  if [ "$INST" = "1" ]; then
    install_package
  fi

  # back to original directory
  cd $MSBROOT
done
