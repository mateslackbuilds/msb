MATE SlackBuilds
================

This project provides SlackBuild scripts to build and install the MATE
desktop environment (https://www.mate-desktop.org) on Slackware Linux.
Please check the main project website at https://mateslackbuilds.github.io
for screenshots and more information.  There is also a link to older MATE
binary packages for previous Slackware releases.

Please read GIT_BRANCHES.TXT to make sure you are on the right branch of
the MSB repo before attempting to build from the scripts.

After cloning the initial Git repo, you will be using 'master' branch which
will build the latest release or development branch for MATE desktop.
Building from the master branch is not supported and may or may not work at
any given moment. Most users will want to build from the stable branch which
is MATE version 1.28, released in February 2024.  Checkout that branch using 'git
checkout 15.0-mate-1.28' to build from the stable MSB branch.

The rest of this README.TXT is specific to building from the 'master'
branch which will build MATE 1.29, which is the development version of MATE.

How to build and install the MATE packages using these scripts:

1.  Clone the Git repo or download a tarball/zip of the repo.

2.  Run the 'mate-build-deps.sh' in the msb root directory which will build
and install all the necessary dependencies in the /deps directory.
Please use "su" or "su -" to build as root instead of using "sudo".

3.  Run the 'mate-build-base.sh' in the msb root directory which will build
and install all the base (required) packages. There are a total of 25 packages
and they do not replace any stock Slackware packages. The SlackBuilds will use
wget to download the sources.

4.  Optionally, build and install any of the extra packages in the /extra
directory.  If you want to build and install them all, then you can use the
'mate-build-extra.sh' script in the msb root directory.  Otherwise, just go
into the directory of whatever package you want in /extra and run the
SlackBuild.  As with 'base', each SlackBuild will download the source.

5.  Once all the packages are installed, you can 2 options of running MATE:

For users using runlevel 3:
you can use 'xwmconfig' to select the mate session if you are using X11.
If you prefer Wayland, you can run startmatewayland.

For users using runlevel 4:
You can use the default sddm (provided by Slackware's Plasma) or lightdm.
If you prefer to use lightdm, edit /etc/rc.d/rc.4 and add this code after
"Starting up X11 session manager..." line:

# Use lightdm (A Lightweight Desktop Manager)
if [ -x /usr/bin/lightdm ]; then
  exec /usr/bin/lightdm
fi

For lightdm greeters, we provides 2 variants, slick and gtk
For default, we uses slick:
If you wish to change to gtk, edit /etc/lightdm/lightdm.conf and change
this line:
greeter-session=lightdm-slick-greeter
into
greeter-session=lightdm-gtk-greeter
and reboot

6.  Check the 'startup applications' because there might be some duplicate
or conflicting entries.  For example, there will be an entry for
polkit-mate and polkit-gnome, the result of which might be duplicate
attempts at polkit actions when inserting a usb stick, for example.  You
may want to disable polkit-gnome and see if polkit-mate works by itself.
Also, if you use mate-power-manager then you might want to disable the Xfce
power manager if it is listed.

7. Check the 'preferred applications' in System > Preferences > Personal 
menu to make sure you use the correct application. eg. caja for File Manager
instead of audacious.

8.  Users running Slackware{64} -current are advised to read CURRENT.TXT.
It should also be noted that the target system for MATE SlackBuilds is a
full install of the latest official Slackware release.  It might run on a
less-than-full install and it might run on -current.  Or, it might not.
Neither of those are our official target systems.

9.  Enjoy and let me know of any issues. Contact us at mateslackbuilds@gmail.com
or send PR via github/gitlab.

Thanks!

---
Willy Sudiarto Raharjo
