package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaDiscord extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        /**
         * Changes the Discord RPC details
         * 
         * @param details Title of the RPC
         * @param state Subtitle of the RPC
         * @param largeImage Main icon of the RPC
         * @param smallImage Secondary icon of the RPC
         * @param usesTime Shows a timer counter in the RPC
         * @param endTime Start time of the countdown (must be in milliseconds)
         */
        set('changeDiscordPresence', function(details:String, ?state:String, ?largeImage:String, ?smallImage:String, ?usesTime:Bool, ?endTime:Float)
        {
            DiscordRPC.changePresence(details, state, largeImage, smallImage, usesTime, endTime);
        });

        /**
         * Changes the Discord RPC client ID
         * 
         * @param id New ID
         */
        set('changeDiscordClientID', (id:String) -> {
            DiscordRPC.shutdown();

            DiscordRPC.initialize(id);
        });
    }
}
