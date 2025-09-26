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
         * Checks if a file exists, either in `assets` or in the mod folder
         * 
         * @param name File path
         * 
         * @return Whether the file exists
         */
        set('checkFileExists', function(name:String):Bool
        {
            return Paths.exists(name);
        });

        /**
         * Saves a file in the mod folder
         * 
         * @param name File path
         * @param content File content
         */
        set('saveFile', function(name:String, content:String)
        {
            File.saveContent(Paths.modFolder() + '/' + name, content);
        });

        /**
         * Deletes a file in the mod folder
         * 
         * @param name File path
         */
        set('deleteFile', function(name:String)
        {
            FileSystem.deleteFile(Paths.modFolder() + '/' + name);
        });
        
        /**
         * Gets the file content as a string
         * 
         * @param name File path
         * 
         * @return File content
         */
        set('getTextFromFile', function(name:String):String
        {
            return Paths.getContent(name);
        });

        /**
         * Gets a list of files in a folder
         * 
         * @param name Folder path
         * 
         * @return List of files in the folder
         */
        set('directoryFileList', function(name:String)
        {
            return Paths.readDirectory(name);
        });
    }
}
