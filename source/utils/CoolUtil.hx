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

class CoolUtil
{
	public static var save:ALESave;

	inline public static function quantize(f:Float, snap:Float)
		return Math.fround(f * snap) / snap;

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	inline public static function coolTextFile(path:String):Array<String>
	{
		var daList:String = null;
		
		var formatted:Array<String> = path.split(':');

		path = formatted[formatted.length-1];

		if(FileSystem.exists(path))
			daList = File.getContent(path);

		return daList != null ? listFromString(daList) : [];
	}

	inline public static function colorFromString(color:String):FlxColor
	{
		var hideChars = ~/[\t\n\r]/;
		var color:String = hideChars.split(color).join('').trim();
		if(color.startsWith('0x')) color = color.substring(color.length - 6);

		var colorNum:Null<FlxColor> = FlxColor.fromString(color);
		if(colorNum == null) colorNum = FlxColor.fromString('#$color');
		return colorNum != null ? colorNum : FlxColor.WHITE;
	}

	inline public static function listFromString(string:String):Array<String>
	{
		var daList:Array<String> = [];
		daList = string.trim().split('\n');

		for (i in 0...daList.length)
			daList[i] = daList[i].trim();

		return daList;
	}

	public static function floorDecimal(value:Float, decimals:Int):Float
		return FlxMath.roundDecimal(value, decimals);

	inline public static function dominantColor(sprite:flixel.FlxSprite):Int
	{
		var countByColor:Map<Int, Int> = [];
		for(col in 0...sprite.frameWidth) {
			for(row in 0...sprite.frameHeight) {
				var colorOfThisPixel:Int = sprite.pixels.getPixel32(col, row);
				if(colorOfThisPixel != 0) {
					if(countByColor.exists(colorOfThisPixel))
						countByColor[colorOfThisPixel] = countByColor[colorOfThisPixel] + 1;
					else if(countByColor[colorOfThisPixel] != 13520687 - (2*13520687))
						countByColor[colorOfThisPixel] = 1;
				}
			}
		}

		var maxCount = 0;
		var maxKey:Int = 0; //after the loop this will store the max color
		countByColor[FlxColor.BLACK] = 0;
		for(key in countByColor.keys()) {
			if(countByColor[key] >= maxCount) {
				maxCount = countByColor[key];
				maxKey = key;
			}
		}
		countByColor = [];
		return maxKey;
	}

