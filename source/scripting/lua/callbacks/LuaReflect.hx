package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import Type;

using StringTools;

class LuaReflect extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('getProperty', function(tag:String):Dynamic
        {
            return getTag(tag);
        });

        set('getPropertyFromGroup', function(tag:String, index:Int, prop:String):Dynamic
        {
            if (tagIs(tag, FlxTypedGroup))
                return Reflect.getProperty(getTag(tag).members[index], prop);

            return null;
        });

        set('getPropertyFromClass', function(path:String, prop:String):Dynamic
        {
            var cl:Dynamic = getClass(path);

            if (cl == null)
                return null;

            return getRecursiveProperty(cl, prop.split('.'));
        });

        set('setProperty', function (tag:String, value:Dynamic)
        {
            var split:Array<String> = tag.split('.');

            var pop:String = split.pop();

            Reflect.setProperty(getTag(split.join('.')), pop, value);
        });

        set('setPropertyFromGroup', function (tag:String, index:Int, prop:String, value:Dynamic)
        {
            if (tagIs(tag, FlxTypedGroup))
                Reflect.setProperty(getTag(tag).members[index], prop, value);
        });

        set('setPropertyFromClass', function(path:String, prop:String, value:Dynamic)
        {
            var cl:Dynamic = getClass(path);

            if (cl == null)
                return;

            var split:Array<String> = prop.split('.');

            var pop:String = split.pop();

            Reflect.setProperty(getRecursiveProperty(cl, split), pop, value);
        });

        set('callMethod', function(tag:String, ?args:Array<Dynamic>):Dynamic
        {
            return Reflect.callMethod(null, getTag(tag), args ?? []);
        });

        set('callMethodFromClass', function(path:String, func:String, ?args:Array<Dynamic>):Dynamic
        {
            var cl:Dynamic = getClass(path);

            if (cl == null)
                return null;

            return Reflect.callMethod(this, getRecursiveProperty(cl, func.split('.')), args ?? []);
        });

        set('createInstance', function(tag:String, path:String, ?args:Array<Dynamic>)
        {
            var cl:Dynamic = getClass(path);

            if (cl == null)
                return;

            setTag(tag, Type.createInstance(cl, args ?? []));
        });

        set('addInstance', function(tag:String)
        {
            deprecatedPrint('Use "add" instead of "addInstance"');

            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });
    }

    function getClass(path:String):Dynamic
    {
        var cl:Dynamic = Type.resolveClass(path);

        if (cl == null)
            errorPrint('Type not Found: ' + path);

        return cl;
    }
}