package utils;

import haxe.ds.StringMap;

class Score
{
	public static var song:StringMap<Float> = new StringMap<Float>();
	public static var rating:StringMap<Float> = new StringMap<Float>();
	public static var week:StringMap<Float> = new StringMap<Float>();
	public static var completed:StringMap<Bool> = new StringMap<Bool>();	

	public static function saveSong(name:String, difficulty:String, score:Float, rating:Float):Void
	{
		var id:String = name.trim().toLowerCase() + '-' + difficulty.trim().toLowerCase();

		Score.song.set(id, score);

		Score.rating.set(id, rating);

		CoolUtil.save.saveScore();
	}

	public static function saveWeek(name:String, difficulty:String, score:Float):Void
	{
		Score.week.set(name.trim().toLowerCase() + '-' + difficulty.trim().toLowerCase(), score);

		Score.completed.set(name.trim().toLowerCase(), true);

		CoolUtil.save.saveScore();
	}
}