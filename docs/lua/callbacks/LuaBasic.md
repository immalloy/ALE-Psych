# LuaBasic

### > `setObjectCamera(tag:String, camera:String)`

#### Define la cámara en las que se dibujará un objeto 

- `tag`: ID del objeto 

- `camera`: ID de la cámara 

###### `DEPRECATED`: Use `setObjectCameras` en su lugar 

---

### > `setObjectCameras(tag:String, cameras:Array<String>)`

#### Define las cámaras en las que se dibujará un objeto 

- `tag`: ID del objeto 

- `cameras`: Lista de IDs de las cámaras 

---

### > `objectsOverlap(tag0:String, tag1:String):Bool`

#### Muestra si un objeto está tocando a otro 

- `tag0`: ID del primer objeto 

- `tag1`: ID del segundo objeto 

#### `RETURN`: Si los objetos se están tocando 

