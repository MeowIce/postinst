# PostInst - Post-Installation Scripts for Ubuntu and its derivatives.
## About 

I made this script to automatically install software and config your system. Unlike [snwh's scripts](https://github.com/snwh/ubuntu-post-install), my script is much more lighter and easier to use. You can use this to install and configure or maintain your Ubuntu install.
This script is freeware. You can redistribute it and/or mofity it the terms of the [GNU General Public License](https://github.com/MeowIce/postinst/blob/main/LICENSE). It came WITHOUT ANY WARRANTY !

## What does it do ?
1. Update the system
2. Config the system
    - Disable nouveau driver to install nVIDIA.
    - Disable App Crash Report.
    - Hide snap directory in home folder.
    - Fix `Install RELEASE` showing in Launcher/Dock.
    - Fix nVIDIA driver `libgtk-x11-2.0.so.0` error.
3. Cleanup the system
4. Optimize the system
5. Install media codecs, fonts and additional apps.
    - Install Media codecs.
    - Install MS Fonts
    - Install Emoji fonts.
    - Install `Font Manager` app.
    - Install Additional applications.
        - Web browsers
        - SSH/SFTP/FTP/Torrenting
        - Archive Manager
        - Media Player
        - Clipboard Manager

## Usage

To use this scriptset, simply run this command in the source folder:
```
./postinst.sh
```
