@echo off
cd ..
@echo on
echo Installing dependencies

@if not exist ".haxelib\" mkdir .haxelib

echo Installing dependencies...

haxelib git lime https://github.com/ALE-Psych-Crew/lime
haxelib run lime setup
haxelib install openfl 9.4.1
haxelib install flixel 6.1.0
haxelib install flixel-addons 3.3.2
haxelib install flixel-ui 2.6.4
haxelib install flixel-tools 1.5.1
haxelib install tjson 1.4.0
haxelib install away3d 5.0.9 --skip-dependencies
haxelib install extension-androidtools 2.2.2 --skip-dependencies
haxelib git hxcpp https://github.com/AlejoGDOfficial/MobilePorting-hxcpp --skip-dependencies
haxelib git flxanimate https://github.com/Dot-Stuff/flxanimate 7da385ca7fd8d8067aac03bc39798d37c5598e45
haxelib install hxluajit 1.0.5 --skip-dependencies
haxelib install hxluajit-wrapper 1.0.0 --skip-dependencies
haxelib install hxdiscord_rpc 1.3.0 --skip-dependencies
haxelib install hxvlc 2.2.2 --skip-dependencies
haxelib git rulescript https://github.com/Kriptel/RuleScript f98bd260202ccafb150d698933158d2d4d3b8e3c --skip-dependencies
haxelib git hscript https://github.com/HaxeFoundation/hscript 92ffe9c519bbccf783df0b3400698c5b3cc645ef
haxelib git ale-ui https://github.com/ALE-Psych-Crew/ALE-UI --skip-dependencies
haxelib install sl-windows-api 1.1.0

echo Finished!
pause