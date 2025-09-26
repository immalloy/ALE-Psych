package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

using StringTools;

class LuaStringTools extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Verifica sin un `String` inicia con el contenido de otro
         * 
         * @param str `String` a analizar
         * @param start Contenido para verificar
         * 
         * @return Si `str` empieza con `start`
         */
        set('stringStartsWith', function(str:String, start:String):Bool
        {
            return str.startsWith(start);
        });

        /**
         * Verifica sin un `String` termina con el contenido de otro
         * 
         * @param str `String` a analizar
         * @param end Contenido para verificar
         * 
         * @return Si `str` empieza con `end`
         */
        set('stringEndsWith', function(str:String, end:String):Bool
        {
            return str.endsWith(end);
        });

        /**
         * Corta un `String` en varias partes
         * 
         * @param str `String` a cortar
         * @param split Separador de los cortes
         * 
         * @return Lista con las partes del `String`
         */
        set('stringSplit', function(str:String, split:String):Array<String>
        {
            return str.split(split);
        });

        /**
         * Elimina los espacios al inicio y al final de un `String`
         * 
         * @param str `String` a procesar
         * 
         * @return `String` procesado
         */
        set('stringTrim', function(str:String):String
        {
            return str.trim();
        });
    }
}