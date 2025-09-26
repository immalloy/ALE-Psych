package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaJson extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Parses a string in JSON format
         * 
         * @param str JSON string
         * 
         * @return Parsed JSON table
         */
        set('parseJson', function(str:String)
        {
            return Json.parse(str);
        });

        /**
         * Parses a file in JSON format
         * 
         * @param path File path
         * 
         * @return Parsed JSON table
         */
        set('parseJsonFile', function(path:String)
        {
            return Paths.json(path);
        });

        /**
         * Converts a table to a JSON string
         * 
         * @param object Table
         * @param space Indentation space
         * 
         * @return JSON formatted string
         */
        set('stringifyJson', function(object:Dynamic, ?space:String)
        {
            return Json.stringify(object, space);
        });
    }
}
