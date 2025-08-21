package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import flixel.FlxBasic;

class LuaBasic extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('setObjectCamera', function(tag:String, camera:String)
        {
            deprecatedPrint('Use "setObjectCameras" instead of "setObjectCamera"');

            if (tagIs(tag, FlxBasic))
                getTag(tag).cameras = [LuaPresetUtils.cameraFromString(lua, camera)];
        });

        set('setObjectCameras', function(tag:String, cameras:Array<String>)
        {
            if (!tagIs(tag, FlxBasic))
                return;

            var foundCameras:Array<FlxCamera> = [];

            for (camera in cameras)
                foundCameras.push(LuaPresetUtils.cameraFromString(lua, camera));

            getTag(tag).cameras = foundCameras;
        });

        set('objectsOverlap', function(tag0:String, tag1:String)
        {
            if (tagIs(tag0, FlxBasic) && tagIs(tag0, FlxBasic))
                FlxG.overlap(getTag(tag0), getTag(tag1));
        });
    }
}