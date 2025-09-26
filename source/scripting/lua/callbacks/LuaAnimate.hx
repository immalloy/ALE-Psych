package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.objects.PsychFlxAnimate;

class LuaAnimate extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        /**
         * Creates a FlxAnimate
         * 
         * @param tag ID of the animate
         * @param x Position on `x`
         * @param y Position on `y`
         * @param loadFolder Path of the atlas
         */
        set('makeFlxAnimateSprite', function(tag:String, ?x:Float, ?y:Float, ?loadFolder:String)
        {
            var sprite:PsychFlxAnimate = new PsychFlxAnimate(x, y);

            if (loadFolder != null)
                Paths.loadAnimateAtlas(sprite, loadFolder);

            setTag(tag, sprite);
        });
        
        /**
         * Loads an atlas into an animate
         * 
         * @param tag ID of the animate
         * @param folderOrImg Path of the spritemap
         * @param spriteJson Path of the spritemap JSON
         * @param animationJson Path of the animation JSON
         */
        set('loadAnimateAtlas', function(tag:String, folderOrImg:Dynamic, ?spriteJson:Dynamic, ?animationJson:Dynamic)
        {
            if (tagIs(tag, PsychFlxAnimate))
                Paths.loadAnimateAtlas(getTag(tag), folderOrImg, spriteJson, animationJson);
        });

        /**
         * Adds an animation by its symbol to an animate
         * 
         * @param tag ID of the animate
         * @param name Name of the animation
         * @param symbol Symbol name in Adobe Animate
         * @param indices Indices that indicate which frames and in what order they play
         * @param framerate Animation speed in frames
         * @param loop Defines whether the animation should loop or not
         * @param matX Matrix offset on `x`
         * @param matY Matrix offset on `y`
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
