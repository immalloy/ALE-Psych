package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaTween extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('cancelTween', function(tag:String)
        {
            if (tagIs(tag, FlxTween))
                getTag(tag).cancel();
        });
    }
}