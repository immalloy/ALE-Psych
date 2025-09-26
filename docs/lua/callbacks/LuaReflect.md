# LuaReflect

### > `getProperty(tag:String):Dynamic`

#### Obtiene un valor de un objeto 

- `tag`: Variable que se busca 

#### `RETURN`: Valor de la variable 

---

### > `getPropertyFromGroup(tag:String, index:Int, prop:String):Dynamic`

#### Obtiene un valor de un objeto en un grupo 

- `tag`: ID del grupo 

- `index`: Posición del objeto en el grupo 

- `prop`: Variable que se busca 

#### `RETURN`: Valor de la variable 

---

### > `getPropertyFromClass(path:String, prop:String):Dynamic`

#### Obtiene un valor de un objeto en un grupo 

- `path`: Ruta de la clase 

- `prop`: Variable que se busca 

#### `RETURN`: Valor de la variable 

---

### > `setProperty(tag:String, value:Dynamic)`

#### Define un valor a una variable en un objeto 

- `tag`: ID del objeto 

- `value`: Valor de la variable 

---

### > `setPropertyFromGroup(tag:String, index:Int, prop:String, value:Dynamic)`

#### Define un valor a una variable de un objeto de un grupo 

- `tag`: ID del grupo 

- `index`: Posicion del objeto en el grupo 

- `prop`: Variable del objeto 

- `value`: Valor de la variable 

---

### > `setPropertyFromClass(path:String, prop:String, value:Dynamic)`

#### Define un valor a una variable en una clase 

- `path`: Ruta de la Clase 

- `prop`: Variable que se busca 

- `value`: Valor de la variable 

---

### > `setProperties(tag:String, props:Any)`

#### Define varias propiedades de un objeto 

- `tag`: ID del objeto 

- `props`: Table de variables del objeto 

---

### > `setPropertiesFromGroup(tag:String, index:Int, props:Any)`

#### Define varias propiedades de un objeto en un grupo 

- `tag`: ID del grupo 

- `index`: Posicion del objeto en el grupo 

- `props`: Tabla de variables del objeto 

---

### > `setPropertiesFromClass(path:String, props:Any)`

#### Define varias propiedades de una clase 

- `path`: Ruta de la Clase 

- `props`: Tabla de variables de la clase 

---

### > `callMethod(tag:String, ?args:Array<Dynamic>):Dynamic`

#### Llama una función de un objeto 

- `tag`: Nombre de la función 

- `args`: Argumentos de la función 

#### `RETURN`: Devuelve el valor que devuelve la función 

---

### > `callMethodFromClass(path:String, func:String, ?args:Array<Dynamic>):Dynamic`

#### Llama una función de una clase 

- `path`: Ruta de la clase 

- `func`: Nombre de la función 

- `args`: Argumentos de la función 

#### `RETURN`: Devuelve el valor que devuelve la función 

---

### > `createInstance(tag:String, path:String, ?args:Array<Dynamic>)`

#### Crea una instancia en una clase 

- `tag`: ID de la instancia 

- `path`: Ruta de la clase 

- `args`: Argumentos de la instancia 

---

### > `addInstance(tag:String)`

#### Añade una instancia al juego 

- `tag`: ID de la instancia 

###### `DEPRECATED`: Use `add` en su lugar 

