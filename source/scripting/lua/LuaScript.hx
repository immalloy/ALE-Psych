#if LUA_ALLOWED
package scripting.lua;

import utils.WeekData;
import utils.Highscore;
import utils.Song;

import openfl.Lib;
import openfl.utils.Assets;
import openfl.display.BitmapData;
import flixel.FlxBasic;
import flixel.FlxObject;

#if (!flash && sys)
import flixel.addons.display.FlxRuntimeShader;
#end

import funkin.visuals.cutscenes.DialogueBoxPsych;

import core.enums.ScriptType;

class LuaScript
{
	public var lua:State = null;
	public var scriptName:String = 'unknown';
	public var closed:Bool = false;

	public var callbacks:Map<String, Dynamic> = new Map<String, Dynamic>();
	public static var customFunctions:Map<String, Dynamic> = new Map<String, Dynamic>();

	public final type:ScriptType;

	public function new(scriptName:String, type:ScriptType)
	{
		lua = LuaL.newstate();

		LuaL.openlibs(lua);

		this.scriptName = scriptName.trim();

		try
		{
			var result:Dynamic = LuaL.dofile(lua, scriptName);

			var resultStr:String = Lua.tostring(lua, result);

			if (resultStr != null && result != 0)
			{
				trace(resultStr);

				#if windows
				lime.app.Application.current.window.alert(resultStr, 'Error on lua script!');
				#else
				trace('$scriptName\n$resultStr', true, false, FlxColor.RED);
				#end

				lua = null;

				return;
			}
		} catch(e:Dynamic) {
			trace(e);

			return;
		}

		this.type = type;
	}

	public var lastCalledFunction:String = '';

	public static var lastCalledScript:LuaScript = null;

	public function call(func:String, ?args:Array<Dynamic>):Dynamic
	{
		args = args ?? new Array<Dynamic>();

		if (closed)
			return LuaUtils.Function_Continue;

		lastCalledFunction = func;

		lastCalledScript = this;

		try
		{
			if (lua == null)
				return LuaUtils.Function_Continue;

			Lua.getglobal(lua, func);

			var type:Int = Lua.type(lua, -1);

			if (type != Lua.LUA_TFUNCTION)
			{
				if (type > Lua.LUA_TNIL)
					trace("ERROR (" + func + "): attempt to call a " + LuaUtils.typeToString(type) + " value", false, false, FlxColor.RED);

				Lua.pop(lua, 1);

				return LuaUtils.Function_Continue;
			}

			for (arg in args)
				Convert.toLua(lua, arg);

			var status:Int = Lua.pcall(lua, args.length, 1, 0);

			if (status != Lua.LUA_OK)
			{
				var error:String = getErrorMessage(status);

				trace("ERROR (" + func + "): " + error, false, false, FlxColor.RED);

				return LuaUtils.Function_Continue;
			}

			var result:Dynamic = cast Convert.fromLua(lua, -1);

			if (result == null)
				result = LuaUtils.Function_Continue;

			Lua.pop(lua, 1);

			if(closed)
				close();
			
			return result;
		} catch (e:Dynamic) {
			trace(e);
		}

		return LuaUtils.Function_Continue;
	}

	public function set(variable:String, data:Dynamic)
	{
		if (lua == null)
			return;

		Convert.toLua(lua, data);

		Lua.setglobal(lua, variable);
	}

	public function close()
	{
		closed = true;

		if(lua == null)
			return;
		
		Lua.close(lua);

		lua = null;
	}

	public function getErrorMessage(status:Int):String
	{
		var v:String = Lua.tostring(lua, -1);

		Lua.pop(lua, 1);

		if (v != null)
			v = v.trim();

		if (v == null || v == "")
		{
			return switch(status)
			{
				case Lua.LUA_ERRRUN: 
					"Runtime Error";
				case Lua.LUA_ERRMEM:
					"Memory Allocation Error";
				case Lua.LUA_ERRERR:
					"Critical Error";
				default:
					"Unknown Error"	;
			}
		}

		return v;

		return null;
	}

	public function setFunction(name:String, myFunction:Dynamic)
	{
		callbacks.set(name, myFunction);

		Lua_helper.add_callback(lua, name, null);
	}
}
#end