	inline public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max) dumbArray.push(i);

		return dumbArray;
	}

	inline public static function browserLoad(site:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	inline public static function openFolder(folder:String, absolute:Bool = false) {
		#if sys
			if(!absolute) folder =  Sys.getCwd() + '$folder';

			folder = folder.replace('/', '\\');
			if(folder.endsWith('/')) folder.substr(0, folder.length - 1);

			#if linux
			var command:String = '/usr/bin/xdg-open';
			#else
			var command:String = 'explorer.exe';
			#end
			Sys.command(command, [folder]);
			trace('$command $folder');
		#else
			FlxG.error("Platform is not supported for CoolUtil.openFolder");
		#end
	}

	@:access(flixel.util.FlxSave.validate)
	public static function getSavePath(modSupport:Bool = true):String
	{
		final company:String = FlxG.stage.application.meta.get('company');
		
		return company + '/' + flixel.util.FlxSave.validate(FlxG.stage.application.meta.get('file')) + (modSupport ? ((Mods.folder.trim() == '' ? '' : '/' + Mods.folder)) : '');
	}

	public static function setTextBorderFromString(text:FlxText, border:String)
	{
		switch(border.toLowerCase().trim())
		{
			case 'shadow':
				text.borderStyle = SHADOW;
			case 'outline':
				text.borderStyle = OUTLINE;
			case 'outline_fast', 'outlinefast':
				text.borderStyle = OUTLINE_FAST;
			default:
				text.borderStyle = NONE;
		}
	}

	public static function debugTrace(text:Dynamic, ?type:PrintType = TRACE, ?customType:String = '', ?customColor:FlxColor = FlxColor.GRAY, ?pos:haxe.PosInfos)
		Sys.println(ansiColorString(type == CUSTOM ? customType : PrintType.typeToString(type), type == CUSTOM ? customColor : PrintType.typeToColor(type)) + ansiColorString(' | ' + Date.now().toString().split(' ')[1] + ' | ', 0xFF505050) + (pos == null ? '' : ansiColorString(pos.fileName + ': ', 0xFF888888)) + text);
	
	public static function ansiColorString(text:String, color:FlxColor):String
		return '\x1b[38;2;' + color.red + ';' + color.green + ';' + color.blue + 'm' + text + '\x1b[0m';

	public static function createSafeThread(func:Void -> Void):Thread
	{
		return Thread.create(function()
		{
			try {
				func();
			} catch(e) {
				debugTrace(e.details(), ERROR);
			}
		});
	}

	public static function resetState()
	{
		CoolVars.skipTransOut = true;
		
		FlxG.resetState();
	}

    public static function switchState(state:flixel.FlxState, skipTransIn:Bool = null, skipTransOut:Bool = null)
    {
        if (state is CustomState)
        {
			var scriptName = cast(state, CustomState).scriptName;
			
            if (Paths.fileExists('scripts/states/' + scriptName + '.hx') || Paths.fileExists('scripts/states/' + scriptName + '.lua'))
                transitionSwitch(state, skipTransIn, skipTransOut);
            else
                debugTrace('Custom State called "' + scriptName + '" doesn\'t Exist', MISSING_FILE);
        } else {
			transitionSwitch(state, skipTransIn, skipTransOut);
		}
    }

	private static function transitionSwitch(state:flixel.FlxState, skipTransIn:Bool = null, skipTransOut:Bool = null)
	{
		if (skipTransIn != null)
			CoolVars.skipTransIn = skipTransIn;

		if (skipTransOut != null)
			CoolVars.skipTransOut = skipTransOut; 

        if (CoolVars.skipTransIn)
		{
            CoolVars.skipTransIn = false;

			FlxG.switchState(state);
		} else {
            #if cpp
			CoolUtil.openSubState(new CustomSubState(
				CoolVars.data.transition,
				null,
				[
					'transIn' => true,
					'transOut' => false,
					'finishCallback' => () -> { FlxG.switchState(state); }
				],
				[
					'transIn' => true,
					'transOut' => false,
					'finishCallback' => () -> { FlxG.switchState(state); }
				]
			));
			#end
		}
	}

	public static function openSubState(subState:flixel.FlxSubState = null)
	{
		if (subState == null)
			return;

        if (subState is CustomSubState)
        {
            var custom:CustomSubState = Std.downcast(subState, CustomSubState);
            
            if (Paths.fileExists('scripts/substates/' + custom.scriptName + '.hx') || Paths.fileExists('scripts/substates/' + custom.scriptName + '.lua'))
                FlxG.state.openSubState(subState);
            else
                debugTrace('Custom SubState called "' + custom.scriptName + '" doesn\'t Exist', MISSING_FILE);

            return;
        }

		FlxG.state.openSubState(subState);
	}

	public static function fpsLerp(v1:Float, v2:Float, ratio:Float):Float
		return FlxMath.lerp(v1, v2, fpsRatio(ratio));

	public static function fpsRatio(ratio:Float)
		return FlxMath.bound(ratio * FlxG.elapsed * 60, 0, 1);

	public static function snapNumber(og:Float, mod:Int):Float
		return Math.floor(og / mod) * mod;
	
	public static function colorFromArray(arr:Array<Int>):Int
    	return FlxColor.fromRGB(arr[0], arr[1], arr[2]);

	public static function reloadGameMetadata()
	{
		CoolVars.data = {
			developerMode: false,
			scriptsHotReloading: false,

			initialState: 'TitleState',
			freeplayState: 'FreeplayState',
			storyMenuState: 'StoryMenuState',
			masterEditorMenu: 'MasterEditorMenu',
			mainMenuState: 'MainMenuState',

			pauseSubState: 'PauseSubState',
			gameOverScreen: 'GameOverSubState',
			transition: 'FadeTransition',

			title: 'Friday Night Funkin\': ALE Engine',
			icon: 'appIcon',

			bpm: 102.0,

			discordID: '1309982575368077416',
		};

		try
		{
			if (Paths.fileExists('data.json'))
			{
				var json:Dynamic = Json.parse(File.getContent(Paths.getPath('data.json')));

				for (field in Reflect.fields(json))
					if (Reflect.hasField(CoolVars.data, field))
						Reflect.setField(CoolVars.data, field, Reflect.field(json, field));
			}
		} catch (error:Dynamic) {
			debugTrace('Error While Loading Game Data (data.json): ' + error, ERROR);
		}

		if (Paths.fileExists(CoolVars.data.icon + '.png'))
			Lib.current.stage.window.setIcon(Image.fromFile(Paths.getPath(CoolVars.data.icon + '.png')));
		else
			Lib.current.stage.window.setIcon(Image.fromFile(Paths.getPath('images/appIcon.png')));

        FlxG.stage.window.title = CoolVars.data.title;
	}

	public static function resizeGame(width:Int, height:Int, ?centerWindow:Bool = true)
	{
		FlxG.fullscreen = false;

		FlxG.initialWidth = width;
		FlxG.initialHeight = height;

		FlxG.resizeGame(width, height);

		FlxG.resizeWindow(width, height);

		if (centerWindow)
		{
			Lib.application.window.x = Std.int((Lib.application.window.display.bounds.width - Lib.application.window.width) / 2);
			Lib.application.window.y = Std.int((Lib.application.window.display.bounds.height - Lib.application.window.height) / 2);
		}

		for (camera in FlxG.cameras.list)
		{
			camera.width = width;
			camera.height = height;
		}
	}

	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		FlxG.sound.muteKeys = turnOn ? [FlxKey.M] : [];
		FlxG.sound.volumeDownKeys = turnOn ? [FlxKey.MINUS, FlxKey.NUMPADMINUS] : [];
		FlxG.sound.volumeUpKeys = turnOn ? [FlxKey.PLUS, FlxKey.NUMPADPLUS] : [];
	}

	public static function resetEngine():Void
	{
		CoolUtil.save.savePreferences();
		CoolUtil.save.saveControls();

		resizeGame(Main.game.width, Main.game.height);

		DiscordRPC.shutdown();

		CoolVars.skipTransIn = CoolVars.skipTransOut = true;

		if (ScriptState.instance != null)
			ScriptState.instance.destroyScripts();

		if (ScriptSubState.instance != null)
			ScriptSubState.instance.destroyScripts();

		if (FlxG.state.subState != null)
			FlxG.state.subState.close();

		for (key in CoolVars.globalVars.keys())
			CoolVars.globalVars.remove(key);

		FlxG.game.removeChild(MainState.debugCounter);
		
		MainState.debugCounter.destroy();
		MainState.debugCounter = null;

        #if (windows && cpp)
		cpp.WindowsAPI.setWindowBorderColor(255, 255, 255);
		#end

		FlxTween.globalManager.clear();

		FlxG.camera.bgColor = FlxColor.BLACK;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
			
			FlxG.sound.music = null;
		}

		FlxG.resetGame();
		
		#if desktop
		Mouse.cursor = ARROW;
		#end
	}
	
	public static function createRuntimeShader(shaderName:String):ALERuntimeShader
	{
		#if (!flash && sys)
		if (!ClientPrefs.data.shaders)
			return null;

		var frag:String = 'shaders/' + shaderName + '.frag';
		var vert:String = 'shaders/' + shaderName + '.vert';

		var found:Bool = false;

		if (Paths.fileExists(frag))
		{
			frag = File.getContent(Paths.getPath(frag));

			found = true;
		} else {
			frag = null;
		}

		if (Paths.fileExists(vert))
		{
			vert = File.getContent(Paths.getPath(vert));

			found = true;
		} else {
			vert = null;
		}

		if (found)
		{
			return new ALERuntimeShader(shaderName, frag, vert);
		} else {
			debugTrace('Missing Shader: ' + shaderName, MISSING_FILE);

			return null;
		}
		#else
		FlxG.log.warn('Platform Unsupported for Runtime Shaders');

		return null;
		#end
	}

	public static function setCameraShaders(camera:FlxCamera, shaders:Array<ALERuntimeShader>):Void
	{
		var filterArray:Array<BitmapFilter> = [];

		for (shader in shaders)
			filterArray.push(new ShaderFilter(shader));

		camera.filters = filterArray;
	}

	public static function formatToSongPath(string:String):String
		return string.trim().toLowerCase().replace(' ', '-');

	public static function loadPlayStateJSON(songJson:Dynamic)
	{
		if (songJson.gfVersion == null)
		{
			songJson.gfVersion = songJson.player3;

			songJson.player3 = null;
		}

		if (songJson.events == null)
		{
			songJson.events = [];
			
			for (secNum in 0...songJson.notes.length)
			{
				var sec:SwagSection = songJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;

				while (i < len)
				{
					var note:Array<Dynamic> = notes[i];

					if (note[1] < 0)
					{
						songJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}

					else i++;
				}
			}
		}
	}

	public static function loadPlayStateSong(name:String, difficulty:String, setSongRoute:Bool = true):PlayStateJSONData
	{
		var jsonData:SwagSong = null;

		var route:String = null;

		for (parentFolder in [Paths.modFolder(), 'assets'])
		{
			if (FileSystem.exists(parentFolder + '/songs') && FileSystem.isDirectory(parentFolder + '/songs'))
			{
				for (folder in FileSystem.readDirectory(parentFolder + '/songs'))
				{
					if (formatToSongPath(name) == formatToSongPath(folder))
					{
						if (FileSystem.exists(parentFolder + '/songs/' + folder + '/charts/' + difficulty + '.json'))
						{
							jsonData = cast Json.parse(sys.io.File.getContent(parentFolder + '/songs/' + folder + '/charts/' + difficulty + '.json')).song;
		
							route = folder;
						}
					}
				}
			}
		}

		loadPlayStateJSON(jsonData);

		if (jsonData == null)
			debugTrace(name + '/charts/' + difficulty + '.json', MISSING_FILE);

		return {
			route: route,
			json: jsonData
		};
	}

	public static function loadSong(name:String, difficulty:String, goToPlayState:Bool = true)
	{
		var data:PlayStateJSONData = loadPlayStateSong(name, difficulty);

		PlayState.SONG = data.json;
		PlayState.difficulty = difficulty;
		PlayState.songRoute = 'songs/' + data.route;
		PlayState.songName = data.route;

		if (goToPlayState && PlayState.SONG != null)
			switchState(new PlayState());
	}

	public static function loadWeek(weekName:String, names:Array<String>, difficulty:String, goToPlayState:Bool = true)
	{
		PlayState.playlist = names;
		PlayState.week = weekName;

		if (goToPlayState)
			loadSong(PlayState.playlist[0], difficulty);
	}
}