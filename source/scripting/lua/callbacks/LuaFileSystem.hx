package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import sys.io.File;
import sys.FileSystem;

class LuaFileSystem extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Verifica si un archivo existe, sea en `assets` o en la carpeta del mod
         * 
         * @param name Ruta del archivo
         * 
         * @return Si el archivo existe
         */
        set('checkFileExists', function(name:String):Bool
        {
            return Paths.exists(name);
        });

        /**
         * Guarda un archivo en la carpeta del mod
         * 
         * @param name Ruta del archivo
         * @param content Contenido del archivo
         */
        set('saveFile', function(name:String, content:String)
        {
            File.saveContent(Paths.modFolder() + '/' + name, content);
        });

        /**
         * Elimina un archivo en la carpeta del mod
         * 
         * @param name Ruta del archivo
         */
        set('deleteFile', function(name:String)
        {
            FileSystem.deleteFile(Paths.modFolder() + '/' + name);
        });
        
        /**
         * Obtiene el contenido del archivo en string
         * 
         * @param name Ruta del archivo
         * 
         * @return Contenido del archivo
         */
        set('getTextFromFile', function(name:String):String
        {
            return Paths.getContent(name);
        });

        /**
         * Obtiene una lista de los archivos en una carpeta
         * 
         * @param name Ruta de la carpeta
         * 
         * @return Lista de archivos de la carpeta
         */
        set('directoryFileList', function(name:String)
        {
            return Paths.readDirectory(name);
        });
    }
}