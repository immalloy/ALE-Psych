# Configuring the Game

ALE Psych supports adding the file to the mod's root folder called `data.json`, which allows you to modify various aspects of the Engine.

If you do not add a variable, it will retain the default value indicated.

Over time, we will add more variables to make it easier to modify things. 

## Variables in `data.json`

1. **developerMode** `(Bool = false)`: Allows access to the Engine Editors, the use of variables that will be seen right after this one, and the easy reloading of scripts.
1. **mobileDebug** `(Bool = false)`: If enabled together with `developerMode`, it activates the variable `CoolVars.mobileControls`, which allows mobile controls to be tested even on desktop platforms. On mobile, this variable will always remain true.
1. **scriptsHotReloading** `(Bool = false)`: If enabled together with `developerMode`, it allows the engine to detect when the code of a menu is changed and automatically reloads the menu. This option is only available on desktop platforms and may increase computer resource consumption.

1. **initialState** `(String = "TitleState")`: Determines which menu will be displayed first in the game.
1. **freeplayState** `(String = "FreeplayState")`: Determines which menu the game will go to when a song ends and it is not in story mode.
1. **storyMenuState** `(String = "StoryMenuState")`: Determines which menu the game will go to when a song ends and it is in story mode.
1. **masterEditorMenu** `(String = "MasterEditorMenu")`: Determines which menu will open when attempting to access the editors from the Main Menu.
1. **mainMenuState** `(String = "MainMenuState")`: Useful for determining which main menu several of the other menus mentioned above will go to when exiting them.

1. **loadDefaultWeeks** `(Bool = true)`: Determines whether or not the base game weeks will be loaded into the Freeplay and Story Mode menus.

1. **pauseSubState** `(String = “PauseSubState”)`: Determines which submenu the game will go to if you try to pause while playing a song.
1. **gameOverScreen** `(String = “GameOverSubState”)`: Determines which submenu the game will go to when you lose during a song.
1. **transition** `(String = “FadeTransition”)`: Determines which submenu the game will go to when you try to change menus with `CoolUtil.switchState`.

1. **title** `(String = “Friday Night Funkin': ALE Psych”)`: Changes the title of the game window.
1. **icon** `(String = “appIcon”)`: Changes the image that will be displayed in the game window. The image will be searched for in the game's root folder and must be in PNG format.
1. **width** `(Int = 1280)`: Determines the width of the game window in pixels.
1. **height** `(Int = 720)`: Determines the height of the game window in pixels. 

1. **bpm** `(Float = 102.0)`: Determines the BPM at which most menus will run.

1. **discordID** `(String = “1309982575368077416”)`: Determines the Application ID that will be displayed in the “Playing” section of the Player's Discord profile.

## Example

`mods/modName/data.json`

```json
{
	"developerMode": false,
	"mobileDebug": false,
	"scriptsHotReloading": false,

	"initialState": "TitleState",
	"freeplayState": "FreeplayState",
	"storyMenuState": "StoryMenuState",
	"masterEditorMenu": "MasterEditorMenu",
	"mainMenuState": "MainMenuState",

	"loadDefaultWeeks": true,

	"pauseSubState": "PauseSubState",
	"gameOverScreen": "GameOverSubState",
	"transition": "FadeTransition",

	"title": "Friday Night Funkin': ALE Psych",
	"icon": "appIcon",

	"width": 1280,
	"height": 720,
    
	"bpm": 102,

	"discordID": "1309982575368077416"
}
```