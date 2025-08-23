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
		var id:String = CoolUtil.formatToSongPath(name.trim() + '-' + difficulty.trim());

		if (score > (Score.song.get(id) ?? 0))
			Score.song.set(id, score);

		if (rating > (Score.rating.get(id) ?? 0))
			Score.rating.set(id, rating);

		CoolUtil.save.saveScore();
	}

	public static function saveWeek(name:String, difficulty:String, score:Float):Void
	{
		var id:String = CoolUtil.formatToSongPath(name.trim() + '-' + difficulty.trim());

		if (score > (Score.week.get(id) ?? 0))
			Score.week.set(id, score);

		Score.completed.set(CoolUtil.formatToSongPath(name), true);

		CoolUtil.save.saveScore();
	}
}