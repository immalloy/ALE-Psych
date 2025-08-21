package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.FlxBasic;

class LuaGlobal extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('add', function(tag:String)
        {
            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        set('remove', function(tag:String, ?destroy:Bool)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.remove(getTag(tag), destroy);
                else
                    FlxG.state.subState.remove(getTag(tag), destroy);
        });

        set('insert', function(position:Int, tag:String)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.insert(position, getTag(tag));
                else
                    FlxG.state.subState.insert(position, getTag(tag));
        });

        set('getObjectOrder', function(tag:String)
        {
            return type == STATE ? FlxG.state.members.indexOf(getTag(tag)) : FlxG.state.subState.members.indexOf(getTag(tag));
        });

        set('setObjectOrder', function(tag:String, position:Int)
        {
            if (!tagIs(tag, FlxBasic))
                return;

            var object:FlxBasic = getTag(tag);

            if (type == STATE)
            {
                FlxG.state.remove(object);
                FlxG.state.insert(position, object);
            } else {
                FlxG.state.subState.remove(object);
                FlxG.state.subState.insert(position, object);
            }
        });

        set('getRandomInt', function(?min:Int, ?max:Int, ?excludes:Array<Int>)
        {
            return FlxG.random.int(min, max, excludes);
        });

        set('getRandomFloat', function(?min:Float, ?max:Float, ?excludes:Array<Float>)
        {
            return FlxG.random.float(min, max, excludes);
        });

        set('getRandomBool', function(?chance:Float)
        {
            return FlxG.random.bool(chance);
        });
    }
}