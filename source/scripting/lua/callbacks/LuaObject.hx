package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.FlxObject;

import flixel.util.FlxAxes;

class LuaObject extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Centra un objeto en la pantalla
         * 
         * @param tag ID del objeto
         * @param axes Ejes en los que se va a centrar. Puede ser `0x00`, `0x01`, `0x11`, `0x10`
         */
        set('screenCenter', function(tag:String, ?axes:FlxAxes)
        {
            if (tagIs(tag, FlxObject))
                getTag(tag).screenCenter(axes ?? FlxAxes.XY);
        });
    }
}