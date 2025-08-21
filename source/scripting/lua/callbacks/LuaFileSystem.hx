package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaFileSystem extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('checkFileExists', function(name:String)
        {
            return Paths.fileExists(name);
        });

        set('saveFile', function(name:String, content:String)
        {
            File.saveContent(Paths.modFolder() + '/' + name, content);
        });

        set('deleteFile', function(name:String)
        {
            FileSystem.deleteFile(Paths.getPath(name));
        });
        
        set('getTextFromFile', function(name:String)
        {
            return File.getContent(Paths.getPath(name));
        });

        set('directoryFileList', function(name:String)
        {
            return FileSystem.readDirectory(Paths.getPath(name));
        });
    }
}