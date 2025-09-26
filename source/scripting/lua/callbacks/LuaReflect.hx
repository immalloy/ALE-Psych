package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import Type;

using StringTools;

class LuaReflect extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Obtiene un valor de un objeto
         * 
         * @param tag Variable que se busca
         * 
         * @return Valor de la variable
         */
        set('getProperty', function(tag:String):Dynamic
        {
            return getTag(tag);
        });

        /**
         * Obtiene un valor de un objeto en un grupo
         * 
         * @param tag ID del grupo
         * @param index Posición del objeto en el grupo
         * @param prop Variable que se busca
         * 
         * @return Valor de la variable
         */
        set('getPropertyFromGroup', function(tag:String, index:Int, prop:String):Dynamic
        {
            if (tagIs(tag, FlxTypedGroup))
                return Reflect.getProperty(getTag(tag).members[index], prop);

            return null;
        });

        /**
         * Obtiene un valor de un objeto en un grupo
         * 
         * @param path Ruta de la clase
         * @param prop Variable que se busca
         * 
         * @return Valor de la variable
         */
        set('getPropertyFromClass', function(path:String, prop:String):Dynamic
        {
            var cl:Dynamic = LuaPresetUtils.getClass(path);

            if (cl == null)
                return null;

            return getRecursiveProperty(cl, prop.split('.'));
        });

        /**
         * Define un valor a una variable en un objeto
         * 
         * @param tag ID del objeto
         * @param value Valor de la variable
         */
        set('setProperty', function(tag:String, value:Dynamic)
        {
            var split:Array<String> = tag.split('.');

            var pop:String = split.pop();

            Reflect.setProperty(getTag(split.join('.')), pop, value);
        });

        /**
         * Define un valor a una variable de un objeto de un grupo
         * 
         * @param tag ID del grupo
         * @param index Posicion del objeto en el grupo
         * @param prop Variable del objeto
         * @param value Valor de la variable
         */
        set('setPropertyFromGroup', function(tag:String, index:Int, prop:String, value:Dynamic)
        {
            if (tagIs(tag, FlxTypedGroup))
                Reflect.setProperty(getTag(tag).members[index], prop, value);
        });

        /**
         * Define un valor a una variable en una clase
         * 
         * @param path Ruta de la Clase
         * @param prop Variable que se busca
         * @param value Valor de la variable
         */
        set('setPropertyFromClass', function(path:String, prop:String, value:Dynamic)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(path);

            if (cl == null)
                return;

            var split:Array<String> = prop.split('.');

            var pop:String = split.pop();

            Reflect.setProperty(getRecursiveProperty(cl, split), pop, value);
        });

        /**
         * Define varias propiedades de un objeto
         * 
         * @param tag ID del objeto
         * @param props Table de variables del objeto
         */
        set('setProperties', function(tag:String, props:Any)
        {
            LuaPresetUtils.setMultiProperty(getTag(tag), props);
        });

        /**
         * Define varias propiedades de un objeto en un grupo
         * 
         * @param tag ID del grupo
         * @param index Posicion del objeto en el grupo
         * @param props Tabla de variables del objeto
         */
        set('setPropertiesFromGroup', function(tag:String, index:Int, props:Any)
        {
            if (tagIs(tag, FlxTypedGroup))
                LuaPresetUtils.setMultiProperty(getTag(tag).members[index], props);
        });

        /**
         * Define varias propiedades de una clase
         * 
         * @param path Ruta de la Clase
         * @param props Tabla de variables de la clase
         */
        set('setPropertiesFromClass', function(path:String, props:Any)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(path);

            if (cl == null)
                return;

            LuaPresetUtils.setMultiProperty(cl, props);
        });

        /**
         * Llama una función de un objeto
         * 
         * @param tag Nombre de la función
         * @param args Argumentos de la función
         * 
         * @return Devuelve el valor que devuelve la función
         */
        set('callMethod', function(tag:String, ?args:Array<Dynamic>):Dynamic
        {
            return Reflect.callMethod(null, getTag(tag), args ?? []);
        });

        /**
         * Llama una función de una clase
         * 
         * @param path Ruta de la clase
         * @param func Nombre de la función
         * @param args Argumentos de la función
         * 
         * @return Devuelve el valor que devuelve la función
         */
        set('callMethodFromClass', function(path:String, func:String, ?args:Array<Dynamic>):Dynamic
        {
            var cl:Dynamic = LuaPresetUtils.getClass(path);

            if (cl == null)
                return null;

            return Reflect.callMethod(this, getRecursiveProperty(cl, func.split('.')), args ?? []);
        });

        /**
         * Crea una instancia en una clase
         * 
         * @param tag ID de la instancia
         * @param path Ruta de la clase
         * @param args Argumentos de la instancia
         */
        set('createInstance', function(tag:String, path:String, ?args:Array<Dynamic>)
        {
            var cl:Dynamic = LuaPresetUtils.getClass(path);

            if (cl == null)
                return;

            setTag(tag, Type.createInstance(cl, args ?? []));
        });

        /**
         * Añade una instancia al juego
         * 
         * @param tag ID de la instancia
         * 
         * @deprecated Use `add` en su lugar
         */
        set('addInstance', function(tag:String)
        {
            deprecatedPrint('Use "add" instead of "addInstance"');

            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });
    }
}