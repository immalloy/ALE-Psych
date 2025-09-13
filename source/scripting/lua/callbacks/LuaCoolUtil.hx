package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.shaders.ALERuntimeShader;

import flixel.FlxState;
import flixel.FlxSubState;

class LuaCoolUtil extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('colorFromString', CoolUtil.colorFromString);

        set('getDominantColor', function(tag:String):FlxColor
        {
            if (tagIs(tag, FlxSprite))
                return CoolUtil.dominantColor(getTag(tag));

            return FlxColor.BLACK;
        });

        set('colorFromArray', CoolUtil.colorFromArray);

        
        set('resetEngine', CoolUtil.resetEngine);

        set('reloadGameMetadata', CoolUtil.reloadGameMetadata);
        
        set('resizeGame', CoolUtil.resizeGame);


        set('coolTextFile', CoolUtil.coolTextFile);

        set('searchComplexFile', CoolUtil.searchComplexFile);

        set('searchFile', CoolUtil.searchFile);

        set('openFolder', CoolUtil.openFolder);

        set('formatToSongPath', CoolUtil.formatToSongPath);

        set('getSavePath', CoolUtil.getSavePath);



        set('debugTrace', CoolUtil.debugTrace);

        set('ansiColorString', CoolUtil.ansiColorString);

        
        set('floorDecimal', CoolUtil.floorDecimal);

        set('quantize', CoolUtil.quantize);

        set('numberArray', CoolUtil.numberArray);

        set('fpsLerp', CoolUtil.fpsLerp);

        set('fpsRatio', CoolUtil.fpsRatio);

        set('snapNumber', CoolUtil.snapNumber);


        set('loadPlayStateSong', CoolUtil.loadPlayStateSong);
        
        set('loadSong', CoolUtil.loadSong);

        set('loadWeek', CoolUtil.loadWeek);


        set('setCameraShaders', function(camera:String, shaders:Array<String>)
        {
            if (!tagIs(camera, FlxCamera))
                return;

            var theShaders:Array<ALERuntimeShader> = [];

            for (shad in shaders)
                if (tagIs(shad, ALERuntimeShader))
                    theShaders.push(getTag(shad));

            CoolUtil.setCameraShaders(getTag(camera), theShaders);
        });
        
        
        set('resetState', CoolUtil.resetState);

        set('switchState', function(state:String, ?args:Array<Dynamic>, ?skipTransIn:Bool, ?skipTransOut:Bool)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(state);

            if (cl == null)
                return;

            CoolUtil.switchState(Type.createInstance(cl, args ?? []), skipTransIn, skipTransOut);
        });

        set('openSubState', function(substate:String, ?args:Array<Dynamic>, ?skipTransIn:Bool, ?skipTransOut:Bool)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(substate);

            if (cl == null)
                return;

            CoolUtil.switchState(Type.createInstance(cl, args ?? []));
        });


        set('capitalizeString', CoolUtil.capitalize);

        set('listFromString', CoolUtil.listFromString);


        set('browserLoad', CoolUtil.browserLoad);

        set('getBuildTarget', CoolUtil.getBuildTarget);
    }
}