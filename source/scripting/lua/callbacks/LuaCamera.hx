package scripting.lua.callbacks;

import flixel.util.FlxAxes;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaCamera extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('cameraShake', function(camera:String, tag:String, ?intensity:Float, ?duration:Float, ?force:Bool, ?axes:FlxAxes)
        {
            LuaPresetUtils.cameraFromString(lua, camera).shake(intensity, duration, () -> {
                lua.call('onCameraShakeComplete', [tag]);
            }, force, axes);
        });
    }
}