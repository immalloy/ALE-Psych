package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.util.FlxColor;

using StringTools;

class LuaColor extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Obtiene un color desde su nombre
         * 
         * @param name Nombre del color. Véase [FlxColor](https://api.haxeflixel.com/flixel/util/FlxColor.html)
         * 
         * @return Color obtenido
         */
        set('getColorFromName', function(name:String):Int
        {
            return switch(name.toUpperCase())
            {
                case 'BLACK':
                    FlxColor.BLACK;
                case 'BLUE':
                    FlxColor.BLUE;
                case 'BROWN':
                    FlxColor.BROWN;
                case 'CYAN':
                    FlxColor.CYAN;
                case 'GRAY':
                    FlxColor.GRAY;
                case 'GREEN':
                    FlxColor.GREEN;
                case 'LIME':
                    FlxColor.LIME;
                case 'MAGENTA':
                    FlxColor.MAGENTA;
                case 'ORANGE':
                    FlxColor.ORANGE;
                case 'PINK': 
                    FlxColor.PINK;
                case 'PURPLE': 
                    FlxColor.PURPLE;
                case 'RED': 
                    FlxColor.RED;
                case 'TRANSPARENT': 
                    FlxColor.TRANSPARENT;
                case 'YELLOW': 
                    FlxColor.YELLOW;
                default: 
                    FlxColor.WHITE;
            };
        });

        /**
         * Obtiene un color desde un String que contenga su código en HEX
         * 
         * @param str String con el código HEX
         * 
         * @return Color obtenido
         */
        set('getColorFromString', function(str:String):Int
        {
            return FlxColor.fromString(str);
        });
    }
}