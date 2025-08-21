package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaCoolUtil extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('colorFromString', CoolUtil.colorFromString);

        set('floorDecimal', CoolUtil.floorDecimal);

        set('debugTrace', CoolUtil.debugTrace);
    }
}