package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaTimer extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set('runTimer', function(tag:String, time:Float = 1, loops:Int = 1)
        {
            var timer:FlxTimer = new FlxTimer().start(time, function(tmr:FlxTimer)
            {
                lua.call('onTimerComplete', [tag, tmr.loops, tmr.loopsLeft]);
            }, loops);

            setTag(tag, timer);
        });
        
        set('cancelTimer', function(tag:String)
        {
            if (tagIs(tag, FlxTimer))
                getTag(tag).cancel();
        });
    }
}