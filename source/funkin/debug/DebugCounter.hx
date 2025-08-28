package funkin.debug;

import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

import flixel.input.keyboard.FlxKey;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;

class DebugCounter extends Sprite implements IFlxDestroyable
{
    public var categories:Array<DebugField> = [];

    public var debugMode:Int = 1;

    var fpsCounter:DebugField;

    override public function new()
    {
        super();

        x = 10;
        y = 5;

        core.config.MainState.debugCounter = this;

        fpsCounter = new FPSField();
        fpsCounter.enabled = true;
        fpsCounter.bg.alpha = 0;

        addField(fpsCounter, false);

        addField(new ConductorField());
        addField(new FlixelField());
        addField(new SystemField());
    }

	private var spriteOffset:Float = 0;

	private function addField(sprite:DebugField, ?pushCategory:Bool = true)
    {
		sprite.y = spriteOffset;

		addChild(sprite);

        if (pushCategory)
            categories.push(sprite);

        sprite.updateField(0);

        spriteOffset += sprite.text.height + sprite.text.y - sprite.title.y + y * 2;
	}

    public function switchMode()
    {
        debugMode = (debugMode + 1) % 3;

        switch (debugMode)
        {
            case 0:
                fpsCounter.enabled = false;
                for (category in categories)
                    category.enabled = false;
            case 1:
                fpsCounter.enabled = true;
                fpsCounter.bg.alpha = 0;
            case 2:
                fpsCounter.bg.alpha = 0.5;
                for (category in categories)
                    category.enabled = true;
        }
    }
    
    public function destroy()
    {
        categories = [];

        for (category in categories)
        {
            categories.splice(categories.indexOf(category), 1);

            removeChild(category);

            category = null;
        }

        fpsCounter = null;

        removeChild(fpsCounter);
    }

    @:access(flixel.FlxGame) override function __enterFrame(time:#if linux Float #else Int #end)
    {
        if (FlxG.game._lostFocus)
            return;

        super.__enterFrame(time);
    }
}