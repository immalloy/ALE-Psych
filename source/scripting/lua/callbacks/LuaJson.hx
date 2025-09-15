package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaJson extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('parseJson', Json.parse);

        set('parseJsonFile', function(path:String)
        {
            return Paths.json(path);
        });

        set('stringifyJson', Json.stringify);
    }
}