MATE SlackBuilds
================

This project provides SlackBuild scripts to build and install the MATE desktop
environment on Slackware (http://www.mate-desktop.org).  Please check the main
project website at http://mateslackbuilds.github.com for screenshots and more
information.  There is also a link to some MATE 1.6 binary packages for
Slackware 14.0.

Please read GIT_BRANCHES.TXT to make sure you are on the right branch of the
MSB repo before attempting to build from the scripts.  After cloning the
initial Git repo, you will be using 'master' branch which will build the
development branch of MATE 1.7.  Building from the development branch is not
supported and may or may not work at any given moment.  Most users will want
to build from the stable branch which is MATE version 1.6, released on April
2, 2013.  Checkout that branch using 'git checkout 1.6' to build from the
stable MSB branch.

The rest of this README.TXT is specific to building from the '1.6' branch.

How to build and install the MATE packages using these scripts:

1.  Clone the Git repo or download a tarball/zip of the repo.

2.  Run the 'mate-build-base.sh' in the msb root directory which will build
and install all the base (required) packages, including necessary dependencies
in the /deps directory.  There are a total of 24 packages and they do not
replace any stock Slackware packages. (If you are building on -current, then
dconf is already included in Slackware so you do not need it here in the git
repo -- see CURRENT.TXT).  The SlackBuilds will use wget to download the
sources.  Or, you can also manually download the sources from:
http://pub.mate-desktop.org/releases/1.6/ and the download locations for each
dependency and put each source into the corresponding directory within 'base'
and 'deps'.

3.  Optionally, build and install any of the extra packages in the /extra
directory.  If you want to build and install them all, then you can use the
'mate-build-extra.sh' script in the msb root directory.  Otherwise, just go
into the directory of whatever package you want in /extra and run the
SlackBuild.  As with 'base', each SlackBuild will download the source.

4.  Once the base packages are built and installed, plus any from /extra, you
can use 'xwmconfig' to select the mate session.  Or, if you use KDM, just log
out and select MATE from the KDM session dialog.

5.  Check the 'startup applications' because there might be some duplicate or
conflicting entries.  For example, there will be an entry for polkit-mate and
polkit-gnome, the result of which might be duplicate attempts at polkit
actions when inserting a usb stick, for example.  You may want to disable
polkit-gnome and see if polkit-mate works by itself.  Also, if you use
mate-power-manager from /extra then you might want to disable the Xfce power
manager if it is listed.  Same with mate-keyring from /extra - if you
installed that, you might want to disable the gnome-keyring entries.

6.  Users running Slackware{64}-Current are advised to read CURRENT.TXT.  It
should also be noted that the target system for MATE SlackBuilds is a full
install of the latest official Slackware release.  It might run on a
less-than-full install and it might run on -current.  Or, it might not.
Neither of those are our official target systems.

7.  Enjoy and let us know of any issues.  Email is: mateslackbuilds@gmail.com.
Thanks!
