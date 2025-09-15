package core.config;

import haxe.io.Path;

import flixel.FlxState;

import openfl.Lib;
import openfl.display.StageScaleMode;

import ale.ui.ALEUIUtils;

import hxluajit.wrapper.LuaError;

class MainState extends MusicBeatState
{
    #if mobile
    @:unreflective private static var showedModMenu:Bool = false;
    #end

	override function create()
	{
		LuaError.errorHandler = (e:String) -> {
			debugTrace(e, ERROR);
		};

		ALEUIUtils.color = FlxColor.fromRGB(50, 70, 100);
		ALEUIUtils.outlineColor = FlxColor.WHITE;
		ALEUIUtils.font = Paths.font('vcr.ttf');

		CoolVars.skipTransOut = true;

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];
	
		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end

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
		
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        #if mobile
        if (showedModMenu)
        {
        	CoolUtil.switchState(new CustomState(CoolVars.data.initialState), true, true);
        } else {
            MainState.showedModMenu = true;

            CoolUtil.openSubState(new funkin.substates.ModsMenuSubState());
		}
        #else
        CoolUtil.switchState(new CustomState(CoolVars.data.initialState), true, true);
        #end
		
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