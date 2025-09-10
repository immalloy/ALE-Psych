package utils;

import core.enums.PathType;

import haxe.ds.StringMap;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.sound.FlxSound;
import flixel.util.FlxColor;

import funkin.visuals.objects.PsychFlxAnimate;

import openfl.display.BitmapData;
import openfl.display3D.textures.RectangleTexture;

import core.backend.Mods;

import openfl.media.Sound;

class Paths
{
    public static inline final IMAGE_EXT = 'png';
	public static inline final SOUND_EXT = #if web 'mp3' #else 'ogg' #end;
	public static inline final VIDEO_EXT = 'mp4';

	public static var cachedGraphics:StringMap<FlxGraphic> = new StringMap<FlxGraphic>();
    public static var cachedSounds:StringMap<Sound> = new StringMap<Sound>();

    public static function image(file:String, missingPrint:Bool = true):FlxGraphic
    {
        var path = 'images/' + file + '.' + IMAGE_EXT;

        var bitmap:BitmapData = null;

        if (cachedGraphics.exists(path))
            return cachedGraphics.get(path);
        else if (fileExists(path))
            bitmap = BitmapData.fromFile(getPath(path));

        if (bitmap != null)
        {
            var returnValue = cacheBitmap(path, bitmap);

            if (returnValue != null)
                return returnValue;
        }

        if (missingPrint)
            debugTrace(path, MISSING_FILE);

        return null;
    }
    
	public static function cacheBitmap(file:String, ?bitmap:BitmapData = null):FlxGraphic
	{
		if (bitmap == null)
		{
			if (FileSystem.exists(file))
				bitmap = BitmapData.fromFile(file);
            
			if (bitmap == null)
                return null;
		}

		if (ClientPrefs.data.cacheOnGPU)
		{
			var texture:RectangleTexture = FlxG.stage.context3D.createRectangleTexture(bitmap.width, bitmap.height, BGRA, true);
			texture.uploadFromBitmapData(bitmap);

			bitmap.image.data = null;
			bitmap.dispose();
			bitmap.disposeImage();
			bitmap = BitmapData.fromTexture(texture);
		}

		var newGraphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, file);
		newGraphic.persist = true;
		newGraphic.destroyOnNoUse = false;
        
		cachedGraphics.set(file, newGraphic);

