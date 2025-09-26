# LuaAnimate

### > `makeFlxAnimateSprite(tag:String, ?x:Float, ?y:Float, ?loadFolder:String)`

#### Crea un FlxAnimate 

- `tag`: ID del animate 

- `x`: Posición en `x` 

- `y`: Posición en `y` 

- `loadFolder`: Ruta del atlas 

---

### > `loadAnimateAtlas(tag:String, folderOrImg:Dynamic, ?spriteJson:Dynamic, ?animationJson:Dynamic)`

#### Carga un atlas a un animate 

- `tag`: ID del animate 

- `folderOrImg`: Ruta del spritemap 

- `spriteJson`: Ruta del JSON del spritemap 

- `animationJson`: Ruta del JSON de la animación 

---

### > `addAnimationBySymbolIndices(tag:String, name:String, symbol:String, indices:Any, ?framerate:Float, ?loop:Bool, ?matX:Float, ?matY:Float)`

#### Añade una animación por su símbolo a un animate 

- `tag`: ID del animate 

- `name`: Nombre de la animación 

- `symbol`: Nombre del símbolo en Adobe Animate 

- `indices`: Indices que indican qué frames y en qué orden se reproducen 

- `framerate`: Velocidad de la animación en frames 

- `loop`: Define si la animación debería o no estar en bucle 

- `matX`: Offset del matrix en `x` 

- `matY`: Offset del matrix en `y` 

