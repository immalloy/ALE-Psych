#!/bin/sh

cd ..

mkdir ~/haxelib && haxelib setup ~/haxelib

echo "Installing dependencies..."

haxelib install lime 8.2.2
haxelib run lime setup
haxelib install openfl 9.4.1
haxelib install flixel 5.6.1
haxelib install flixel-addons 3.2.3
haxelib install flixel-ui 2.6.1
haxelib install flixel-tools 1.5.1
haxelib install tjson 1.4.0
haxelib install hxCodec 2.6.1
haxelib install extension-androidtools 2.2.2 --skip-dependencies
haxelib git hxcpp https://github.com/AlejoGDOfficial/MobilePorting-hxcpp --skip-dependencies
haxelib git flxanimate https://github.com/ShadowMario/flxanimate dev
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit 633fcc051399afed6781dd60cbf30ed8c3fe2c5a
haxelib install hxdiscord_rpc 1.3.0 --skip-dependencies
haxelib install hxvlc 2.2.2 --skip-dependencies
haxelib git rulescript https://github.com/Kriptel/RuleScript bc0a01f8af468f01844545852faf8bac6e4caddc --skip-dependencies
haxelib git hscript https://github.com/HaxeFoundation/hscript 04e7d656b667f375bbe58ee10082aee2850a3f9c
haxelib install sl-windows-api 1.1.0

echo "Finished!"

read -p "Press enter to continue..."