		return newGraphic;
	}

	inline static public function voices(route:String, postfix:String = null, missingPrint:Bool = true)
		return returnSound(route + '/song/Voices' + (postfix ?? ''), missingPrint);

	inline static public function inst(route:String, missingPrint:Bool = true)
		return returnSound(route + '/song/Inst', missingPrint);

    public static function music(file:String, missingPrint:Bool = true):Sound
        return returnSound('music/' + file, missingPrint);

    public static function sound(file:String, missingPrint:Bool = true):Sound
        return returnSound('sounds/' + file, missingPrint);

    private static function returnSound(file:String, missingPrint:Bool = true):Sound
    {
        var path = file + '.' + SOUND_EXT;

        var sound:Sound = null;

        if (cachedSounds.exists(path))
            return cachedSounds.get(path);
        else if (fileExists(path))
            sound = Sound.fromFile(getPath(path));

        if (sound != null)
        {
            var returnValue = cacheSound(path, sound);

            if (returnValue != null)
                return returnValue;
        }

        if (missingPrint)
            debugTrace(path, MISSING_FILE);

        return null;
    }

    public static function cacheSound(file:String, ?sound:Sound = null):Sound
    {
        if (sound == null)
        {
            if (FileSystem.exists(file))
                sound = Sound.fromFile(file);

            if (sound == null)
                return null;
        }

        cachedSounds.set(file, sound);

        return sound;
    }

    public static function xml(file:String, missingPrint:Bool = true):String
    {
        var path = 'images/' + file + '.xml';

        if (!fileExists(path))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);

            return null;
        }

        return File.getContent(getPath(path));
    }

    public static function model(file:String, missingPrint:Bool = true):String
    {
        var path:String = 'models/' + file + '.obj';

        if (!fileExists(path))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);

            return null;
        }

        return getPath(path);
    }

    public static function video(file:String, missingPrint:Bool = true):String
    {
        var path = 'videos/' + file + '.' + VIDEO_EXT;

        if (!fileExists(path))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);

            return null;
        }

        return getPath(path);
    }

    public static function imageTxt(file:String, missingPrint:Bool = true):String
    {
        var path = 'images/' + file + '.txt';

        if (!fileExists(path))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);

            return null;
        }

        return File.getContent(getPath(path));
    }
    
    public static function imageJson(file:String, missingPrint:Bool = true):String
    {
        var path = 'images/' + file + '.json';

        if (!fileExists(file))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);
            
            return null;
        }

        return File.getContent(getPath(path));
    }

    public static function getAtlas(file:String, missingPrint:Bool = true):FlxAtlasFrames
        return getSparrowAtlas(file, false) ?? getPackerAtlas(file, false) ?? getAsepriteAtlas(file, missingPrint);

    public static function getSparrowAtlas(file:String, missingPrint:Bool = true):FlxAtlasFrames
    {
        var graphic = image(file, missingPrint);
        var xmlContent = xml(file, missingPrint);

        if (graphic == null || xmlContent == null)
            return null;

        return FlxAtlasFrames.fromSparrow(graphic, xmlContent);
    }
    
    public static function getPackerAtlas(file:String, missingPrint:Bool = true):FlxAtlasFrames
    {
        var graphic = image(file, missingPrint);
        var txtContent = imageTxt(file, missingPrint);

        if (graphic == null || txtContent == null)
            return null;

        return FlxAtlasFrames.fromSpriteSheetPacker(graphic, txtContent);
    }

    public static function getAsepriteAtlas(file:String, missingPrint:Bool = true):FlxAtlasFrames
    {
        var graphic = image(file, missingPrint);
        var jsonContent = imageJson(file, missingPrint);

        if (graphic == null || jsonContent == null)
            return null;

        return FlxAtlasFrames.fromTexturePackerJson(graphic, jsonContent);
    }

    public static function getMultiAtlas(files:Array<String>, missingPrint:Bool = true):FlxAtlasFrames
        return getMultiAtlasBase(Paths.getAtlas, files, missingPrint);

    public static function getMultiSparrowAtlas(files:Array<String>, missingPrint:Bool = true):FlxAtlasFrames
        return getMultiAtlasBase(Paths.getSparrowAtlas, files, missingPrint);

    public static function getMultiPackerAtlas(files:Array<String>, missingPrint:Bool = true):FlxAtlasFrames
        return getMultiAtlasBase(Paths.getPackerAtlas, files, missingPrint);

    public static function getMultiAsepriteAtlas(files:Array<String>, missingPrint:Bool = true):FlxAtlasFrames
        return getMultiAtlasBase(Paths.getAsepriteAtlas, files, missingPrint);

    @:unreflective private static function getMultiAtlasBase(atlasFunc:String -> Bool -> FlxAtlasFrames, files:Array<String>, missingPrint:Bool = true):FlxAtlasFrames
    {
		var parentFrames:FlxAtlasFrames = atlasFunc(files[0], missingPrint);

		if (files.length > 1)
		{
			var original:FlxAtlasFrames = parentFrames;

			parentFrames = new FlxAtlasFrames(parentFrames.parent);
			parentFrames.addAtlas(original, true);

			for (i in 1...files.length)
			{
				var extraFrames:FlxAtlasFrames = atlasFunc(files[i], missingPrint);

				if (extraFrames != null)
					parentFrames.addAtlas(extraFrames, true);
			}
		}

		return parentFrames;
    }

    public static function font(file:String, missingPrint:Bool = true):String
    {
        var path = 'fonts/' + file;

        if (!fileExists(path))
        {
            if (missingPrint)
                debugTrace(path, MISSING_FILE);

            return null;
        }

        return getPath(path);
    }

    public static inline function getPath(file:String, missingPrint:Bool = true):String
    {
        #if MODS_ALLOWED
        if (fileExists(file, MODS))
            return modFolder() + '/' + file;
        #end

        if (fileExists(file, ASSETS))
            return 'assets/' + file;

        if (missingPrint)
            debugTrace(file, MISSING_FILE);

        return null;
    }

    public static inline function fileExists(path:String, ?pathMode:PathType = BOTH):Bool
    {
        #if MODS_ALLOWED
        if (FileSystem.exists(modFolder() + '/' + path) && (pathMode == MODS || pathMode == BOTH) && Mods.folder != '' && Mods.folder != null)
            return true;
        #end

        if (FileSystem.exists('assets/' + path) && (pathMode == ASSETS || pathMode == BOTH))
            return true;
        
        return false;
    }

    public static inline function modFolder():String
        return 'mods/' + Mods.folder;
    
    public static function clearEngineCache()
    {
		@:privateAccess
		for (key in FlxG.bitmap._cache.keys())
		{
			var obj = FlxG.bitmap._cache.get(key);

			if (obj != null && !cachedGraphics.exists(key))
			{
				FlxG.bitmap._cache.remove(key);

				obj.destroy();
			}
		}

        for (key in cachedGraphics.keys())
            cachedGraphics.remove(key);

        for (key in cachedSounds.keys())
            cachedSounds.remove(key);
    }

	#if flxanimate
	public static function loadAnimateAtlas(spr:PsychFlxAnimate, folderOrImg:Dynamic, spriteJson:Dynamic = null, animationJson:Dynamic = null)
	{
		var changedAnimJson = false;
		var changedAtlasJson = false;
		var changedImage = false;
		
		if (spriteJson != null)
		{
			changedAtlasJson = true;

			spriteJson = File.getContent(spriteJson);
		}

		if(animationJson != null) 
		{
			changedAnimJson = true;

			animationJson = File.getContent(animationJson);
		}

		if (Std.isOfType(folderOrImg, String))
		{
			var originalPath:String = folderOrImg;

			for (i in 0...10)
			{
				var st:String = '$i';

				if (i == 0)
                    st = '';

				if (!changedAtlasJson)
				{
					spriteJson = File.getContent(getPath('images/$originalPath/spritemap$st.json'));

					if (spriteJson != null)
					{
						changedImage = true;

						changedAtlasJson = true;

						folderOrImg = image('$originalPath/spritemap$st');
                        
						break;
					}
				} else if (fileExists('images/$originalPath/spritemap$st.png')) {
					changedImage = true;

					folderOrImg = image('$originalPath/spritemap$st');

					break;
				}
			}

			if (!changedImage)
			{
				changedImage = true;

				folderOrImg = image(originalPath);
			}

			if (!changedAnimJson)
			{
				changedAnimJson = true;

				animationJson = File.getContent(getPath('images/$originalPath/Animation.json'));
			}
		}

		spr.loadAtlasEx(folderOrImg, spriteJson, animationJson);
	}
	#end
}