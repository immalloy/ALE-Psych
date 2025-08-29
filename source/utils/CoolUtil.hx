package utils;

import flixel.input.keyboard.FlxKey;

@:build(core.macros.CoolMacro.build(
	[
		'utils.cool.ColorUtil',
		'utils.cool.EngineUtil',
		'utils.cool.FileUtil',
		'utils.cool.LogUtil',
		'utils.cool.MathUtil',
		'utils.cool.PlayStateUtil',
		'utils.cool.ShaderUtil',
		'utils.cool.StateUtil',
		'utils.cool.StringUtil',
		'utils.cool.SystemUtil'
	]
))
class CoolUtil
{
	public static var save:ALESave;

	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		FlxG.sound.muteKeys = turnOn ? [FlxKey.M] : [];
		FlxG.sound.volumeDownKeys = turnOn ? [FlxKey.MINUS, FlxKey.NUMPADMINUS] : [];
		FlxG.sound.volumeUpKeys = turnOn ? [FlxKey.PLUS, FlxKey.NUMPADPLUS] : [];
	}
}