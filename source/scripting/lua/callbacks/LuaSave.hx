package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import flixel.util.FlxSave;

class LuaSave extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Guarda los archivos de guardado
         * 
         * @param name ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls`
         */
        set('flushSaveData', function(name:String)
        {
            cast(Reflect.getProperty(CoolUtil.save, name), FlxSave).flush();
        });

        /**
         * Obtiene un valor de un archivo de guardado
         * 
         * @param name ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls`
         * @param variable Variable que se busca
         * 
         * @return Valor de la variable
         */
        set('getDataFromSave', function(name:String, variable:String):Dynamic
        {
            var result = cast(Reflect.getProperty(CoolUtil.save, name), FlxSave).data;

            var split:Array<String> = variable.split('.');

            for (sp in split)
                result = Reflect.getProperty(result, sp);

            return result;
        });

        /**
         * Define un valor en un archivo de guardado
         * 
         * @param name ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls`
         * @param values Tabla de variables que serán definidas o modifcadas
         */
        set('setDataFromSave', function(name:String, values:Any)
        {
            LuaPresetUtils.setMultiProperty(cast(Reflect.getProperty(CoolUtil.save, name), FlxSave).data, values);
        });

        /**
         * Elimina los datos de un archivo de guardado
         * 
         * @param name ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls`
         */
        set('eraseSaveData', function(name:String)
        {
            cast(Reflect.getProperty(CoolUtil.save, name), FlxSave).erase();
        });
    }
}