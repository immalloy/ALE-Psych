# LuaSound

### > `playMusic(sound:String, ?volume:Float, ?loop:Bool)`

#### Reproduce música en el juego 

- `sound`: Ruta del audio 

- `volume`: Volumen de la música (de 0 a 1) 

- `loop`: Define si la música está en bucle o no 

---

### > `playSound(sound:String, ?volume:Float, ?tag:String, ?loop:Bool)`

#### Reproduce un sonido 

- `sound`: Ruta del audio 

- `volume`: Volumen del sonido (de 0 a 1) 

- `tag`: ID del sonido 

- `loop`: Define si el sonido estará en bucle o no 

---

### > `stopSound(tag:String)`

#### Detiene un sondio 

- `tag`: ID del sonido 

---

### > `pauseSound(tag:String)`

#### Pausa un sonido 

- `tag`: ID del sonido 

---

### > `resumeSound(tag:String)`

#### Despausa un sonido 

- `tag`: ID del sonido 

---

### > `soundFadeIn(tag:String, ?duration:Float, ?fromValue:Float, ?toValue:Float)`

#### Cambia el volumen de un sonido en un tiempo determinado 

- `tag`: ID del sonido 

- `duration`: Duración del cambio 

- `fromValue`: Volumen inicial 

- `toValue`: Volumen final 

---

### > `soundFadeOut(tag:String, ?duration:Float, ?toValue:Float)`

#### Cambia el volumen de un sonido en un tiempo determinado 

- `tag`: ID del sonido 

- `duration`: Duracion del cambio 

- `toValue`: Volumen final 

---

### > `soundFadeCancel(tag:String)`

#### Detiene el cambio de volumen de un sonido 

- `tag`: ID del sonido 

