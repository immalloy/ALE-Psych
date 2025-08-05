package scripting.haxe;

import rulescript.RuleScript;
import rulescript.parsers.HxParser;

import haxe.ds.StringMap;
import haxe.Exception;

import scripting.haxe.HScriptImports;

import scripting.lua.LuaUtils;

class ALERuleScript extends RuleScript
{
	public var failedParsing:Bool = false;

	override public function new()
	{
		super();

		getParser(HxParser).allowAll();

		this.errorHandler = onError;

		preset();
	}

	public function onError(error:Exception):Dynamic
	{
		failedParsing = true;
		
		return error.details();
	}

	private function preset():Void
	{
		var presetClasses:Array<Class<Dynamic>> = [
			FlxG,
			FlxSound,
			flixel.FlxState,
			FlxSprite,
			FlxCamera,
			FlxMath,
			FlxTimer,
			FlxText,
			FlxEase,
			FlxTween,
			FlxSpriteGroup,
			flixel.group.FlxGroup.FlxTypedGroup,

			Array,
			String,
			Std,
			Math,
			Type,
			Reflect,
			Date,
			DateTools,
			Xml,
			EReg,
			Lambda,
			IntIterator,

			sys.io.Process,
			haxe.ds.StringMap,
			haxe.ds.IntMap,
			haxe.ds.EnumValueMap,
	
			File,
			FileSystem,
			Sys,
			Process,
	
			PlayState,
			CustomState,
			funkin.substates.CustomSubState,
			MusicBeatState,
			MusicBeatSubState,
			ScriptState,
			ScriptSubState,
			Conductor,
			DiscordRPC,
			Controls,
			ClientPrefs,
			CoolUtil,
			CoolVars,
			Paths,
	
			cpp.WindowsAPI
		];

        for (theClass in presetClasses)
            setClass(theClass);

		var presetVariables:StringMap<Dynamic> = [
			'FlxColor' => HScriptFlxColor,
			'FlxKey' => HScriptFlxKey,
			'Json' => utils.ALEJson,
			//'debugTrace' => CoolUtil.debugTrace,
			//'debugPrint' => CoolUtil.debugPrint,
			'controls' => Controls.instance,
			'Function_Stop' => LuaUtils.Function_Stop,
			'Function_Continue' => LuaUtils.Function_Continue,
			'Function_StopLua' => LuaUtils.Function_StopLua,
			'Function_StopHScript' => LuaUtils.Function_StopHScript,
			'Function_StopAll' => LuaUtils.Function_StopAll
		];

		for (preVar in presetVariables.keys())
			set(preVar, presetVariables.get(preVar));
	}

	public function call(func:String, ?args:Array<Dynamic>):Dynamic
	{
		var result:Dynamic = null;

		var func = variables.get(func);

		if (func != null && Reflect.isFunction(func))
		{
			try
			{
				result = Reflect.callMethod(null, func, args ?? []);
			} catch(error:Exception) {
				trace('HScript Error: ' + error.message);
			}
		}

		return result;
	}

	public function set(name:String, value:Dynamic)
		variables.set(name, value);

	public function setClass(cls:Class<Dynamic>)
	{
		set(Type.getClassName(cls).split('.').pop(), cls);
	}
}