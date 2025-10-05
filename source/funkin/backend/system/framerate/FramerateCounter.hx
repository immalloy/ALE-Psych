package funkin.backend.system.framerate;

import flixel.FlxG;
import flixel.util.FlxStringUtil;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import utils.CoolUtil;

class FramerateCounter extends Sprite
{
        public var showMemory:Bool;
        public var updateRate:Float;

        var fpsField:TextField;
        var memoryField:TextField;

        var elapsed:Float = 0;
        var displayedFps:Float = 0;

        public function new(x:Float = 10, y:Float = 10, showMemory:Bool = true, updateRate:Float = 0.25)
        {
                super();

                this.x = x;
                this.y = y;
                this.showMemory = showMemory;
                this.updateRate = Math.max(0.01, updateRate);

                mouseEnabled = false;
                mouseChildren = false;

                fpsField = createField();
                addChild(fpsField);

                memoryField = createField();
                memoryField.y = fpsField.height;
                memoryField.visible = showMemory;
                addChild(memoryField);

                addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
                addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
        }

        function handleAddedToStage(_event:Event):Void
        {
                addEventListener(Event.ENTER_FRAME, handleEnterFrame);
                updateDisplay(true);
        }

        function handleRemovedFromStage(_event:Event):Void
        {
                removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
        }

        function createField():TextField
        {
                var format = new TextFormat("_sans", 12, 0xFFFFFF, true);

                var field = new TextField();
                field.defaultTextFormat = format;
                field.selectable = false;
                field.width = 220;
                field.height = 20;

                return field;
        }

        function handleEnterFrame(_event:Event):Void
        {
                elapsed += FlxG.elapsed;

                if (elapsed >= updateRate)
                {
                        updateDisplay();
                        elapsed = 0;
                }
        }

        function updateDisplay(force:Bool = false):Void
        {
                var targetFps:Float = FlxG.elapsed <= 0 ? 0 : (1 / FlxG.elapsed);
                displayedFps = force ? targetFps : CoolUtil.fpsLerp(displayedFps, targetFps, 0.25);

                var fps:Int = Math.floor(displayedFps + 0.5);
                fpsField.text = 'FPS: ' + fps;

                var color = 0x00FF00;
                if (fps < 30)
                        color = 0xFF4444;
                else if (fps < 50)
                        color = 0xFFFF00;

                fpsField.textColor = color;

                if (showMemory)
                {
                        var memory = System.totalMemory;
                        memoryField.text = 'Memory: ' + FlxStringUtil.formatBytes(memory);
                        memoryField.textColor = 0xFFFFFF;
                        memoryField.visible = true;
                }
                else
                {
                        memoryField.visible = false;
                }
        }
}
