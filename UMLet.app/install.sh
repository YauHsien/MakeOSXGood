#!/bin/bash
## prerequisites:
## * wget
## * awk
## * unzip
## * curl
## * makeicns
#
# download
FDownload=http://www.umlet.com/$(curl -s http://www.umlet.com/changes.htm | awk -F"New in <a href=\"" '{print $2}' | awk -F\" '{print $1}')
wget --unlink -O /tmp/umlet.zip $FDownload
unzip -o -d /tmp /tmp/umlet.zip
# install
SrcDir=/tmp/Umlet
TrgDir=/Applications/UMLet.app
Exe=$TrgDir/Contents/MacOS/umlet
plist=$TrgDir/Contents/Info.plist
mkdir -p $TrgDir/Contents
mkdir $TrgDir/Contents/MacOS
mkdir $TrgDir/Contents/Resources
# put Info.plist
echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>\\n\
\<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"\>\\n\
\<plist version=\"1.0\"\>\\n\
\<dict\>\\n\
  \<key\>CFBundleName\</key\>\\n\
  \<string\>UMLet\</string\>\\n\
  \<key\>CFBundleDisplayName\</key\>\\n\
  \<string\>UMLet - UML 編輯工具\</string\>\\n\
  \<key\>CFBundleIdentifier\</key\>\\n\
  \<string\>me.Custom.App.UMLet\</string\>\\n\
  \<key\>CFBundleVersion\</key\>\\n\
  \<string\>1.0\</string\>\\n\
  \<key\>CFBundlePackageType\</key\>\\n\
  \<string\>APPL\</string\>\\n\
  \<key\>CFBundleSignature\</key\>\\n\
  \<string\>ello\</string\>\\n\
  \<key\>CFBundleExecutable\</key\>\\n\
  \<string\>umlet\</string\>\\n\
  \<key\>CFBundleIconFile\</key\>\\n\
  \<string\>umlet_logo.icns\</string\>\\n\
\</dict\>\\n\
\</plist\> > $plist
# put executable
cp -R $SrcDir/* $TrgDir/Contents/MacOS/
touch $Exe
echo \#\!\/bin\/bash\\n\
if \[ \$\# -eq 1 \]\\n\
    then java -jar $TrgDir/Contents/MacOS/umlet.jar -filename=\"\$1\"\\n\
    else java -jar $TrgDir/Contents/MacOS/umlet.jar \"\$\@\"\\n\
fi >> $Exe
# put icon
makeicns -16 $SrcDir/img/umlet_logo16.png -20 $SrcDir/img/umlet_logo20.png -24 $SrcDir/img/umlet_logo24.png -32 $SrcDir/img/umlet_logo32.png -40 $SrcDir/img/umlet_logo40.png -48 $SrcDir/img/umlet_logo48.png -64 $SrcDir/img/umlet_logo64.png -in $SrcDir/img/umlet_logo.png -out $TrgDir/Contents/Resources/umlet_logo.icns
# config privilege
chmod 664 $plist
find $TrgDir/Contents/MacOS/ -type d -exec chmod 775 {} \;
find $TrgDir/Contents/MacOS/ -type f -exec chmod 664 {} \;
chmod 664 $TrgDir/Contents/Resources/umlet_logo.icns
chmod 775 $Exe
