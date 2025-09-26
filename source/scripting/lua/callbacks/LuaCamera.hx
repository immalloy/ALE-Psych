package scripting.lua.callbacks;

import flixel.util.FlxAxes;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaCamera extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Sacude una cámara
         * 
         * @param camera ID de la cámara
         * @param tag ID del shake
         * @param intensity Intensidad del shake
         * @param duration Duración del shake
         * @param force Define si se forzará el shake
         * @param axes Define los ejes en los que se sacudirá la cámara. Puede ser `0x00`, `0x01`, `0x11` o `0x10`
         */
        set('cameraShake', function(camera:String, tag:String, ?intensity:Float, ?duration:Float, ?force:Bool, ?axes:FlxAxes)
        {
            if (tagIs(camera, FlxCamera))
                getTag(camera).shake(intensity, duration, () -> { lua.call('onCameraShakeComplete', [tag]); }, force, axes);
        });
    }
}