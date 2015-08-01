MATE SlackBuilds
================

This project provides SlackBuild scripts to build and install the MATE
desktop environment (http://www.mate-desktop.org) on Slackware Linux.
Please check the main project website at http://mateslackbuilds.github.io
for screenshots and more information.  There is also a link to MATE 1.10
binary packages for Slackware 14.1 and also older MATE packages for Slackware
14.0 and 14.1.

Please read GIT_BRANCHES.TXT to make sure you are on the right branch of
the MSB repo before attempting to build from the scripts.

After cloning the initial Git repo, you will be using 'master' branch which
will build the development branch for MATE desktop.  Building from the
development branch is not supported and may or may not work at any given
moment.  Most users will want to build from the stable branch which is MATE
version 1.10, released in June 2015.  Checkout that branch using 'git
checkout 14.1-mate-1.10' to build from the stable MSB branch.

The rest of this README.TXT is specific to building from the 'master'
branch.

How to build and install the MATE packages using these scripts:

1.  Clone the Git repo or download a tarball/zip of the repo.

2.  Run the 'mate-build-deps.sh' in the msb root directory which will build
and install all the necessary dependencies in the /deps directory. There are
a total of 29 packages. Please use "su" or "su -" to build as root instead
of using "sudo".

3.  Run the 'mate-build-base.sh' in the msb root directory which will build
and install all the base (required) packages. There are a total of 24 packages
and they do not replace any stock Slackware packages. The SlackBuilds will use
wget to download the sources.  Or, you can also manually download the
sources from: http://pub.mate-desktop.org/releases/1.10 and the download
locations for each dependency and put each source into the corresponding
directory within 'base' and 'deps'.

4.  Optionally, build and install any of the extra packages in the /extra
directory.  If you want to build and install them all, then you can use the
'mate-build-extra.sh' script in the msb root directory.  Otherwise, just go
into the directory of whatever package you want in /extra and run the
SlackBuild.  As with 'base', each SlackBuild will download the source.

5.  Once the base packages are built and installed, plus any from /extra,
you can use 'xwmconfig' to select the mate session.  Or, if you use KDM,
just log out and select MATE from the KDM session dialog.

6.  Check the 'startup applications' because there might be some duplicate
or conflicting entries.  For example, there will be an entry for
polkit-mate and polkit-gnome, the result of which might be duplicate
attempts at polkit actions when inserting a usb stick, for example.  You
may want to disable polkit-gnome and see if polkit-mate works by itself.
Also, if you use mate-power-manager then you might want to disable the Xfce
power manager if it is listed.

7.  Users running Slackware{64} -current are advised to read CURRENT.TXT.
It should also be noted that the target system for MATE SlackBuilds is a
full install of the latest official Slackware release.  It might run on a
less-than-full install and it might run on -current.  Or, it might not.
Neither of those are our official target systems.

8.  Enjoy and let us know of any issues.  Email is:
mateslackbuilds@gmail.com.

Thanks!

---
Chess Griffin
Willy Sudiarto Raharjo
