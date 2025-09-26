package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.FlxBasic;

class LuaGlobal extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Adds an object to the game
         * 
         * @param tag ID of the object
         */
        set('add', function(tag:String)
        {
            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        /**
         * Removes an object from the game
         * 
         * @param tag ID of the object
         * @param destroy Defines whether the object should be destroyed
         */
        set('remove', function(tag:String, ?destroy:Bool)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.remove(getTag(tag), destroy);
                else
                    FlxG.state.subState.remove(getTag(tag), destroy);
        });

        /**
         * Inserts an object into the game
         * 
         * @param position Position where the object will be inserted
         * @param tag ID of the object
         */
        set('insert', function(position:Int, tag:String)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.insert(position, getTag(tag));
                else
                    FlxG.state.subState.insert(position, getTag(tag));
        });

        /**
         * Gets the position of an object in the game
         * 
         * @param tag ID of the object
         * 
         * @return Object position
         */
        set('getObjectOrder', function(tag:String)
        {
            return type == STATE ? FlxG.state.members.indexOf(getTag(tag)) : FlxG.state.subState.members.indexOf(getTag(tag));
        });

        /**
         * Removes and reinserts an object in a different position
         * 
         * @param tag ID of the object
         * @param position New position
         */
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

        /**
         * Gets a random integer
         * 
         * @param min Smallest integer
         * @param max Largest integer
         * @param excludes Integers that will not be used
         * 
         * @return Obtained integer
         */
        set('getRandomInt', function(?min:Int, ?max:Int, ?excludes:Array<Int>)
        {
            return FlxG.random.int(min, max, excludes);
        });

        /**
         * Gets a random float
         * 
         * @param min Smallest float
         * @param max Largest float
         * @param excludes Floats that will not be used
         * 
         * @return Obtained float
         */
        set('getRandomFloat', function(?min:Float, ?max:Float, ?excludes:Array<Float>)
        {
            return FlxG.random.float(min, max, excludes);
        });

        /**
         * Gets a random boolean
         * 
         * @param chance Probability that the value is `true` (from 0 to 100)
         * 
         * @return Obtained boolean
         */
        set('getRandomBool', function(?chance:Float)
        {
            return FlxG.random.bool(chance);
        });
    }
}
