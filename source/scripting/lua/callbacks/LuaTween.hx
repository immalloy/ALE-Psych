package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaTween extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Crea e inicia un `FlxTween`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto sobre el que actuará el tween
         * @param props Tabla de variables del objeto que serán modificadas
         * @param time Duración del tween
         * @param options Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html)
         */
        set('tween', function(tag:String, obj:String, props:Dynamic, ?time:Float, ?options:Dynamic)
        {
            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), props, time, options));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `x`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `x`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenX', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenX"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {x: value}, time, {ease: ease}));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `y`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `y`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenY', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenY"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {y: value}, time, {ease: ease}));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `angle`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `angle`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenAngle', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenAngle"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {angle: value}, time, {ease: ease}));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `alpha`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `alpha`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenAlpha', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenAlpha"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {alpha: value}, time, {ease: ease}));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `zoom`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `zoom`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenZoom', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenZoom"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {zoom: value}, time, {ease: ease}));
        });
        
        /**
         * Crea e inicia un tween sobre un objeto y su variable `color`
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param value Valor en `color`
         * @param time Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `tween` en su lugar
         */
        set('doTweenColor', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "colorTween" instead of "doTweenColor"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, getTag(obj), {color: value}, time, {ease: ease}));
        });

        /**
         * Crea e inicia un tween que cambiará el color de un objeto
         * 
         * @param tag ID del tween
         * @param obj ID del objeto
         * @param time Duración del tween
         * @param from Color inicial
         * @param to Color final
         * @param options Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html)
         */
        set('colorTween', function(tag:String, obj:String, ?time:Float, ?from:FlxColor, ?to:FlxColor, ?options:Dynamic)
        {
            setTag(tag, LuaPresetUtils.complexColorTween(lua, tag, getTag(obj), time, from, to, options));
        });

        /**
         * Cancela un tween
         * 
         * @param tag ID del tween
         */
        set('cancelTween', function(tag:String)
        {
            if (tagIs(tag, FlxTween))
                getTag(tag).cancel();
        });
    }
}