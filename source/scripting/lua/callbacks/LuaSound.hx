package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaSound extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Plays music in the game
         * 
         * @param sound Audio path
         * @param volume Music volume (from 0 to 1)
         * @param loop Defines whether the music loops
         */
        set('playMusic', function(sound:String, ?volume:Float, ?loop:Bool)
        {
            FlxG.sound.playMusic(Paths.music(sound), volume, loop);
        });

        /**
         * Plays a sound
         * 
         * @param sound Audio path
         * @param volume Sound volume (from 0 to 1)
         * @param tag Sound ID
         * @param loop Defines whether the sound loops
         */
        set('playSound', function(sound:String, ?volume:Float, ?tag:String, ?loop:Bool)
        {
            setTag(tag, FlxG.sound.play(Paths.sound(sound), volume, loop, null, true, function()
            {
                lua.call('onSoundFinished', [tag]);
            }));
        });

        /**
         * Stops a sound
         * 
         * @param tag Sound ID
         */
        set('stopSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).stop();
        });

        /**
         * Pauses a sound
         * 
         * @param tag Sound ID
         */
        set('pauseSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).pause();
        });

        /**
         * Resumes a sound
         * 
         * @param tag Sound ID
         */
        set('resumeSound', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).resume();
        });

        /**
         * Changes a sound's volume over a set time
         * 
         * @param tag Sound ID
         * @param duration Duration of the change
         * @param fromValue Starting volume
         * @param toValue Ending volume
         */
        set('soundFadeIn', function(tag:String, ?duration:Float, ?fromValue:Float, ?toValue:Float)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeIn(duration, fromValue, toValue, (_) -> {
                    lua.call('onSoundFadeInFinished', [tag]);
                });
        });

        /**
         * Changes a sound's volume over a set time
         * 
         * @param tag Sound ID
         * @param duration Duration of the change
         * @param toValue Ending volume
         */
        set('soundFadeOut', function(tag:String, ?duration:Float, ?toValue:Float)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeOut(duration, toValue, (_) -> {
                    lua.call('onSoundFadeOutFinished', [tag]);
                });
        });

        /**
         * Stops a sound's volume change
         * 
         * @param tag Sound ID
         */
        set('soundFadeCancel', function(tag:String)
        {
            if (tagIs(tag, FlxSound))
                getTag(tag).fadeTween?.cancel();
        });
    }
}
