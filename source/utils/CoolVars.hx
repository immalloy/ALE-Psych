package utils;

import openfl.Lib;

import core.structures.DataJson;

class CoolVars
{
	public static var data:DataJson = null;

    public static var skipTransIn:Bool = false;
    public static var skipTransOut:Bool = false;
	
	public static var engineVersion(get, never):String;
	public static function get_engineVersion():String
		return Lib.application?.meta?.get('version') ?? '';

	public static var globalVars:Map<String, Dynamic> = new Map<String, Dynamic>();
}