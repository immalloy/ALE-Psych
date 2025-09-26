package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.text.FlxText.FlxTextBorderStyle;

using StringTools;

class LuaText extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
		
		/**
		 * Crea un `FlxText`
		 * 
		 * @param tag ID del texto
		 * @param text Texto que se mostrara
		 * @param width Ancho máximo del texto
		 * @param x Posicion `x`
		 * @param y Posicion `y`
		 */
		set('makeLuaText', function(tag:String, text:String, width:Int, x:Float, y:Float)
		{
			setTag(tag, new FlxText(x, y, width, text));
		});

		/**
		 * Aplica un contorno a un texto
		 * 
		 * @param tag ID del texto
		 * @param size Grosor del contorno
		 * @param color Color del contorno
		 * @param style Estilo del contorno. Puede ser `shadow`, `outline`, `outline_fast` o `none`
		 */
		set('setTextBorder', function(tag:String, size:Float, color:FlxColor, ?style:String)
		{
			if (tagIs(tag, FlxText))
			{
				var text:FlxText = getTag(tag);
				text.borderStyle = switch(style.toLowerCase().trim())
				{
					case 'shadow':
						FlxTextBorderStyle.SHADOW;
					case 'outline':
						FlxTextBorderStyle.OUTLINE;
					case 'outline_fast':
						FlxTextBorderStyle.OUTLINE_FAST;
					default:
						FlxTextBorderStyle.NONE;
				};
				text.borderSize = size;
				text.borderColor = color;
			}
		});

		/**
		 * Aplica un font a un texto
		 * 
		 * @param tag ID del texto
		 * @param newFont Font a aplicar
		 */
		set('setTextFont', function(tag:String, newFont:String)
		{
			if (tagIs(tag, FlxText))
			{
				var text:FlxText = getTag(tag);
				
				text.font = Paths.font(newFont);
			}
		});

        /**
         * Añade un texto al juego
		 * 
		 * @param tag ID del texto
		 * 
		 * @deprecated Use `add` en su lugar
         */
        set('addLuaText', function(tag:String)
        {
            deprecatedPrint('Use "add" instead of "addLuaText"');

            if (tagIs(tag, FlxSprite))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        /**
         * Remueve un texto del juego
		 * 
		 * @param tag ID del texto
		 * @param destroy Define si se debe destruir o no el texto
		 * 
		 * @deprecated Use `remove` en su lugar
         */
        set('removeLuaText', function(tag:String, ?destroy:Bool)
        {
            deprecatedPrint('Use "remove" instead of "removeLuaText"');

            if (tagIs(tag, FlxSprite))
                if (type == STATE)
                    FlxG.state.remove(getTag(tag), destroy);
                else
                    FlxG.state.subState.remove(getTag(tag), destroy);
        });
    }
}