package utils.cool;

class SystemUtil
{
	public static function createSafeThread(func:Void -> Void):Thread
	{
		return Thread.create(function()
		{
			try {
				func();
			} catch(e) {
				debugTrace(e.details(), ERROR);
			}
		});
	}

	inline public static function browserLoad(site:String)
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	@:access(flixel.util.FlxSave.validate)
	public static function getSavePath(modSupport:Bool = true):String
	{
		final company:String = FlxG.stage.application.meta.get('company');
		
		return company + '/' + flixel.util.FlxSave.validate(FlxG.stage.application.meta.get('file')) + (modSupport ? ((Mods.folder.trim() == '' ? '' : '/' + Mods.folder)) : '');
	}
}