package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.objects.PsychFlxAnimate;

class LuaAnimate extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Crea un FlxAnimate
         * 
         * @param tag ID del animate
         * @param x Posición en `x`
         * @param y Posición en `y`
         * @param loadFolder Ruta del atlas
         */
        set('makeFlxAnimateSprite', function(tag:String, ?x:Float, ?y:Float, ?loadFolder:String)
        {
            var sprite:PsychFlxAnimate = new PsychFlxAnimate(x, y);

            if (loadFolder != null)
                Paths.loadAnimateAtlas(sprite, loadFolder);

            setTag(tag, sprite);
        });
        
        /**
         * Carga un atlas a un animate
         * 
         * @param tag ID del animate
         * @param folderOrImg Ruta del spritemap
         * @param spriteJson Ruta del JSON del spritemap
         * @param animationJson Ruta del JSON de la animación
         */
        set('loadAnimateAtlas', function(tag:String, folderOrImg:Dynamic, ?spriteJson:Dynamic, ?animationJson:Dynamic)
        {
            if (tagIs(tag, PsychFlxAnimate))
                Paths.loadAnimateAtlas(getTag(tag), folderOrImg, spriteJson, animationJson);
        });

        /**
         * Añade una animación por su símbolo a un animate
         * 
         * @param tag ID del animate
         * @param name Nombre de la animación
         * @param symbol Nombre del símbolo en Adobe Animate
         * @param indices Indices que indican qué frames y en qué orden se reproducen
         * @param framerate Velocidad de la animación en frames
         * @param loop Define si la animación debería o no estar en bucle
         * @param matX Offset del matrix en `x`
         * @param matY Offset del matrix en `y`
         */
        set('addAnimationBySymbolIndices', function(tag:String, name:String, symbol:String, indices:Any, ?framerate:Float, ?loop:Bool, ?matX:Float, ?matY:Float)
        {
            if (!tagIs(tag, PsychFlxAnimate))
                return;

            var obj:PsychFlxAnimate = getTag(tag);

			if(indices == null)
				indices = [0];

			else if(Std.isOfType(indices, String))
			{
				var strIndices:Array<String> = cast (indices, String).trim().split(',');

				var myIndices:Array<Int> = [];

				for (i in 0...strIndices.length)
					myIndices.push(Std.parseInt(strIndices[i]));
				
				indices = myIndices;
			}

			obj.anim.addBySymbolIndices(name, symbol, indices, framerate, loop, matX, matY);

			if (obj.anim.curSymbol == null)
			{
				var obj2:PsychFlxAnimate = cast (obj, PsychFlxAnimate);

                obj2.anim.play(name, true);
			}
        });
    }
}