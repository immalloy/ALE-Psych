# LuaTween

### > `tween(tag:String, obj:String, props:Dynamic, ?time:Float, ?options:Dynamic)`

#### Crea e inicia un `FlxTween` 

- `tag`: ID del tween 

- `obj`: ID del objeto sobre el que actuará el tween 

- `props`: Tabla de variables del objeto que serán modificadas 

- `time`: Duración del tween 

- `options`: Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html) 

---

### > `doTweenX(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `x` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `x` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `doTweenY(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `y` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `y` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `doTweenAngle(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `angle` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `angle` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `doTweenAlpha(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `alpha` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `alpha` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `doTweenZoom(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `zoom` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `zoom` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `doTweenColor(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)`

#### Crea e inicia un tween sobre un objeto y su variable `color` 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `value`: Valor en `color` 

- `time`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `tween` en su lugar 

---

### > `colorTween(tag:String, obj:String, ?time:Float, ?from:FlxColor, ?to:FlxColor, ?options:Dynamic)`

#### Crea e inicia un tween que cambiará el color de un objeto 

- `tag`: ID del tween 

- `obj`: ID del objeto 

- `time`: Duración del tween 

- `from`: Color inicial 

- `to`: Color final 

- `options`: Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html) 

---

### > `cancelTween(tag:String)`

#### Cancela un tween 

- `tag`: ID del tween 

