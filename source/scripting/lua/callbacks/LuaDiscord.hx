package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaDiscord extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('changeDiscordPresence', DiscordRPC.changePresence);

        set('changeDiscordClientID', (id:String) -> {
            DiscordRPC.shutdown();

            DiscordRPC.initialize(id);
        });
    }
}