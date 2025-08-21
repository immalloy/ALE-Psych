package scripting.lua;

class LuaPreset
{
    public function new(lua:LuaScript)
    {
        new scripting.lua.callbacks.LuaSprite(lua);

        new scripting.lua.callbacks.LuaGlobal(lua);

        new scripting.lua.callbacks.LuaReflect(lua);

        new scripting.lua.callbacks.LuaCoolUtil(lua);

        new scripting.lua.callbacks.LuaBasic(lua);

        new scripting.lua.callbacks.LuaRemoved(lua);

        new scripting.lua.callbacks.LuaMouse(lua);

        new scripting.lua.callbacks.LuaTween(lua);

        new scripting.lua.callbacks.LuaTimer(lua);

        new scripting.lua.callbacks.LuaColor(lua);

        new scripting.lua.callbacks.LuaPaths(lua);

        new scripting.lua.callbacks.LuaCamera(lua);

        new scripting.lua.callbacks.LuaObject(lua);

        new scripting.lua.callbacks.LuaSound(lua);

        new scripting.lua.callbacks.LuaDiscord(lua);

        new scripting.lua.callbacks.LuaAnimate(lua);

        new scripting.lua.callbacks.LuaText(lua);

        new scripting.lua.callbacks.LuaShader(lua);

        new scripting.lua.callbacks.LuaKeyManager(lua);

        new scripting.lua.callbacks.LuaSave(lua);

        new scripting.lua.callbacks.LuaFileSystem(lua);

        new scripting.lua.callbacks.LuaStringTools(lua);
    }
}