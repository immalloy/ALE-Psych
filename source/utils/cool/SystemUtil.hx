package utils.cool;

import sys.thread.Thread;

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
}