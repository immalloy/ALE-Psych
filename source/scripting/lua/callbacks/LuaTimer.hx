package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaTimer extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Inicia y ejecuta un `FlxTimer`
         * 
         * @param tag ID del timer
         * @param time Duración del timer
         * @param loops Cantidad de repeticiones del timer
         */
        set('runTimer', function(tag:String, ?time:Float, ?loops:Int)
        {
            var timer:FlxTimer = new FlxTimer().start(time ?? 1, function(tmr:FlxTimer)
            {
                lua.call('onTimerComplete', [tag, tmr.loops, tmr.loopsLeft]);
            }, loops ?? 1);

            setTag(tag, timer);
        });
        
        /**
         * Cancela un timer
         * 
         * @param tag ID del timer
         */
        set('cancelTimer', function(tag:String)
        {
            if (tagIs(tag, FlxTimer))
                getTag(tag).cancel();
        });
    }
}