MATE SlackBuilds
================

Here are some SlackBuild scripts to build and install the MATE desktop
environment on Slackware.  Currently, they build and install MATE 1.5 which is
the development branch of the upcoming 1.6 release, due at the end of March or
early April, 2013.

How to install:

1.  Clone the Git repo or download a tarball/zip of the repo. Run the
'mate-build-base.sh' in the msb root directory which will build and install
all the base (required) packages.  Note, there are also some dependencies in
the /deps directory.  There are a total of 25 packages and they
do not replace any stock Slackware packages.  The SlackBuilds will use wget to
download the sources.  Or, you can also manually download the sources from:
http://pub.mate-desktop.org/releases/1.5/ and the download locations for each
dependency and put each source into the corresponding directory within 'base'
and 'deps'.

2.  Optionally, build and install any of the extra packages in the /extra
directory.  If you want to build and install them all, then you can use the
'mate-build-extra.sh' script in the msb root directory.  Otherwise, just go
into the directory of whatever package you want in /extra and run the
SlackBuild.  As with 'base', each SlackBuild will download the source.

3.  Once the base packages are built and installed, plus any from /extra, you
can use 'xwmconfig' to select the mate session.  Or, if you use KDM, just log
out and select MATE from the KDM session dialog.

4.  Check the 'startup applications' because there might be some duplicate or
conflicting entries.  For example, there will be an entry for polkit-mate and
polkit-gnome, the result of which might be duplicate attempts at polkit
actions when inserting a usb stick, for example.  You may want to disable
polkit-gnome and see if polkit-mate works by itself.  Also, if you use
mate-power-manager from /extra then you might want to disable the Xfce power
manager if it is listed.  Same with mate-keyring from /extra - if you
installed that, you might want to disable the gnome-keyring entries.

5.  Enjoy and let me know of any issues.  Thanks!
