package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

using StringTools;

class LuaKeyManager extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
    
        set('keyboardJustPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justPressed, name.toUpperCase());
        });
    
        set('keyboardPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.pressed, name.toUpperCase());
        });
    
        set('keyboardReleased', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justReleased, name.toUpperCase());
        });

        set('keyJustPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyJustPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        set('keyPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        set('keyReleased', function(group:String, name:String)
        {
            return FlxG.keys.anyJustReleased(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });
    }
}