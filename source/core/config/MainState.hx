package core.config;

import utils.Highscore;

class MainState extends MusicBeatState
{
	override function create()
	{
		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		super.create();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

		ClientPrefs.loadPrefs();

		Highscore.load();

		FlxG.mouse.visible = false;

		CoolUtil.switchState(new CustomState(CoolVars.data.initialState));
	}
}