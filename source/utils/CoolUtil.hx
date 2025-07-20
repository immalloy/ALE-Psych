package utils;

import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;

import core.enums.PrintType;

import sys.thread.Thread;

class CoolUtil
{
	inline public static function quantize(f:Float, snap:Float){
		// changed so this actually works lol
		var m:Float = Math.fround(f * snap);
		//trace(snap);
		return (m / snap);
	}

	inline public static function capitalize(text:String)
		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();

	inline public static function coolTextFile(path:String):Array<String>
	{
		var daList:String = null;
		#if (sys && MODS_ALLOWED)
		var formatted:Array<String> = path.split(':'); //prevent "shared:", "preload:" and other library names on file path
		path = formatted[formatted.length-1];
		if(FileSystem.exists(path)) daList = File.getContent(path);
		#else
		if(Assets.exists(path)) daList = Assets.getText(path);
		#end
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
	{
		if(decimals < 1)
			return Math.floor(value);

		var tempMult:Float = 1;
		for (i in 0...decimals)
			tempMult *= 10;

		var newValue:Float = Math.floor(value * tempMult);
		return newValue / tempMult;
	}

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

	inline public static function browserLoad(site:String) {
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

	/**
		Helper Function to Fix Save Files for Flixel 5

		-- EDIT: [November 29, 2023] --

		this function is used to get the save path, period.
		since newer flixel versions are being enforced anyways.
		@crowplexus
	**/
	@:access(flixel.util.FlxSave.validate)
	inline public static function getSavePath():String {
		final company:String = FlxG.stage.application.meta.get('company');
		// #if (flixel < "5.0.0") return company; #else
		return '${company}/${flixel.util.FlxSave.validate(FlxG.stage.application.meta.get('file'))}';
		// #end
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
	{
		text = haxe.Log.formatOutput(text, pos);

		var theText:String = ansiColorString(type == CUSTOM ? customType : PrintType.typeToString(type), type == CUSTOM ? customColor : PrintType.typeToColor(type)) + ansiColorString(' | ' + Date.now().toString().split(' ')[1] + ' | ', 0xFF505050) + (pos == null ? '' : ansiColorString(pos.fileName + ': ', 0xFF888888)) + text;

		Sys.println(theText);
	}
	
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
		CoolVars.skipTransIn = CoolVars.skipTransOut = true;
		
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
            #if (cpp)
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
}
