MATE SlackBuilds
================

Here are some SlackBuild scripts to build and install the MATE desktop
environment on Slackware.  Currently, they build and install MATE 1.5 which is
the development branch of the upcoming 1.6 release, due at the end of March or
early April, 2013.

How to install:

1.  Clone the Git repo or download a tarball/zip of the repo and then go into
the 'base' directory.  Run the 'mate-build-base.sh' which will build and
install all the base (required) packages.  There are a total of 26 packages
and they do not replace any stock Slackware packages.  The SlackBuilds will
use wget to download the sources.  Or, you can also manually download the
sources from: http://pub.mate-desktop.org/releases/1.5/ and put each source
into the corresponding directory within 'base'.

2.  Optionally, go into the 'extra' directory and build and install any of the
extra packages.  If you want to build and install them all, then you can use
the 'mate-build-extra.sh' script.  Otherwise, just go into the directory of
whatever package you want and run the SlackBuild.  As with 'base', each
SlackBuild will download the source.

3.  Once the base packages are built and installed, plus any from /extra, you
can use 'xwmconfig' to select the mate session.  Or, if you use KDM, just log
out and select MATE from the KDM session dialog.

4.  Enjoy and let me know of any issues.  Thanks!
