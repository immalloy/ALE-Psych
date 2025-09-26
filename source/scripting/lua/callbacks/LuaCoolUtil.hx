package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.shaders.ALERuntimeShader;

import flixel.FlxState;
import flixel.FlxSubState;

import core.enums.PrintType;

import core.structures.PlayStateJSONData;

class LuaCoolUtil extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Obtiene un color desde un String que contenga su código en HEX
         * 
         * @param str String con el código HEX
         * 
         * @return Color obtenido
         */
        set('colorFromString', function(str:String):FlxColor
        {
            return CoolUtil.colorFromString(str);
        });

        /**
         * Obtiene el color que más aparece en un sprite
         * 
         * @param tag ID del sprite
         * 
         * @return Color más frecuente
         */
        set('getDominantColor', function(tag:String):FlxColor
        {
            if (tagIs(tag, FlxSprite))
                return CoolUtil.dominantColor(getTag(tag));

            return FlxColor.BLACK;
        });

        /**
         * Obtiene un color desde una lista
         * 
         * @param arr Lista con el color en RGB
         * 
         * @return Color obtenido
         */
        set('colorFromArray', function(arr:Array<Int>):FlxColor
        {
            return CoolUtil.colorFromArray(arr);
        });


        /**
         * Reinicia el motor y algunas de sus variables
         */
        set('resetEngine', function()
        {
            CoolUtil.resetEngine();
        });

        /**
         * Recarga los metadatos del motor que se encuentran en `data.json`
         */
        set('reloadGameMetadata', function()
        {
            CoolUtil.reloadGameMetadata();
        });
        
        /**
         * Cambia el tamaño de la ventana y el juego
         * 
         * @param width Ancho del juego
         * @param height Alto del juego
         * @param centerWindow Define si se debe centrar el juego en la pantalla o no
         */
        set('resizeGame', function(width:Int, height:Int, ?centerWindow:Bool)
        {
            CoolUtil.resizeGame(width, height, centerWindow);
        });


        /**
         * Busca la ruta de un archivo ignorando espacios y mayúsculas, siendo más flexible
         * 
         * @param path Ruta del archivo
         * @param missingPrint Define si se debe dar un aviso o no en caso de que el archivo no exista
         * 
         * @return Ruta real del archivo
         */
        set('searchComplexFile', function(path:String, ?missingPrint:Bool):String
        {
            return CoolUtil.searchComplexFile(path, missingPrint);
        });

        /**
         * Busca la ruta de un archivo dentro de una carpeta ignorando espacios y mayúsculas
         * 
         * @param parent Carpeta donde se busca
         * @param file Archivo que se busca
         * 
         * @return Ruta real del archivo
         */
        set('searchFile', function(parent:String, file:String):String
        {
            return CoolUtil.searchFile(parent, file);
        });

        /**
         * Abre el explorador de archivos en una carpeta específica
         * 
         * @param folder Carpeta donde se abrirá
         * @param absolute Define si se tendrá en cuenta a partir de la carpeta raíz del computador o desde la carpeta del juego
         */
        set('openFolder', function(folder:String, ?absolute:Bool)
        {
            CoolUtil.openFolder(folder, absolute);
        });

        /**
         * Pasa un string a minúsculas y cambia los espacios por guiones
         * 
         * @param str String a procesar
         * 
         * @return String procesado
         */
        set('formatToSongPath', function(str:String):String
        {
            return CoolUtil.formatToSongPath(str);
        });


        /**
         * Imprime un texto que incluye la hora en la que fue impreso y algunos colores que ayudan a distinguir entre la información mostrada
         * 
         * @param text Texto que se desea mostrar
         * @param type Tipo de texto que se desea mostrar. Puede ser `error`, `warning`, `deprecated`, `trace`, `hscript`, `lua`, `missing_file`, `missing_folder`, `custom` o `pop-up`,
         * @param customType Asigna un tipo personalizado de texto
         * @param customColor Asigna un color personalizado del texto
         */
        set('debugTrace', function(text:Dynamic, ?type:PrintType, ?customType:String = '', ?customColor:FlxColor)
        {
            CoolUtil.debugTrace(text, type, customType, customColor);
        });

        /**
         * Ayuda a obtener un texto el cual al ser impreso en la consola tendrá el color indicado
         * 
         * @param str Texto a colorear
         * @param color Color a aplicar
         * 
         * @return Texto coloreado
         */
        set('ansiColorString', function(str:String, color:FlxColor):String
        {
            return CoolUtil.ansiColorString(str, color);
        });


        /**
         * Redondea un número decimal, pero permitiendo que se muestren cierta cantidad de decimales
         * 
         * @param num Número a redondear
         * @param decimals Cantidad máxima de decimales que se mostrarán
         * 
         * @return Número redondeado con sus decimales
         */
        set('floorDecimal', function(num:Float, decimals:Int):Float
        {
            return CoolUtil.floorDecimal(num, decimals);
        });

        /**
         * Ajusta un número a una rejilla
         * 
         * @param f Valor original
         * @param snap Cantidad de divisiones o pasos
         * 
         * @return Valor cuantizado al múltiplo más cercano de 1/snap
         */
        set('quantize', function(f:Float, snap:Float):Float
        {
            return CoolUtil.quantize(f, snap);
        });

        /**
         * Genera una lista de números
         * 
         * @param max Numero maximo de la lista
         * @param min Numero minimo de la lista
         * 
         * @return Lista de numeros
         */
        set('numberArray', function(max:Int, ?min:Int):Array<Int>
        {
            return CoolUtil.numberArray(max, min);
        });

        /**
         * Interpola entre dos valores tomando en cuenta los FPS
         * 
         * @param v1 Valor inicial
         * @param v2 Valor final
         * @param ratio Proporción de interpolación (0 a 1)
         * 
         * @return Valor interpolado ajustado a la tasa de FPS
         */
        set('fpsLerp', function(v1:Float, v2:Float, ratio:Float):Float
        {
            return CoolUtil.fpsLerp(v1, v2, ratio);
        });

        /**
         * Ajusta un ratio en función del tiempo transcurrido y lo limita entre 0 y 1
         * 
         * @param ratio Proporción base
         * 
         * @return Proporción corregida según los FPS
         */
        set('fpsRatio', function(ratio:Float):Float
        {
            return CoolUtil.fpsRatio(ratio);
        });


        /**
         * Precarga el JSON de una canción en PlayState
         * 
         * @param name Nombre de la canción
         * @param difficulty Dificultad de la canción
         * 
         * @return Tabla con la ruta de la canción (`.route`) y el JSON cargado (`.json`)
         */
        set('loadPlayStateSong', function(name:String, difficulty:String):PlayStateJSONData
        {
            return CoolUtil.loadPlayStateSong(name, difficulty);
        });
        
        /**
         * Carga una canción
         * 
         * @param name Nombre de la canción
         * @param difficulty Dificultad de la canción
         * @param goToPlayState Define si el juego se tiene que dirigir o no a PlayState
         */
        set('loadSong', function(name:String, difficulty:String, ?goToPlayState)
        {
            CoolUtil.loadSong(name, difficulty, goToPlayState);
        });

        /**
         * Carga una week
         * 
         * @param weekName Nombre de la week
         * @param names Lista con los nombres de las canciones
         * @param difficulty Dificultad de la week
         * @param goToPlayState Define si el juego se tiene que dirigir o no a PlayState
         */
        set('loadWeek', function(weekName:String, names:Array<String>, difficulty:String, ?goToPlayState:Bool)
        {
            CoolUtil.loadWeek(weekName, names, difficulty, goToPlayState);
        });

        
        /**
         * Reinicial el estado actual
         */
        set('resetState', function()
        {
            CoolUtil.resetState();
        });

        /**
         * Dirige el juego a un state
         * 
         * @param state Ruta de la clase del estado
         * @param args Argumentos de la instancia de la clase
         * @param skipTransIn Define si la transición de entrada será mostrada o no
         * @param skipTransOut Defina si la transición de salida será mostrada o no
         */
        set('switchState', function(state:String, ?args:Array<Dynamic>, ?skipTransIn:Bool, ?skipTransOut:Bool)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(state);

            if (cl == null)
                return;

            CoolUtil.switchState(Type.createInstance(cl, args ?? []), skipTransIn, skipTransOut);
        });

        /**
         * Abre un sub-estado
         * 
         * @param substate Ruta de la clase del subestado
         * @param args Argumentos de la instancia de la clase
         */
        set('openSubState', function(substate:String, ?args:Array<Dynamic>)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(substate);

            if (cl == null)
                return;

            CoolUtil.switchState(Type.createInstance(cl, args ?? []));
        });


        /**
         * Capitaliza un texto
         * 
         * @param str String a capitalizar
         * 
         * @return String capitalizado
         */
        set('capitalizeString', function(str:String):String
        {
            return CoolUtil.capitalize(str);
        });

        /**
         * Extrae una lista basada en los saltos de línea de un string
         * 
         * @param str String a procesar
         * 
         * @return Lista de línease
         */
        set('listFromString', function(str:String):Array<String>
        {
            return CoolUtil.listFromString(str);
        });


        /**
         * Abre una URL en el navegador
         * 
         * @param site URL del Sitio
         */
        set('browserLoad', function(site:String)
        {
            CoolUtil.browserLoad(site);
        });

        /**
         * Obtiene el target al que fue compilado el motor
         * 
         * @return Target obtenido
         */
        set('getBuildTarget', function():String
        {
            return CoolUtil.getBuildTarget();
        });
    }
}