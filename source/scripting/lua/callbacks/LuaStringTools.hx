package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

using StringTools;

class LuaStringTools extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Checks if a `String` starts with the content of another
         * 
         * @param str `String` to analyze
         * @param start Content to check
         * 
         * @return Whether `str` starts with `start`
         */
        set('stringStartsWith', function(str:String, start:String):Bool
        {
            return str.startsWith(start);
        });

        /**
         * Checks if a `String` ends with the content of another
         * 
         * @param str `String` to analyze
         * @param end Content to check
         * 
         * @return Whether `str` ends with `end`
         */
        set('stringEndsWith', function(str:String, end:String):Bool
        {
            return str.endsWith(end);
        });

        /**
         * Splits a `String` into several parts
         * 
         * @param str `String` to split
         * @param split Separator for the splits
         * 
         * @return List with the parts of the `String`
         */
        set('stringSplit', function(str:String, split:String):Array<String>
        {
            return str.split(split);
        });

        /**
         * Removes spaces at the beginning and end of a `String`
         * 
         * @param str `String` to process
         * 
         * @return Processed `String`
         */
        set('stringTrim', function(str:String):String
        {
            return str.trim();
        });
    }
}
