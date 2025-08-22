package utils;

import haxe.ds.StringMap;

class Score
{
	public static var song:StringMap<Float> = new StringMap<Float>();
	public static var rating:StringMap<Float> = new StringMap<Float>();
	public static var week:StringMap<Float> = new StringMap<Float>();
	public static var completed:StringMap<Bool> = new StringMap<Bool>();	
}