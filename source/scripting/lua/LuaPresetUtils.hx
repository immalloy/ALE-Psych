package scripting.lua;

import flixel.util.FlxSave;

import haxe.Constraints;

using StringTools;

class LuaPresetUtils
{
    @:allow(scripting.lua.callbacks.LuaReflect)
    private static var instanceStr:String = '##LUA_STRING_TO_OBJ##';

    public static function applyProps(obj:Dynamic, props:Dynamic)
    {
        var fields = Reflect.fields(props);

        for (key in fields)
        {
            var value:Dynamic = Reflect.field(props, key);

            if (Reflect.fields(value).length > 0)
            {
                var subObj = Reflect.field(obj, key) ?? Reflect.getProperty(obj, key);

                applyProps(subObj, value);
            } else {
                Reflect.setProperty(obj, key, value);
            }
        }
    }

    public static function getVarInArray(lua:LuaScript, instance:Dynamic, variable:String, allowMaps:Bool = false):Any
    {
        var splitProps:Array<String> = variable.split('.');

        if (splitProps.length > 1)
        {
            var target:Dynamic = null;

            if (lua.variables.exists(splitProps[0]))
            {
                var retVal:Dynamic = lua.variables.get(splitProps[0]);

                if (retVal != null)
                    target = retVal;
            } else {
                target = Reflect.getProperty(instance, splitProps[0]);
            }

            for (i in 1...splitProps.length)
            {
                var j:Dynamic = splitProps[i].substr(0, splitProps[i].length - 1);

                target = target[j];
            }

            return target;
        }
        
        if (allowMaps && isMap(instance))
            return instance.get(variable);

        if (lua.variables.exists(variable))
        {
            var retVal:Dynamic = lua.variables.get(variable);

            if (retVal != null)
                return retVal;
        }

        return Reflect.getProperty(instance, variable);
    }

    public static function parseVariable(lua:LuaScript, vars:String)
    {
        var variables:Array<String> = vars.split('.');

        var prop:Dynamic = getObjectDirectly(lua, variables[0]);

        if (variables.length > 1)
            prop = getVarInArray(lua, getPropertyLoop(lua, variables), variables[variables.length - 1]);

        return prop;
    }
    
    public static function parseInstances(lua, args:Array<Dynamic>)
    {
        args = args ?? [];

        for (i in 0...args.length)
        {
            var myArg:String = cast args[i];

            if (myArg != null && myArg.length > instanceStr.length)
            {
                var index:Int = myArg.indexOf('::');

                if (index > -1)
                {
                    myArg = myArg.substring(index + 2);

                    var lastIndex:Int = myArg.lastIndexOf('::');

                    var split:Array<String> = myArg.split('.');

                    args[i] = (lastIndex > -1) ? Type.resolveClass(myArg.substring(0, lastIndex)) : FlxG.state;

                    for (j in 0...split.length)
                        args[i] = getVarInArray(lua, args[i], split[j].trim());
                }
            }
        }

        return args;
    }

    public static function callMethodFromObject(lua:LuaScript, classObj:Dynamic, funcStr:String, args:Array<Dynamic> = null)
    {
        if (args == null)
            args = [];

        var split:Array<String> = funcStr.split('.');

        var funcToRun:Function = null;

        var obj:Dynamic = classObj;
        
        if (obj == null)
            return null;

        for (i in 0...split.length)
            obj = getVarInArray(lua, obj, split[i].trim());

        funcToRun = cast obj;
        
        return funcToRun != null ? Reflect.callMethod(obj, funcToRun, args) : null;
    }

    public static function setVarInArray(lua:LuaScript, instance:Dynamic, variable:String, value:Dynamic, allowMaps:Bool = false):Any
    {
        var splitProps:Array<String> = variable.split('.');

        if (allowMaps && isMap(instance))
        {
            instance.set(variable, value);

            return value;
        }

        if (lua.variables.exists(variable))
        {
            lua.variables.set(variable, value);

            return value;
        }

        Reflect.setProperty(instance, variable, value);

        return value;
    }

	public static function setGroupStuff(leArray:Dynamic, variable:String, value:Dynamic, ?allowMaps:Bool = false) {
		var split:Array<String> = variable.split('.');

		if (split.length > 1)
        {
			var obj:Dynamic = Reflect.getProperty(leArray, split[0]);

			for (i in 1...split.length-1)
				obj = Reflect.getProperty(obj, split[i]);

			leArray = obj;

			variable = split[split.length-1];
		}

		if (allowMaps && isMap(leArray))
            leArray.set(variable, value);
		else
            Reflect.setProperty(leArray, variable, value);

		return value;
	}

	public static function getGroupStuff(leArray:Dynamic, variable:String, ?allowMaps:Bool = false) {
		var split:Array<String> = variable.split('.');

		if (split.length > 1)
        {
			var obj:Dynamic = Reflect.getProperty(leArray, split[0]);

			for (i in 1...split.length-1)
				obj = Reflect.getProperty(obj, split[i]);

			leArray = obj;

			variable = split[split.length-1];
		}

		if (allowMaps && isMap(leArray))
            return leArray.get(variable);

		return Reflect.getProperty(leArray, variable);
	}

	public static function getPropertyLoop(lua:LuaScript, split:Array<String>, ?getProperty:Bool=true, ?allowMaps:Bool = false):Dynamic
	{
		var obj:Dynamic = getObjectDirectly(lua, split[0]);

		var end = split.length;

		if (getProperty)
            end = split.length-1;

		for (i in 1...end)
            obj = getVarInArray(lua, obj, split[i], allowMaps);

		return obj;
	}

	public static function isMap(variable:Dynamic)
	{
		if (variable.exists != null && variable.keyValueIterator != null)
            return true;

		return false;
	}

	public static function getObjectDirectly(lua:LuaScript, objectName:String, ?allowMaps:Bool = false):Dynamic
	{
		switch(objectName)
		{
			case 'game':
				return lua.type == STATE ? FlxG.state : ScriptSubState.instance;
			
			default:
				var obj:Dynamic = lua.variables.get(objectName);

				if (obj == null)
                    obj = getVarInArray(lua, lua.type == STATE ? FlxG.state : FlxG.state.subState, objectName, allowMaps);

				return obj;
		}
	}

	public static function formatVariable(tag:String)
    {
		return tag.trim().replace(' ', '_').replace('.', '');
    }

    public static function cameraFromString(lua:LuaScript, name:String):Null<FlxCamera>
    {
        var result:FlxCamera = switch (name.toLowerCase())
        {
            case 'game', 'camera', 'camgame':
                FlxG.camera;
            case 'hud', 'camhud':
                ScriptState.instance.camHUD;
            default:
                null;
        };

        return result ?? (Std.is(lua.variables.get(name), FlxCamera) ? lua.variables.get(name) : null);
    }
}