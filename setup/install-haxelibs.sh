#!/bin/sh

cd ..

mkdir ~/haxelib && haxelib setup ~/haxelib

echo "Installing dependencies..."

haxelib git lime https://github.com/ALE-Psych-Crew/lime
haxelib run lime setup
haxelib install openfl 9.4.1
haxelib install flixel 6.1.0
haxelib install flixel-addons 3.3.2
haxelib install flixel-ui 2.6.4
haxelib install flixel-tools 1.5.1
haxelib install tjson 1.4.0
haxelib install away3d 5.0.9
haxelib install extension-androidtools 2.2.2 --skip-dependencies
haxelib git hxcpp https://github.com/AlejoGDOfficial/MobilePorting-hxcpp --skip-dependencies
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 7da385ca7fd8d8067aac03bc39798d37c5598e45
haxelib install hxluajit 1.0.5 --skip-dependencies
haxelib install hxluajit-wrapper 1.0.0 --skip-dependencies
haxelib install hxdiscord_rpc 1.3.0 --skip-dependencies
haxelib install hxvlc 2.2.2 --skip-dependencies
haxelib git rulescript https://github.com/Kriptel/RuleScript 0e9b657ef8c01942724de3a6bf4e56da9cc6f7a8 --skip-dependencies
haxelib git hscript https://github.com/HaxeFoundation/hscript 04e7d656b667f375bbe58ee10082aee2850a3f9c
haxelib git ale-ui https://github.com/ALE-Psych-Crew/ALE-UI --skip-dependencies
haxelib install sl-windows-api 1.1.0

echo "Finished!"