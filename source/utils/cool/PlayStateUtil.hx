package utils.cool;

class PlayStateUtil
{
	public static function loadPlayStateJSON(songJson:Dynamic):SwagSong
	{
		var json = songJson;

		if (json.gfVersion == null)
		{
			json.gfVersion = json.player3;

			json.player3 = null;
		}

		if (json.events == null)
		{
			json.events = [];
			
			for (secNum in 0...json.notes.length)
			{
				var sec:SwagSection = json.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;

				while (i < len)
				{
					var note:Array<Dynamic> = notes[i];

					if (note[1] < 0)
					{
						json.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}

					else i++;
				}
			}
		}

		return cast json;
	}

	public static function loadPlayStateSong(name:String, difficulty:String, setSongRoute:Bool = true):PlayStateJSONData
	{
		var jsonData:SwagSong = null;

		var route:String = null;

		var found = false;

		for (parentFolder in [Paths.modFolder(), 'assets'])
		{
			if (found)
				break;

			if (FileSystem.exists(parentFolder + '/songs') && FileSystem.isDirectory(parentFolder + '/songs'))
			{
				for (folder in FileSystem.readDirectory(parentFolder + '/songs'))
				{
					if (formatToSongPath(name) == formatToSongPath(folder))
					{
						var chartPath = parentFolder + '/songs/' + folder + '/charts/' + difficulty + '.json';
						
						if (FileSystem.exists(chartPath))
						{
							jsonData = Json.parse(sys.io.File.getContent(chartPath)).song;

							route = folder;

							found = true;

							break;
						}
					}
				}
			}
		}

		if (jsonData == null)
			debugTrace(name + '/charts/' + difficulty + '.json', MISSING_FILE);
		else
			jsonData = loadPlayStateJSON(jsonData);

		return {
			route: route,
			json: jsonData
		};
	}

	public static function loadSong(name:String, difficulty:String, goToPlayState:Bool = true)
	{
		var data:PlayStateJSONData = loadPlayStateSong(name, difficulty);

		PlayState.SONG = data.json;
		PlayState.difficulty = difficulty;
		PlayState.songRoute = 'songs/' + data.route;

		if (goToPlayState && PlayState.SONG != null)
			switchState(new PlayState());
	}

	public static function loadWeek(weekName:String, names:Array<String>, difficulty:String, goToPlayState:Bool = true)
	{
		PlayState.playlist = names;
		PlayState.week = weekName;

		if (goToPlayState)
			loadSong(PlayState.playlist[0], difficulty);
	}
}