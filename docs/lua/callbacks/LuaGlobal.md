# LuaGlobal

### > `add(tag:String)`

#### Añade un objeto al juego 

- `tag`: ID del objeto 

---

### > `remove(tag:String, ?destroy:Bool)`

#### Remueve un objeto del juego 

- `tag`: ID del objeto 

- `destroy`: Define si el objeto debe ser o no destruido 

---

### > `insert(position:Int, tag:String)`

#### Inserta un objeto en el juego 

- `position`: Posición en la que el objeto será insertado 

- `tag`: ID del objeto 

---

### > `getObjectOrder(tag:String)`

#### Obtiene la posición de un objeto en el juego 

- `tag`: ID del objeto 

#### `RETURN`: Posicion del objeto 

---

### > `setObjectOrder(tag:String, position:Int)`

#### Remueve e inserta un objeto del juego en una posición distinta 

- `tag`: ID del objeto 

- `position`: Nueva posición 

---

### > `getRandomInt(?min:Int, ?max:Int, ?excludes:Array<Int>)`

#### Obtiene un entero aleatorio 

- `min`: Entero más pequeño 

- `max`: Entero mas grande 

- `excludes`: Enteros que no serán usados 

#### `RETURN`: Entero obtenido 

---

### > `getRandomFloat(?min:Float, ?max:Float, ?excludes:Array<Float>)`

#### Obtiene un decimal aleatorio 

- `min`: Decimal más pequeño 

- `max`: Decimal mas grande 

- `excludes`: Decimales que no serán usados 

#### `RETURN`: Decimal obtenido 

---

### > `getRandomBool(?chance:Float)`

#### Obtiene un booleano aleatorio 

- `chance`: Probabilidad de que el valor sea `true` (del 0 al 100) 

#### `RETURN`: Booleano obtenido 

