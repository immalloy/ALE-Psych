package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaMouse extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Gets whether a mouse button has been clicked
         * 
         * @param button Button to check. Can be `left`, `middle`, `right`
         * 
         * @return Whether the button has been clicked
         */
        set('mouseClicked', function(?button:String):Bool
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

        /**
         * Gets whether a mouse button is being pressed
         * 
         * @param button Button to check. Can be `left`, `middle`, `right`
         * 
         * @return Whether the button is being pressed
         */
        set('mousePressed', function(?button:String):Bool
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

        /**
         * Gets whether a mouse button has been released
         * 
         * @param button Button to check. Can be `left`, `middle`, `right`
         * 
         * @return Whether the button has been released
         */
        set('mouseReleased', function(?button:String):Bool
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

        /**
         * Gets the mouse `x` position in a camera
         * 
         * @param camera ID of the camera
         * 
         * @return `x` position
         */
        set('getMouseX', function(camera:String):Float
        {
            if (!tagIs(camera, FlxCamera))
                return 0;

            return FlxG.mouse.getScreenPosition(getTag(camera)).x;
        });

        /**
         * Gets the mouse `y` position in a camera
         * 
         * @param camera ID of the camera
         * 
         * @return `y` position
         */
        set('getMouseY', function(camera:String):Float
        {
            if (!tagIs(camera, FlxCamera))
                return 0;

            return FlxG.mouse.getScreenPosition(getTag(camera)).y;
        });
    }
}
