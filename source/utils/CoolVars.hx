package utils;

import openfl.Lib;

import core.structures.DataJson;

class CoolVars
{
	public static var data:DataJson = {
		developerMode: false,
		scriptsHotReloading: false,

		initialState: 'TitleState',
		freeplayState: 'FreeplayState',
		storyMenuState: 'StoryMenuState',
		masterEditorMenu: 'MasterEditorMenu',
		mainMenuState: 'MainMenuState',

		pauseSubState: 'PauseSubState',
		gameOverScreen: 'GameOverSubState',
		transition: 'FadeTransition',

		title: 'Friday Night Funkin\': ALE Engine',
		icon: 'appIcon',

		bpm: 102.0,

		discordID: '1309982575368077416',
	};

    public static var skipTransIn:Bool = false;
    public static var skipTransOut:Bool = false;
	
	public static var engineVersion(get, never):String;
	public static function get_engineVersion():String
		return Lib.application?.meta?.get('version') ?? '';

	@:allow(funkin.states.PlayState)
	private static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	public static var globalVars:Map<String, Dynamic> = new Map<String, Dynamic>();
}