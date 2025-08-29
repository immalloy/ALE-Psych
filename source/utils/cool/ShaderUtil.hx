package utils.cool;

import funkin.visuals.shaders.ALERuntimeShader;

import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;

class ShaderUtil
{
	public static function createRuntimeShader(shaderName:String):ALERuntimeShader
	{
		if (!ClientPrefs.data.shaders)
			return new ALERuntimeShader(shaderName, '
				#pragma header

				void main(void)
				{
					gl_FragColor = texture2D(bitmap, openfl_TextureCoordv.xy);
				}
			');

		var frag:String = 'shaders/' + shaderName + '.frag';
		var vert:String = 'shaders/' + shaderName + '.vert';

		var found:Bool = false;

		if (Paths.fileExists(frag))
		{
			frag = File.getContent(Paths.getPath(frag));

			found = true;
		} else {
			frag = null;
		}

		if (Paths.fileExists(vert))
		{
			vert = File.getContent(Paths.getPath(vert));

			found = true;
		} else {
			vert = null;
		}

		if (found)
		{
			return new ALERuntimeShader(shaderName, frag, vert);
		} else {
			debugTrace('Missing Shader: ' + shaderName, MISSING_FILE);

			return null;
		}
	}

	public static function setCameraShaders(camera:FlxCamera, shaders:Array<ALERuntimeShader>):Void
	{
		var filterArray:Array<BitmapFilter> = [];

		for (shader in shaders)
			filterArray.push(new ShaderFilter(shader));

		camera.filters = filterArray;
	}
}