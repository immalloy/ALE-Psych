package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.shaders.ALERuntimeShader;

class LuaShader extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Crea un `ALERuntimeShader`
         * 
         * @param tag ID del shader
         * @param name Nombre del archivo
         */
        set('initLuaShader', function(tag:String, name:String)
        {
            setTag(tag, CoolUtil.createRuntimeShader(name));
        });

        /**
         * Aplica shaders a una cámara
         * 
         * @param camera ID de la cámara
         * @param shaderTags Lista de IDs de los shaders
         */
        set('setCameraShaders', function(camera:String, shaderTags:Array<String>)
            {
                var procShaders:Array<ALERuntimeShader> = [];

                for (tag in shaderTags)
                    if (tagIs(tag, ALERuntimeShader))
                        procShaders.push(getTag(tag));

                if (tagIs(camera, FlxCamera))
                    CoolUtil.setCameraShaders(getTag(camera), procShaders);
            }
        );

        /**
         * Aplica un shader a un sprite
         * 
         * @param tag ID del sprite
         * @param name ID del shader
         */
        set('setSpriteShader', function(tag:String, name:String)
        {
            if (tagIs(tag, FlxSprite) && tagIs(name, ALERuntimeShader))
                getTag(tag).shader = getTag(name);
        });

        /**
         * Define un entero a un shader
         * 
         * @param tag ID del shader
         * @param id ID del entero
         * @param int Valor del entero
         */
        set('setShaderInt', function(tag:String, id:String, int:Int)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setInt(id, int);
            }
        );

        /**
         * Obtiene un entero de un shader
         * 
         * @param tag ID del shader
         * @param id ID del entero
         * 
         * @return Valor del entero
         */
        set('getShaderInt', function(tag:String, id:String):Null<Int>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getInt(id);

                return null;
            }
        );

        /**
         * Define una lista de enteros a un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de enteros
         * @param ints Lista de enteros
         */
        set('setShaderIntArray', function(tag:String, id:String, ints:Array<Int>)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setIntArray(id, ints);
            }
        );

        /**
         * Obtiene una lista de enteros de un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de enteros
         * 
         * @return Lista de enteros
         */
        set('getShaderIntArray', function(tag:String, id:String):Null<Array<Int>>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getIntArray(id);

                return null;
            }
        );

        /**
         * Define un decimal a un shader
         * 
         * @param tag ID del shader
         * @param id ID del decimal
         * @param float Valor del decimal
         */
        set('setShaderFloat', function(tag:String, id:String, float:Float)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setFloat(id, float);
            }
        );

        /**
         * Obtiene un decimal de un shader
         * 
         * @param tag ID del shader
         * @param id ID del decimal
         * 
         * @return Valor del decimal
         */
        set('getShaderFloat', function(tag:String, id:String):Null<Float>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getFloat(id);

                return null;
            }
        );

        /**
         * Define una lista de decimales a un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de decimales
         * @param float Lista de decimales
         */
        set('setShaderFloatArray', function(tag:String, id:String, floats:Array<Float>)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setFloatArray(id, floats);
            }
        );

        /**
         * Obtiene una lista de decimales de un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de decimales
         * 
         * @return Lista de decimales
         */
        set('getShaderFloatArray', function(tag:String, id:String):Null<Array<Float>>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getFloatArray(id);

                return null;
            }
        );

        /**
         * Define un booleano a un shader
         * 
         * @param tag ID del shader
         * @param id ID del booleano
         * @param float Valor del booleano
         */
        set('setShaderBool', function(tag:String, id:String, bool:Bool)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setBool(id, bool);
            }
        );

        /**
         * Obtiene un booleano de un shader
         * 
         * @param tag ID del shader
         * @param id ID del booleano
         * 
         * @return Valor del booleano
         */
        set('getShaderBool', function(tag:String, id:String):Null<Bool>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getBool(id);

                return null;
            }
        );

        /**
         * Define una lista de booleanos a un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de booleanos
         * @param float Lista de booleanos
         */
        set('setShaderBoolArray', function(tag:String, id:String, bools:Array<Bool>)
            {
                if (tagIs(tag, ALERuntimeShader))
                    getTag(tag).setBoolArray(id, bools);
            }
        );

        /**
         * Obtiene una lista de booleanos de un shader
         * 
         * @param tag ID del shader
         * @param id ID de la lista de booleanos
         * 
         * @return Lista de booleanos
         */
        set('getShaderBoolArray', function(tag:String, id:String):Null<Array<Bool>>
            {
                if (tagIs(tag, ALERuntimeShader))
                    return getTag(tag).getBoolArray(id);

                return null;
            }
        );

        /**
         * Define un sampler2D a un shader
         * 
         * @param tag ID del shader
         * @param id ID del sampler2D
         * @param path Ruta de la imagen
         */
        set('setShaderSample2D', function(tag:String, id:String, path:String)
        {
            if (tagIs(tag, ALERuntimeShader))
                getTag(tag).setSampler2D(id, Paths.image(path).bitmap);
        });
    }
}