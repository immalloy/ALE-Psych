package core.config;

import haxe.io.Path;

import flixel.FlxState;

import funkin.debug.DebugCounter;

import openfl.Lib;
import openfl.display.StageScaleMode;

import ale.ui.ALEUIUtils;

class MainState extends MusicBeatState
{
	public static var debugCounter:DebugCounter;

	override function create()
	{
		ALEUIUtils.color = FlxColor.fromRGB(50, 70, 100);
		ALEUIUtils.outlineColor = FlxColor.WHITE;
		ALEUIUtils.font = Paths.font('vcr.ttf');

		CoolVars.skipTransOut = true;

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		super.create();

		core.backend.Mods.init();

		CoolUtil.reloadGameMetadata();

        DiscordRPC.initialize(CoolVars.data.discordID);
    
        if (CoolUtil.save != null)
			CoolUtil.save.destroy();

        CoolUtil.save = new utils.ALESave();

		CoolUtil.save.load();

		FlxG.mouse.useSystemCursor = true;
		
		#if HSCRIPT_ALLOWED
		scripting.haxe.HScriptConfig.config();
		#end

		MainState.debugCounter = new DebugCounter();
		FlxG.game.addChild(MainState.debugCounter);
		
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		CoolUtil.switchState(new CustomState(CoolVars.data.initialState), true, true);
		
		openalFix();
	}

    function openalFix()
    {
		#if desktop
		var origin:String = #if hl Sys.getCwd() #else Sys.programPath() #end;

		var configPath:String = Path.directory(Path.withoutExtension(origin));

		#if windows
		configPath += "/plugins/alsoft.ini";
		#elseif mac
		configPath = Path.directory(configPath) + "/Resources/plugins/alsoft.conf";
		#else
		configPath += "/plugins/alsoft.conf";
		#end

		Sys.putEnv("ALSOFT_CONF", configPath);
		#end	
    }
}