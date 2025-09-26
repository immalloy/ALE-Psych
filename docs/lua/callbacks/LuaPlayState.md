# LuaPlayState

### > `endSong()`

#### Termina la canción 

---

### > `restartSong()`

#### Reinicia la canción 

---

### > `exitSong()`

#### Sale de la canción hacia el menú correspondiente 

---

### > `cameraSetTarget(target:String)`

#### Define el objetivo de la cámara del juego 

- `target`: Objetivo de la cámara. Puede ser `gf`/`girlfriend`, `dad`/`opponent` o `bf`/`boyfriend` 

---

### > `triggerEvent(name:String, arg1:Dynamic, arg2:Dynamic)`

#### Ejecuta un evento en la canción 

- `name`: Nombre del evento 

- `arg1`: Primer argumento del evento 

- `arg2`: Segundo argumento del evento 

---

### > `characterDance(character:String)`

#### Ejecuta la lógica del baile a un personaje 

- `character`: Personaje que se usará. Puede ser `gf`/`girlfriend`, `dad`/`opponent` o `bf`/`boyfriend` 

---

### > `startDialogue(dialogueFile:String, ?music:String)`

#### Inicia el diálogo de la canción 

- `dialogueFile`: Archivo que contiene el diálogo 

- `music`: Ruta del audio que se reproducirá como música 

---

### > `noteTween(tag:String, note:Int, props:Dynamic, ?time:Float, ?options:Dynamic)`

#### Realiza un tween sobre una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `props`: Tabla de variables que se van a modificar 

- `time`: Duración del tween 

- `options`: Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html) 

---

### > `noteTweenX(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)`

#### Realiza un tween sobre la variable `x` de una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `value`: Valor de la variable 

- `duration`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `noteTween` en su lugar 

---

### > `noteTweenY(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)`

#### Realiza un tween sobre la variable `y` de una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `value`: Valor de la variable 

- `duration`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `noteTween` en su lugar 

---

### > `noteTweenAngle(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)`

#### Realiza un tween sobre la variable `angle` de una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `value`: Valor de la variable 

- `duration`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `noteTween` en su lugar 

---

### > `noteTweenDirection(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)`

#### Realiza un tween sobre la variable `direction` de una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `value`: Valor de la variable 

- `duration`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `noteTween` en su lugar 

---

### > `noteTweenAlpha(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)`

#### Realiza un tween sobre la variable `alpha` de una nota 

- `tag`: ID del tween 

- `note`: Posición de la nota en el strumLine 

- `value`: Valor de la variable 

- `duration`: Duración del tween 

- `ease`: Ease del tween 

###### `DEPRECATED`: Use `noteTween` en su lugar 

---

### > `addBehindGF(obj:String)`

#### Añade un objeto al juego detrás de la entidad Girlfriend 

- `obj`: ID del objeto 

---

### > `addBehindBF(obj:String)`

#### Añade un objeto al juego detrás de la entidad Boyfriend 

- `obj`: ID del objeto 

---

### > `addBehindDad(obj:String)`

#### Añade un objeto al juego detrás de la entidad Dad 

- `obj`: ID del objeto 

