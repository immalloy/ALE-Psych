package core.backend;

import flixel.util.FlxSave;

class Mods
{
	static public var folder:String = '';

    public static function init()
    {
		var save:FlxSave = new FlxSave();

		save.bind('ALEEngineData', CoolUtil.getSavePath(false));

        if (save != null)
            folder = save.data.currentMod;
    }
}