package funkin.debug;

import openfl.display.Sprite;

import core.structures.DebugFieldText;

class DebugCounter extends Sprite
{
    var fpsCounter:DebugField;

    var fields:Array<DebugField> = [];

    var offset:Float = 0;

    public function new(data:Array<Array<DebugFieldText>>)
    {
        super();

        FlxG.stage.addEventListener('activate', onFocus);
        FlxG.stage.addEventListener('deactivate', onUnFocus);

        fpsCounter = new FPSField();
        addChild(fpsCounter);

        offset += fpsCounter.bg.scaleY;

        for (field in data)
        {
            var debug:DebugField = new DebugField(field);
            addChild(debug);
            debug.y = offset;
            
            fields.push(debug);

            offset += debug.bg.scaleY;
        }

        switchMode(0);
    }

    private var timer:#if linux Float #else Int #end = 0;

    private var focused:Bool = true;

    override function __enterFrame(time:#if linux Float #else Int #end)
    {
        if (focused && visible)
        {
            if (timer > 50)
            {
                timer = 0;
            } else {
                timer += time;

                return;
            }
        } else {
            return;
        }
        
        super.__enterFrame(time);
    }

    public function destroy()
    {
        FlxG.stage.removeEventListener('activate', onFocus);
        FlxG.stage.removeEventListener('deactivate', onUnFocus);
        
        for (field in fields)
        {
            fields.remove(field);

            removeChild(field);

            field = null;
        }

        removeChild(fpsCounter);

        fpsCounter = null;
    }

    function onFocus(_)
        focused = true;

    function onUnFocus(_)
        focused = false;
    
    public var curMode:Int = 0;

    public function switchMode(change:Int = 1)
    {
        curMode += change;

        curMode = curMode % 3;

        switch (curMode)
        {
            case 0:
                for (field in fields)
                    field.visible = false;

                fpsCounter.visible = true;
                fpsCounter.bg.visible = false;
            case 1:
                for (field in fields)
                    field.visible = true;

                fpsCounter.bg.visible = true;
            case 2:
                for (field in fields)
                    field.visible = false;

                fpsCounter.visible = false;
        }
    }
}