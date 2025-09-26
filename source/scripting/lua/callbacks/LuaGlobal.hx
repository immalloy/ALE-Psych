package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import flixel.FlxBasic;

class LuaGlobal extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Añade un objeto al juego
         * 
         * @param tag ID del objeto
         */
        set('add', function(tag:String)
        {
            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        /**
         * Remueve un objeto del juego
         * 
         * @param tag ID del objeto
         * @param destroy Define si el objeto debe ser o no destruido
         */
        set('remove', function(tag:String, ?destroy:Bool)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.remove(getTag(tag), destroy);
                else
                    FlxG.state.subState.remove(getTag(tag), destroy);
        });

        /**
         * Inserta un objeto en el juego
         * 
         * @param position Posición en la que el objeto será insertado
         * @param tag ID del objeto
         */
        set('insert', function(position:Int, tag:String)
        {
            if (tagIs(tag, FlxBasic))
                if (type == STATE)
                    FlxG.state.insert(position, getTag(tag));
                else
                    FlxG.state.subState.insert(position, getTag(tag));
        });

        /**
         * Obtiene la posición de un objeto en el juego
         * 
         * @param tag ID del objeto
         * 
         * @return Posicion del objeto
         */
        set('getObjectOrder', function(tag:String)
        {
            return type == STATE ? FlxG.state.members.indexOf(getTag(tag)) : FlxG.state.subState.members.indexOf(getTag(tag));
        });

        /**
         * Remueve e inserta un objeto del juego en una posición distinta
         * 
         * @param tag ID del objeto
         * @param position Nueva posición
         */
        set('setObjectOrder', function(tag:String, position:Int)
        {
            if (!tagIs(tag, FlxBasic))
                return;

            var object:FlxBasic = getTag(tag);

            if (type == STATE)
            {
                FlxG.state.remove(object);
                FlxG.state.insert(position, object);
            } else {
                FlxG.state.subState.remove(object);
                FlxG.state.subState.insert(position, object);
            }
        });

        /**
         * Obtiene un entero aleatorio
         * 
         * @param min Entero más pequeño
         * @param max Entero mas grande
         * @param excludes Enteros que no serán usados
         * 
         * @return Entero obtenido
         */
        set('getRandomInt', function(?min:Int, ?max:Int, ?excludes:Array<Int>)
        {
            return FlxG.random.int(min, max, excludes);
        });

        /**
         * Obtiene un decimal aleatorio
         * 
         * @param min Decimal más pequeño
         * @param max Decimal mas grande
         * @param excludes Decimales que no serán usados
         * 
         * @return Decimal obtenido
         */
        set('getRandomFloat', function(?min:Float, ?max:Float, ?excludes:Array<Float>)
        {
            return FlxG.random.float(min, max, excludes);
        });

        /**
         * Obtiene un booleano aleatorio
         * 
         * @param chance Probabilidad de que el valor sea `true` (del 0 al 100)
         * 
         * @return Booleano obtenido
         */
        set('getRandomBool', function(?chance:Float)
        {
            return FlxG.random.bool(chance);
        });
    }
}