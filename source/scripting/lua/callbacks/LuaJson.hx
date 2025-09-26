package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaJson extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Parsea un string en formato JSON
         * 
         * @param str String en JSON
         * 
         * @return Tabla del JSON Parseado
         */
        set('parseJson', function(str:String)
        {
            return Json.parse(str);
        });

        /**
         * Parsea un archivo en formato JSON
         * 
         * @param path Ruta del archivo
         * 
         * @return Tabla del JSON Parseado
         */
        set('parseJsonFile', function(path:String)
        {
            return Paths.json(path);
        });

        /**
         * Pasa una Tabla a un string en formato JSON
         * 
         * @param object Tabla
         * @param space Espacio de identación
         * 
         * @return String en formato JSON
         */
        set('stringifyJson', function(object:Dynamic, ?space:String)
        {
            return Json.stringify(object, space);
        });
    }
}