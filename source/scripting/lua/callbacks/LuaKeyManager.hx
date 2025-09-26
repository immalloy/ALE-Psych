package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

using StringTools;

class LuaKeyManager extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
    
        /**
         * Defines if a key has been pressed
         * 
         * @param name Key name
         * 
         * @return Whether the key has been pressed
         */
        set('keyboardJustPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justPressed, name.toUpperCase());
        });
    
        /**
         * Defines if a key is being held down
         * 
         * @param name Key name
         * 
         * @return Whether the key is being held down
         */
        set('keyboardPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.pressed, name.toUpperCase());
        });
    
        /**
         * Defines if a key has been released
         * 
         * @param name Key name
         * 
         * @return Whether the key has been released
         */
        set('keyboardReleased', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justReleased, name.toUpperCase());
        });

        /**
         * Defines if a key from the options has been pressed. See [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Key group
         * @param name Key ID
         * 
         * @return Whether the key has been pressed
         */
        set('keyJustPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyJustPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        /**
         * Defines if a key from the options is being held down. See [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Key group
         * @param name Key ID
         * 
         * @return Whether the key is being held down
         */
        set('keyPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        /**
         * Defines if a key from the options has been released. See [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Key group
         * @param name Key ID
         * 
         * @return Whether the key has been released
         */
        set('keyReleased', function(group:String, name:String)
        {
            return FlxG.keys.anyJustReleased(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });
    }
}
