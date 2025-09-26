package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

using StringTools;

class LuaPaths extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
		
		/**
		 * Precarga un sonido
         * 
         * @param file Ruta del audio
         * @param missingPrint Define si se debe mostrar un aviso en caso de que el archivo no exista
		 */
		set('precacheSound', function(file:String, ?missingPrint:Bool)
        {
            Paths.sound(file, missingPrint);
        });

		/**
		 * Precarga música
         * 
         * @param file Ruta del audio
         * @param missingPrint Define si se debe mostrar un aviso en caso de que el archivo no exista
		 */
		set('precacheMusic', function(file:String, ?missingPrint:Bool)
        {
            Paths.music(file, missingPrint);
        });
    }
}