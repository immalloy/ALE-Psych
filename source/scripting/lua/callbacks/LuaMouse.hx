package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

class LuaMouse extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Obtiene si una tecla ha sido presionada
         * 
         * @param button Botón del cual se obtendrá la información. Puede ser `left`, `middle`, `right`
         * 
         * @return Si la tecla ha sido presionada o no
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
         * Obtiene si una tecla está siendo presionada
         * 
         * @param button Botón del cual se obtendrá la información. Puede ser `left`, `middle`, `right`
         * 
         * @return Si la tecla está siendo presionada o no
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
         * Obtiene si una tecla ha sido soltada
         * 
         * @param button Botón del cual se obtendrá la información. Puede ser `left`, `middle`, `right`
         * 
         * @return Si la tecla ha sido soltada o no
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
         * Obtiene la posición en `x` del mouse en una cámara
         * 
         * @param camera ID de la cámara
         * 
         * @return Posición en `x`
         */
        set('getMouseX', function(camera:String):Float
        {
            if (!tagIs(camera, FlxCamera))
                return 0;

            return FlxG.mouse.getScreenPosition(getTag(camera)).x;
        });

        /**
         * Obtiene la posición en `y` del mouse en una cámara
         * 
         * @param camera ID de la cámara
         * 
         * @return Posición en `y`
         */
        set('getMouseY', function(camera:String):Float
        {
            if (!tagIs(camera, FlxCamera))
                return 0;

            return FlxG.mouse.getScreenPosition(getTag(camera)).y;
        });
    }
}