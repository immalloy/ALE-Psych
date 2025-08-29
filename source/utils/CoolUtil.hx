package utils;

import flixel.input.keyboard.FlxKey;

import core.Main;
import core.config.MainState;
import core.enums.PrintType;
import core.structures.PlayStateJSONData;

import utils.Song;
import utils.Section;

import sys.thread.Thread;

import openfl.Lib;
import openfl.filters.ShaderFilter;
import openfl.filters.BitmapFilter;
import openfl.ui.Mouse;
import openfl.utils.Assets;

import lime.graphics.Image;

import funkin.visuals.shaders.ALERuntimeShader;

@:build(core.macros.CoolMacro.build())
class CoolUtil
{
	public static var save:ALESave;

	/*
	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		FlxG.sound.muteKeys = turnOn ? [FlxKey.M] : [];
		FlxG.sound.volumeDownKeys = turnOn ? [FlxKey.MINUS, FlxKey.NUMPADMINUS] : [];
		FlxG.sound.volumeUpKeys = turnOn ? [FlxKey.PLUS, FlxKey.NUMPADPLUS] : [];
	}
		*/
}