package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaSound extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Reproduce música en el juego
         * 
         * @param sound Ruta del audio
         * @param volume Volumen de la música (de 0 a 1)
         * @param loop Define si la música está en bucle o no
         */
        set('playMusic', function(sound:String, ?volume:Float, ?loop:Bool)
        {
            FlxG.sound.playMusic(Paths.music(sound), volume, loop);
        });

        /**
         * Reproduce un sonido
         * 
         * @param sound Ruta del audio
         * @param volume Volumen del sonido (de 0 a 1)
         * @param tag ID del sonido
         * @param loop Define si el sonido estará en bucle o no
         */
        set('playSound', function(sound:String, ?volume:Float, ?tag:String, ?loop:Bool)
        {
            setTag(tag, FlxG.sound.play(Paths.sound(sound), volume, loop, null, true, function()
            {
                lua.call('onSoundFinished', [tag]);
            }));
        });

        /**
         * Detiene un sondio
         * 
         * @param tag ID del sonido
         */
        set('stopSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).stop();
        });

        /**
         * Pausa un sonido
         * 
         * @param tag ID del sonido
         */
        set('pauseSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).pause();
        });

        /**
         * Despausa un sonido
         * 
         * @param tag ID del sonido
         */
        set('resumeSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).resume();
        });

        /**
         * Cambia el volumen de un sonido en un tiempo determinado
         * 
         * @param tag ID del sonido
         * @param duration Duración del cambio
         * @param fromValue Volumen inicial
         * @param toValue Volumen final
         */
        set('soundFadeIn', function(tag:String, ?duration:Float, ?fromValue:Float, ?toValue:Float)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeIn(duration, fromValue, toValue, (_) -> {
                    lua.call('onSoundFadeInFinished', [tag]);
                });
        });

        /**
         * Cambia el volumen de un sonido en un tiempo determinado
         * 
         * @param tag ID del sonido
         * @param duration Duracion del cambio
         * @param toValue Volumen final
         */
        set('soundFadeOut', function(tag:String, ?duration:Float, ?toValue:Float)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeOut(duration, toValue, (_) -> {
                    lua.call('onSoundFadeOutFinished', [tag]);
                });
        });

        /**
         * Detiene el cambio de volumen de un sonido
         * 
         * @param tag ID del sonido
         */
        set('soundFadeCancel', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeTween?.cancel();
        });
    }
}