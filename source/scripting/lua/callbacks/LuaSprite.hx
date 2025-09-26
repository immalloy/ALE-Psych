package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import openfl.display.BlendMode;

import flixel.util.FlxColor;

using StringTools;

@:access(openfl.display.BlendMode)
class LuaSprite extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Crea un `FlxSprite`
         * 
         * @param tag ID del sprite
         * @param image Ruta de la imagen
         * @param x Posicion en `x`
         * @param y Posicion en `y`
         */
        set('makeLuaSprite', function(tag:String, ?image:String, ?x:Float, ?y:Float)
        {
            var sprite:FlxSprite = new FlxSprite(x, y);

            if (image != null)
                sprite.loadGraphic(Paths.image(image));

            sprite.animation.finishCallback = function(name:String)
            {
                lua.call('onSpriteAnimationComplete', [tag, name]);
            };

            setTag(tag, sprite);
        });

        /**
         * Carga un grafico a un sprite
         * 
         * @param tag ID del sprite
         * @param sprite Ruta de la imagen
         * @param gridX Ancho maximo del grafico
         * @param gridY Alto maximo del grafico
         */
        set('loadGraphic', function(tag:String, sprite:String, ?gridX:Int = 0, ?gridY:Int = 0)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).loadGraphic(Paths.image(sprite), gridX != 0 || gridY != 0, gridX, gridY);
        });

        /**
         * Crea un grafico cuadrado y lo carga a un sprite
         * 
         * @param tag ID del sprite
         * @param x Ancho del grafico
         * @param y Alto del grafico
         * @param color Color del grafico
         */
        set('makeGraphic', function(tag:String, x:Float, y:Float, ?color:FlxColor)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).makeGraphic(x, y, color);
        });

        /**
         * Carga un grafico animado a un sprite
         * 
         * @param tag ID del sprite
         * @param sprite Ruta de la imagen
         * @param spriteType Tipo de grafico. Puede ser `sparrow`, `packer`, `aseprite`
         */
        set('loadFrames', function(tag:String, sprite:String, ?spriteType:String)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).frames = switch ((spriteType ?? 'multi').toLowerCase())
                {
                    case 'sparrow':
                        Paths.getSparrowAtlas(sprite);
                    case 'packer':
                        Paths.getPackerAtlas(sprite);
                    case 'aseprite':
                        Paths.getAsepriteAtlas(sprite);
                    default:
                        Paths.getAtlas(sprite);
                };
        });

        /**
         * Añade una animación al sprite
         * 
         * @param tag ID del sprite
         * @param name Nombre de la animación
         * @param prefix Prefijo de la animación en el atlas
         * @param framerate Velocidad de la animación en frames
         * @param loop Define si la animación debe o no repetirse en bucle
         */
        set('addAnimationByPrefix', function(tag:String, name:String, prefix:String, ?framerate:Int, ?loop:Bool)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).animation.addByPrefix(name, prefix, framerate, loop);
        });

        /**
         * Añade una animación al sprite
         * 
         * @param tag ID del sprite
         * @param name Nombre de la animación
         * @param frames Indices que indican qué fotogramas se deben reproducir y en qué orden
         * @param framerate Velocidad de la animación en frames
         * @param loop Define si la animación debe o no repetirse en bucle
         */
        set('addAnimation', function(tag:String, name:String, frames:Array<Int>, ?framerate:Int, ?loop:Bool)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).animation.add(name, frames, framerate, loop);
        });

        /**
         * Añade una animación al sprite
         * 
         * @param tag ID del sprite
         * @param name Nombre de la animación
         * @param prefix Prefijo de la animación en el atlas
         * @param indices Indices que indican qué fotogramas se deben reproducir y en qué orden
         * @param framerate Velocidad de la animación en frames
         * @param loop Define si la animación debe o no repetirse en bucle
         */
        set('addAnimationByIndices', function(tag:String, name:String, prefix:String, indices:Array<Int>, ?framerate:Int, ?loop:Bool)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).animation.addByIndices(name, prefix, indices, '', framerate, loop);
        });

        /**
         * Reproduce una animación del sprite
         * 
         * @param tag ID del sprite
         * @param name Nombre de la animación
         * @param forced Fuerza a que se reproduzca la animación
         */
        set('playAnim', function(tag:String, name:String, ?forced:Bool, ?reversed:Bool, ?startFrame:Int)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).animation.play(name, forced, reversed, startFrame);
        });

        /**
         * Define el tamaño del sprite en píxeles
         * 
         * @param tag ID del sprite
         * @param w Ancho del sprite
         * @param h Alto del sprite
         */
        set('setGraphicSize', function(tag:String, w:Int, h:Int)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).setGraphicSize(w, h);
        });

        /**
         * Actualiza la hitbox del sprite
         * 
         * @param tag ID del sprite
         */
        set('updateHitbox', function(tag:String)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).updateHitbox();
        });

        /**
         * Cambia la forma en la que se mezclan los colores de un sprite con otros
         * 
         * @param tag ID del sprite
         * @param mode Define el modo de mezcla de color. Puede ser `add`,`alpha`,`darken`,`difference`,`erase`,`hardlight`,`invert`,`layer`,`lighten`,`multiply`,`normal`,`overlay`,`screen`,`shader` o `subtract`
         */
        set('setBlendMode', function(tag:String, mode:String)
        {
            if (tagIs(tag, FlxSprite))
                getTag(tag).blend = BlendMode.fromString(mode.trim().toLowerCase());
        });

        /**
         * Obtiene el color de un pixel en un sprite
         * 
         * @param tag ID del sprite
         * @param x Posición en `x` del pixel
         * @param y Posición en `y` del pixel
         * 
         * @return Color del pixel
         */
        set('getPixelColor', function(tag:String, x:Int, y:Int):Int
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).pixels.getPixel32(x, y);

            return FlxColor.BLACK;
        });

        /**
         * Añade un sprite al juego
         * 
         * @param tag ID del Sprite
         * 
         * @deprecated Use `add` en su lugar
         */
        set('addLuaSprite', function(tag:String)
        {
            deprecatedPrint('Use "add" instead of "addLuaSprite"');

            if (tagIs(tag, FlxSprite))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        /**
         * Remueve un sprite del juego
		 * 
		 * @param tag ID del sprite
		 * @param destroy Define si se debe destruir o no el sprite
		 * 
		 * @deprecated Use `remove` en su lugar
         */
        set('removeLuaSprite', function(tag:String, ?destroy:Bool)
        {
            deprecatedPrint('Use "remove" instead of "removeLuaSprite"');

            if (tagIs(tag, FlxSprite))
                if (type == STATE)
                    FlxG.state.remove(getTag(tag), destroy);
                else
                    FlxG.state.subState.remove(getTag(tag), destroy);
        });

        /**
         * Obtiene la coordenada `x` del punto medio del sprite
         * 
         * @param tag ID del sprite
         * 
         * @return `x` del punto medio del sprite
         */
        set('getMidpointX', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getMidpoint().x;
            
            return 0;
        });

        /**
         * Obtiene la coordenada `y` del punto medio del sprite
         * 
         * @param tag ID del sprite
         * 
         * @return `y` del punto medio del sprite
         */
        set('getMidpointY', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getMidpoint().y;

            return 0;
        });

        /**
         * Obtiene la coordenada `x` del punto medio del gráfico sprite
         * 
         * @param tag ID del sprite
         * 
         * @return `x` del punto medio del gráfico sprite
         */
        set('getGraphicMidpointX', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getGraphicMidpoint().x;

            return 0;
        });

        /**
         * Obtiene la coordenada `y` del punto medio del gráfico sprite
         * 
         * @param tag ID del sprite
         * 
         * @return `y` del punto medio del gráfico sprite
         */
        set('getGraphicMidpointY', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getGraphicMidpoint().y;
            
            return 0;
        });

        /**
         * Obtiene la posición en `x` del sprite en la pantalla
         * 
         * @param tag ID del sprite
         * 
         * @return Posición en `x` del sprite en la pantalla
         */
        set('getScreenPositionX', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getScreenPosition().x;
            
            return 0;
        });

        /**
         * Obtiene la posición en `y` del sprite en la pantalla
         * 
         * @param tag ID del sprite
         * 
         * @return Posición en `y` del sprite en la pantalla
         */
        set('getScreenPositionY', function(tag:String):Float
        {
            if (tagIs(tag, FlxSprite))
                return getTag(tag).getScreenPosition().y;
            
            return 0;
        });
    }
}