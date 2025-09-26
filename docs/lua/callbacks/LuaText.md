# LuaText

### > `makeLuaText(tag:String, text:String, width:Int, x:Float, y:Float)`

#### Crea un `FlxText` 

- `tag`: ID del texto 

- `text`: Texto que se mostrara 

- `width`: Ancho máximo del texto 

- `x`: Posicion `x` 

- `y`: Posicion `y` 

---

### > `setTextBorder(tag:String, size:Float, color:FlxColor, ?style:String)`

#### Aplica un contorno a un texto 

- `tag`: ID del texto 

- `size`: Grosor del contorno 

- `color`: Color del contorno 

- `style`: Estilo del contorno. Puede ser `shadow`, `outline`, `outline_fast` o `none` 

---

### > `setTextFont(tag:String, newFont:String)`

#### Aplica un font a un texto 

- `tag`: ID del texto 

- `newFont`: Font a aplicar 

---

### > `addLuaText(tag:String)`

#### Añade un texto al juego 

- `tag`: ID del texto 

###### `DEPRECATED`: Use `add` en su lugar 

---

### > `removeLuaText(tag:String, ?destroy:Bool)`

#### Remueve un texto del juego 

- `tag`: ID del texto 

- `destroy`: Define si se debe destruir o no el texto 

###### `DEPRECATED`: Use `remove` en su lugar 

