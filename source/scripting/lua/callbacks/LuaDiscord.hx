package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaDiscord extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Cambia los detalles del RPC de Discord
         * 
         * @param details Titulo del RPC
         * @param state Subtitulo del RPC
         * @param largeImage Icono Principañ del RPC
         * @param smallImage Icono secundario del RPC
         * @param usesTime Muestra un contador de tiempo en el RPC
         * @param endTime Tiempo de inicio de la cuenta hacia atrás (se debe poner en milisegundos)
         */
        set('changeDiscordPresence', function(details:String, ?state:String, ?largeImage:String, ?smallImage:String, ?usesTime:Bool, ?endTime:Float)
        {
            DiscordRPC.changePresence(details, state, largeImage, smallImage, usesTime, endTime);
        });

        /**
         * Cambia el ID del RPC de Discord
         * 
         * @param id Nuevo ID
         */
        set('changeDiscordClientID', (id:String) -> {
            DiscordRPC.shutdown();

            DiscordRPC.initialize(id);
        });
    }
}