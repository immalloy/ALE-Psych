# LuaFileSystem

### > `checkFileExists(name:String):Bool`

#### Verifica si un archivo existe, sea en `assets` o en la carpeta del mod 

- `name`: Ruta del archivo 

#### `RETURN`: Si el archivo existe 

---

### > `saveFile(name:String, content:String)`

#### Guarda un archivo en la carpeta del mod 

- `name`: Ruta del archivo 

- `content`: Contenido del archivo 

---

### > `deleteFile(name:String)`

#### Elimina un archivo en la carpeta del mod 

- `name`: Ruta del archivo 

---

### > `getTextFromFile(name:String):String`

#### Obtiene el contenido del archivo en string 

- `name`: Ruta del archivo 

#### `RETURN`: Contenido del archivo 

---

### > `directoryFileList(name:String)`

#### Obtiene una lista de los archivos en una carpeta 

- `name`: Ruta de la carpeta 

#### `RETURN`: Lista de archivos de la carpeta 

