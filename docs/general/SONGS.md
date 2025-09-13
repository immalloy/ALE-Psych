# Adding Songs

For convenience reasons, we have decided to change the way songs are stored. Instead of using the `data` and `songs` folders, we now only use `songs`. Here is an example of how a song should be organized:

```
mods/
└─ modName/
   └─ songs/
      └─ SongName/
         ├─ charts/
         │  ├─ easy.json
         │  ├─ normal.json
         │  └─ hard.json
         ├─ song/
         │  ├─ Inst.ogg
         │  └─ Voices.ogg
         └─ scripts/
            ├─ haxeScript0.hx
            ├─ haxeScript1.hx
            ├─ luaScript0.lua
            └─ luaScript1.lua
```