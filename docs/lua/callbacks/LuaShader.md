# LuaShader

### > `initLuaShader(tag:String, name:String)`

#### Crea un `ALERuntimeShader` 

- `tag`: ID del shader 

- `name`: Nombre del archivo 

---

### > `setCameraShaders(camera:String, shaderTags:Array<String>)`

#### Aplica shaders a una cámara 

- `camera`: ID de la cámara 

- `shaderTags`: Lista de IDs de los shaders 

---

### > `setSpriteShader(tag:String, name:String)`

#### Aplica un shader a un sprite 

- `tag`: ID del sprite 

- `name`: ID del shader 

---

### > `setShaderInt(tag:String, id:String, int:Int)`

#### Define un entero a un shader 

- `tag`: ID del shader 

- `id`: ID del entero 

- `int`: Valor del entero 

---

### > `getShaderInt(tag:String, id:String):Null<Int>`

#### Obtiene un entero de un shader 

- `tag`: ID del shader 

- `id`: ID del entero 

#### `RETURN`: Valor del entero 

---

### > `setShaderIntArray(tag:String, id:String, ints:Array<Int>)`

#### Define una lista de enteros a un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de enteros 

- `ints`: Lista de enteros 

---

### > `getShaderIntArray(tag:String, id:String):Null<Array<Int>>`

#### Obtiene una lista de enteros de un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de enteros 

#### `RETURN`: Lista de enteros 

---

### > `setShaderFloat(tag:String, id:String, float:Float)`

#### Define un decimal a un shader 

- `tag`: ID del shader 

- `id`: ID del decimal 

- `float`: Valor del decimal 

---

### > `getShaderFloat(tag:String, id:String):Null<Float>`

#### Obtiene un decimal de un shader 

- `tag`: ID del shader 

- `id`: ID del decimal 

#### `RETURN`: Valor del decimal 

---

### > `setShaderFloatArray(tag:String, id:String, floats:Array<Float>)`

#### Define una lista de decimales a un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de decimales 

- `float`: Lista de decimales 

---

### > `getShaderFloatArray(tag:String, id:String):Null<Array<Float>>`

#### Obtiene una lista de decimales de un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de decimales 

#### `RETURN`: Lista de decimales 

---

### > `setShaderBool(tag:String, id:String, bool:Bool)`

#### Define un booleano a un shader 

- `tag`: ID del shader 

- `id`: ID del booleano 

- `float`: Valor del booleano 

---

### > `getShaderBool(tag:String, id:String):Null<Bool>`

#### Obtiene un booleano de un shader 

- `tag`: ID del shader 

- `id`: ID del booleano 

#### `RETURN`: Valor del booleano 

---

### > `setShaderBoolArray(tag:String, id:String, bools:Array<Bool>)`

#### Define una lista de booleanos a un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de booleanos 

- `float`: Lista de booleanos 

---

### > `getShaderBoolArray(tag:String, id:String):Null<Array<Bool>>`

#### Obtiene una lista de booleanos de un shader 

- `tag`: ID del shader 

- `id`: ID de la lista de booleanos 

#### `RETURN`: Lista de booleanos 

---

### > `setShaderSample2D(tag:String, id:String, path:String)`

#### Define un sampler2D a un shader 

- `tag`: ID del shader 

- `id`: ID del sampler2D 

- `path`: Ruta de la imagen 

