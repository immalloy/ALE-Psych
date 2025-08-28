package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaMouse extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('mouseClicked', function(?button:String)
        {
            return switch (button.toLowerCase())
            {
                default:
                    FlxG.mouse.justPressed;
                case 'middle':
                    FlxG.mouse.justPressedMiddle;
                case 'right':
                    FlxG.mouse.justPressedRight;
            };
        });

        set('mousePressed', function(?button:String)
        {
            return switch (button.toLowerCase())
            {
                default:
                    FlxG.mouse.pressed;
                case 'middle':
                    FlxG.mouse.pressedMiddle;
                case 'right':
                    FlxG.mouse.pressedRight;
            };
        });

        set('mouseReleased', function(?button:String)
        {
            return switch (button.toLowerCase())
            {
                default:
                    FlxG.mouse.justReleased;
                case 'middle':
                    FlxG.mouse.justReleasedMiddle;
                case 'right':
                    FlxG.mouse.justReleasedRight;
            };
        });

        set('getMouseX', function(camera:String):Float
        {
            return FlxG.mouse.getScreenPosition(LuaPresetUtils.cameraFromString(lua, camera)).x;
        });

        set('getMouseY', function(camera:String):Float
        {
            return FlxG.mouse.getScreenPosition(LuaPresetUtils.cameraFromString(lua, camera)).y;
        });
    }
}