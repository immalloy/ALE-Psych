# LuaSave

### > `flushSaveData(name:String)`

#### Guarda los archivos de guardado 

- `name`: ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls` 

---

### > `getDataFromSave(name:String, variable:String):Dynamic`

#### Obtiene un valor de un archivo de guardado 

- `name`: ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls` 

- `variable`: Variable que se busca 

#### `RETURN`: Valor de la variable 

---

### > `setDataFromSave(name:String, values:Any)`

#### Define un valor en un archivo de guardado 

- `name`: ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls` 

- `values`: Tabla de variables que serán definidas o modifcadas 

---

### > `eraseSaveData(name:String)`

#### Elimina los datos de un archivo de guardado 

- `name`: ID del archivo de guardado. Puede ser `preferences`, `score`, `custom`, `controls` 

