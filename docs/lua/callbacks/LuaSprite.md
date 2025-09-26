# LuaSprite

### > `makeLuaSprite(tag:String, ?image:String, ?x:Float, ?y:Float)`

#### Crea un `FlxSprite` 

- `tag`: ID del sprite 

- `image`: Ruta de la imagen 

- `x`: Posicion en `x` 

- `y`: Posicion en `y` 

---

### > `loadGraphic(tag:String, sprite:String, ?gridX:Int, =, 0, ?gridY:Int, =, 0)`

#### Carga un grafico a un sprite 

- `tag`: ID del sprite 

- `sprite`: Ruta de la imagen 

- `gridX`: Ancho maximo del grafico 

- `gridY`: Alto maximo del grafico 

---

### > `makeGraphic(tag:String, x:Float, y:Float, ?color:FlxColor)`

#### Crea un grafico cuadrado y lo carga a un sprite 

- `tag`: ID del sprite 

- `x`: Ancho del grafico 

- `y`: Alto del grafico 

- `color`: Color del grafico 

---

### > `loadFrames(tag:String, sprite:String, ?spriteType:String)`

#### Carga un grafico animado a un sprite 

- `tag`: ID del sprite 

- `sprite`: Ruta de la imagen 

- `spriteType`: Tipo de grafico. Puede ser `sparrow`, `packer`, `aseprite` 

---

### > `addAnimationByPrefix(tag:String, name:String, prefix:String, ?framerate:Int, ?loop:Bool)`

#### Añade una animación al sprite 

- `tag`: ID del sprite 

- `name`: Nombre de la animación 

- `prefix`: Prefijo de la animación en el atlas 

- `framerate`: Velocidad de la animación en frames 

- `loop`: Define si la animación debe o no repetirse en bucle 

---

### > `addAnimation(tag:String, name:String, frames:Array<Int>, ?framerate:Int, ?loop:Bool)`

#### Añade una animación al sprite 

- `tag`: ID del sprite 

- `name`: Nombre de la animación 

- `frames`: Indices que indican qué fotogramas se deben reproducir y en qué orden 

- `framerate`: Velocidad de la animación en frames 

- `loop`: Define si la animación debe o no repetirse en bucle 

---

### > `addAnimationByIndices(tag:String, name:String, prefix:String, indices:Array<Int>, ?framerate:Int, ?loop:Bool)`

#### Añade una animación al sprite 

- `tag`: ID del sprite 

- `name`: Nombre de la animación 

- `prefix`: Prefijo de la animación en el atlas 

- `indices`: Indices que indican qué fotogramas se deben reproducir y en qué orden 

- `framerate`: Velocidad de la animación en frames 

- `loop`: Define si la animación debe o no repetirse en bucle 

---

### > `playAnim(tag:String, name:String, ?forced:Bool, ?reversed:Bool, ?startFrame:Int)`

#### Reproduce una animación del sprite 

- `tag`: ID del sprite 

- `name`: Nombre de la animación 

- `forced`: Fuerza a que se reproduzca la animación 

---

### > `setGraphicSize(tag:String, w:Int, h:Int)`

#### Define el tamaño del sprite en píxeles 

- `tag`: ID del sprite 

- `w`: Ancho del sprite 

- `h`: Alto del sprite 

---

### > `updateHitbox(tag:String)`

#### Actualiza la hitbox del sprite 

- `tag`: ID del sprite 

---

### > `setBlendMode(tag:String, mode:String)`

#### Cambia la forma en la que se mezclan los colores de un sprite con otros 

- `tag`: ID del sprite 

- `mode`: Define el modo de mezcla de color. Puede ser `add`,`alpha`,`darken`,`difference`,`erase`,`hardlight`,`invert`,`layer`,`lighten`,`multiply`,`normal`,`overlay`,`screen`,`shader` o `subtract` 

---

### > `getPixelColor(tag:String, x:Int, y:Int):Int`

#### Obtiene el color de un pixel en un sprite 

- `tag`: ID del sprite 

- `x`: Posición en `x` del pixel 

- `y`: Posición en `y` del pixel 

#### `RETURN`: Color del pixel 

---

### > `addLuaSprite(tag:String)`

#### Añade un sprite al juego 

- `tag`: ID del Sprite 

###### `DEPRECATED`: Use `add` en su lugar 

---

### > `removeLuaSprite(tag:String, ?destroy:Bool)`

#### Remueve un sprite del juego 

- `tag`: ID del sprite 

- `destroy`: Define si se debe destruir o no el sprite 

###### `DEPRECATED`: Use `remove` en su lugar 

---

### > `getMidpointX(tag:String):Float`

#### Obtiene la coordenada `x` del punto medio del sprite 

- `tag`: ID del sprite 

#### `RETURN`: `x` del punto medio del sprite 

---

### > `getMidpointY(tag:String):Float`

#### Obtiene la coordenada `y` del punto medio del sprite 

- `tag`: ID del sprite 

#### `RETURN`: `y` del punto medio del sprite 

---

### > `getGraphicMidpointX(tag:String):Float`

#### Obtiene la coordenada `x` del punto medio del gráfico sprite 

- `tag`: ID del sprite 

#### `RETURN`: `x` del punto medio del gráfico sprite 

---

### > `getGraphicMidpointY(tag:String):Float`

#### Obtiene la coordenada `y` del punto medio del gráfico sprite 

- `tag`: ID del sprite 

#### `RETURN`: `y` del punto medio del gráfico sprite 

---

### > `getScreenPositionX(tag:String):Float`

#### Obtiene la posición en `x` del sprite en la pantalla 

- `tag`: ID del sprite 

#### `RETURN`: Posición en `x` del sprite en la pantalla 

---

### > `getScreenPositionY(tag:String):Float`

#### Obtiene la posición en `y` del sprite en la pantalla 

- `tag`: ID del sprite 

#### `RETURN`: Posición en `y` del sprite en la pantalla 

