package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

using StringTools;

class LuaKeyManager extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
    
        /**
         * Define si una tecla ha sido presionada
         * 
         * @param name Nombre de la tecla
         * 
         * @return Si la tecla ha sido presionada
         */
        set('keyboardJustPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justPressed, name.toUpperCase());
        });
    
        /**
         * Define si una tecla está siendo presionada
         * 
         * @param name Nombre de la tecla
         * 
         * @return Si la tecla está siendo presionada
         */
        set('keyboardPressed', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.pressed, name.toUpperCase());
        });
    
        /**
         * Define si una tecla ha sido soltada
         * 
         * @param name Nombre de la tecla
         * 
         * @return Si la tecla ha sido soltada
         */
        set('keyboardReleased', function(name:String)
        {
            return Reflect.getProperty(FlxG.keys.justReleased, name.toUpperCase());
        });

        /**
         * Define si una tecla de las opciones ha sido presionada. Véase [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Grupo de la tecla
         * @param group ID de la tecla
         * 
         * @return Si la tecla ha sido presionada
         */
        set('keyJustPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyJustPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        /**
         * Define si una tecla de las opciones está siendo presionada. Véase [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Grupo de la tecla
         * @param group ID de la tecla
         * 
         * @return Si la tecla está siendo presionada
         */
        set('keyPressed', function(group:String, name:String)
        {
            return FlxG.keys.anyPressed(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });

        /**
         * Define si una tecla de las opciones ha sido soltada. Véase [ClientPrefs](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/core/config/ClientPrefs.hx)
         * 
         * @param group Grupo de la tecla
         * @param group ID de la tecla
         * 
         * @return Si la tecla ha sido soltada
         */
        set('keyReleased', function(group:String, name:String)
        {
            return FlxG.keys.anyJustReleased(Reflect.getProperty(Reflect.getProperty(ClientPrefs.controls, group), name));
        });
    }
}