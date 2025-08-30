package scripting.lua;

import haxe.ds.StringMap;

import core.enums.ScriptType;

class LuaPresetBase
{
    public var variables:StringMap<Dynamic>;

    public var lua:LuaScript;

    public var type:ScriptType;

    public function new(lua:LuaScript)
    {
        this.lua = lua;
        
        this.type = lua.type;

        variables = lua.variables;
    }

    public inline function set(name:String, value:Dynamic)
    {
        if (Reflect.isFunction(value))
            lua.setFunction(name, value);
        else
            lua.set(name, value);
    }

    public inline function errorPrint(text:String)
    {
        /*
        if (type == STATE)
            ScriptState.instance.debugPrint(text, ERROR);
        else
            ScriptSubState.instance.debugPrint(text, ERROR);
        */

        debugTrace(text, ERROR);
    }

    public inline function deprecatedPrint(text:String)
    {
        /*
        if (type == STATE)
            ScriptState.instance.debugPrint(text, DEPRECATED);
        else
            ScriptSubState.instance.debugPrint(text, DEPRECATED);
        */

        debugTrace(text, DEPRECATED);
    }

    public function getTag(tag:String):Dynamic
    {
        var split:Array<String> = tag.split('.');

        var instance:Dynamic = variables.get(split[0]);

        if (instance == null)
            instance = type == STATE ? FlxG.state : FlxG.state.subState;
        else
            split.shift();

        var result:Dynamic = tag.length > 0 ? getRecursiveProperty(instance, split) : instance;

        if (result == null)
            errorPrint('There is no Object with this Tag "' + tag + '"');

        return result;
    }

    public inline function tagIs(name:String, type:Dynamic):Bool
    {
        var result:Bool = Std.isOfType(getTag(name), type);

        if (!result)
            errorPrint(name + ':' + Type.getClassName(Type.getClass(getTag(name))) + ' should be ' + name + ':' + Type.getClassName(type));
        
        return result;
    }

    public inline function setTag(name:String, value:Dynamic)
    {
        if (variables.exists(name))
            errorPrint('There is already an object with the tag "' + name + '"');
        else
            variables.set(name, value);
    }

    public inline function removeTag(name:String)
    {
        if (variables.exists(name))
            variables.remove(name);
    }

    function getRecursiveProperty(instance:Dynamic, split:Array<String>):Dynamic
    {
        var result:Dynamic = instance;

        for (part in split)
        {
            result = Reflect.getProperty(result, part);

            if (result == null)
                return null;
        }

        return result;
    }
}