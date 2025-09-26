package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import flixel.FlxBasic;

class LuaBasic extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Define la cámara en las que se dibujará un objeto
         * 
         * @param tag ID del objeto
         * @param camera ID de la cámara
         * 
         * @deprecated Use `setObjectCameras` en su lugar
         */
        set('setObjectCamera', function(tag:String, camera:String)
        {
            deprecatedPrint('Use "setObjectCameras" instead of "setObjectCamera"');

            if (tagIs(tag, FlxBasic) && tagIs(camera, FlxCamera))
                getTag(tag).cameras = [getTag(camera)];
        });

        /**
         * Define las cámaras en las que se dibujará un objeto
         * 
         * @param tag ID del objeto
         * @param cameras Lista de IDs de las cámaras
         */
        set('setObjectCameras', function(tag:String, cameras:Array<String>)
        {
            var theCameras:Array<FlxCamera> = [];

            for (cam in cameras)
                if (tagIs(cam, FlxCamera))
                    theCameras.push(getTag(cam));

            if (tagIs(tag, FlxBasic))
                cast(getTag(tag), FlxBasic).cameras = theCameras;
        });

        /**
         * Muestra si un objeto está tocando a otro
         * 
         * @param tag0 ID del primer objeto
         * @param tag1 ID del segundo objeto
         * 
         * @return Si los objetos se están tocando
         */
        set('objectsOverlap', function(tag0:String, tag1:String):Bool
        {
            if (tagIs(tag0, FlxBasic) && tagIs(tag0, FlxBasic))
                return FlxG.overlap(getTag(tag0), getTag(tag1));

            return false;
        });
    }
}