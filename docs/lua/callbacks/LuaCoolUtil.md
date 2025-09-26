# LuaCoolUtil

### > `colorFromString(str:String):FlxColor`

#### Obtiene un color desde un String que contenga su código en HEX 

- `str`: String con el código HEX 

#### `RETURN`: Color obtenido 

---

### > `getDominantColor(tag:String):FlxColor`

#### Obtiene el color que más aparece en un sprite 

- `tag`: ID del sprite 

#### `RETURN`: Color más frecuente 

---

### > `colorFromArray(arr:Array<Int>):FlxColor`

#### Obtiene un color desde una lista 

- `arr`: Lista con el color en RGB 

#### `RETURN`: Color obtenido 

---

### > `resetEngine()`

#### Reinicia el motor y algunas de sus variables 

---

### > `reloadGameMetadata()`

#### Recarga los metadatos del motor que se encuentran en `data.json` 

---

### > `resizeGame(width:Int, height:Int, ?centerWindow:Bool)`

#### Cambia el tamaño de la ventana y el juego 

- `width`: Ancho del juego 

- `height`: Alto del juego 

- `centerWindow`: Define si se debe centrar el juego en la pantalla o no 

---

### > `searchComplexFile(path:String, ?missingPrint:Bool):String`

#### Busca la ruta de un archivo ignorando espacios y mayúsculas, siendo más flexible 

- `path`: Ruta del archivo 

- `missingPrint`: Define si se debe dar un aviso o no en caso de que el archivo no exista 

#### `RETURN`: Ruta real del archivo 

---

### > `searchFile(parent:String, file:String):String`

#### Busca la ruta de un archivo dentro de una carpeta ignorando espacios y mayúsculas 

- `parent`: Carpeta donde se busca 

- `file`: Archivo que se busca 

#### `RETURN`: Ruta real del archivo 

---

### > `openFolder(folder:String, ?absolute:Bool)`

#### Abre el explorador de archivos en una carpeta específica 

- `folder`: Carpeta donde se abrirá 

- `absolute`: Define si se tendrá en cuenta a partir de la carpeta raíz del computador o desde la carpeta del juego 

---

### > `formatToSongPath(str:String):String`

#### Pasa un string a minúsculas y cambia los espacios por guiones 

- `str`: String a procesar 

#### `RETURN`: String procesado 

---

### > `debugTrace(text:Dynamic, ?type:PrintType, ?customType:String, =, ?customColor:FlxColor)`

#### Imprime un texto que incluye la hora en la que fue impreso y algunos colores que ayudan a distinguir entre la información mostrada 

- `text`: Texto que se desea mostrar 

- `type`: Tipo de texto que se desea mostrar. Puede ser `error`, `warning`, `deprecated`, `trace`, `hscript`, `lua`, `missing_file`, `missing_folder`, `custom` o `pop-up`, 

- `customType`: Asigna un tipo personalizado de texto 

- `customColor`: Asigna un color personalizado del texto 

---

### > `ansiColorString(str:String, color:FlxColor):String`

#### Ayuda a obtener un texto el cual al ser impreso en la consola tendrá el color indicado 

- `str`: Texto a colorear 

- `color`: Color a aplicar 

#### `RETURN`: Texto coloreado 

---

### > `floorDecimal(num:Float, decimals:Int):Float`

#### Redondea un número decimal, pero permitiendo que se muestren cierta cantidad de decimales 

- `num`: Número a redondear 

- `decimals`: Cantidad máxima de decimales que se mostrarán 

#### `RETURN`: Número redondeado con sus decimales 

---

### > `quantize(f:Float, snap:Float):Float`

#### Ajusta un número a una rejilla 

- `f`: Valor original 

- `snap`: Cantidad de divisiones o pasos 

#### `RETURN`: Valor cuantizado al múltiplo más cercano de 1/snap 

---

### > `numberArray(max:Int, ?min:Int):Array<Int>`

#### Genera una lista de números 

- `max`: Numero maximo de la lista 

- `min`: Numero minimo de la lista 

#### `RETURN`: Lista de numeros 

---

### > `fpsLerp(v1:Float, v2:Float, ratio:Float):Float`

#### Interpola entre dos valores tomando en cuenta los FPS 

- `v1`: Valor inicial 

- `v2`: Valor final 

- `ratio`: Proporción de interpolación (0 a 1) 

#### `RETURN`: Valor interpolado ajustado a la tasa de FPS 

---

### > `fpsRatio(ratio:Float):Float`

#### Ajusta un ratio en función del tiempo transcurrido y lo limita entre 0 y 1 

- `ratio`: Proporción base 

#### `RETURN`: Proporción corregida según los FPS 

---

### > `loadPlayStateSong(name:String, difficulty:String):PlayStateJSONData`

#### Precarga el JSON de una canción en PlayState 

- `name`: Nombre de la canción 

- `difficulty`: Dificultad de la canción 

#### `RETURN`: Tabla con la ruta de la canción (`.route`) y el JSON cargado (`.json`) 

---

### > `loadSong(name:String, difficulty:String, ?goToPlayState)`

#### Carga una canción 

- `name`: Nombre de la canción 

- `difficulty`: Dificultad de la canción 

- `goToPlayState`: Define si el juego se tiene que dirigir o no a PlayState 

---

### > `loadWeek(weekName:String, names:Array<String>, difficulty:String, ?goToPlayState:Bool)`

#### Carga una week 

- `weekName`: Nombre de la week 

- `names`: Lista con los nombres de las canciones 

- `difficulty`: Dificultad de la week 

- `goToPlayState`: Define si el juego se tiene que dirigir o no a PlayState 

---

### > `resetState()`

#### Reinicial el estado actual 

---

### > `switchState(state:String, ?args:Array<Dynamic>, ?skipTransIn:Bool, ?skipTransOut:Bool)`

#### Dirige el juego a un state 

- `state`: Ruta de la clase del estado 

- `args`: Argumentos de la instancia de la clase 

- `skipTransIn`: Define si la transición de entrada será mostrada o no 

- `skipTransOut`: Defina si la transición de salida será mostrada o no 

---

### > `openSubState(substate:String, ?args:Array<Dynamic>)`

#### Abre un sub-estado 

- `substate`: Ruta de la clase del subestado 

- `args`: Argumentos de la instancia de la clase 

---

### > `capitalizeString(str:String):String`

#### Capitaliza un texto 

- `str`: String a capitalizar 

#### `RETURN`: String capitalizado 

---

### > `listFromString(str:String):Array<String>`

#### Extrae una lista basada en los saltos de línea de un string 

- `str`: String a procesar 

#### `RETURN`: Lista de línease 

---

### > `browserLoad(site:String)`

#### Abre una URL en el navegador 

- `site`: URL del Sitio 

---

### > `getBuildTarget():String`

#### Obtiene el target al que fue compilado el motor 

#### `RETURN`: Target obtenido 

