# Modifying Options

ALE Psych allows you to add custom options to the Engine, similar to when you want to configure the game, using a file, in this case called `options.json`.

This file is not as simple as `data.json`, so each step will be accompanied by one or more examples.

## Getting Started

The first thing to do is add the `categories` variable, which, as its name suggests, will contain the new categories.

```json
{
    "categories": []
}
```

## Creating a Category

There are three types of categories:

### Normal

```json
{
    "name": "My Category",
    "options": []
}
```

### Access a State

```json
{
    "name": "My State",
    "stateData": {   
        "state": "funkin.states.OptionsState",
        "script": false
    }
}
```

### Open a Substate

```json
{
    "name": "My SubState",
    "stateData": {
        "subState": "funkin.substates.ControlsSubState",
        "script": false
    }
}
```

### Variables

1. **name**: Defines the name of the category.
1. **stateData**: Contains the state/substate data that the category will use.
1. **state**: Defines the state that the category will target.
1. **subState**: Defines the substate that the category will open.

## Creating an Option

Remember how the normal category type has an array called `options`? Well, here I will explain how each of the option types are displayed.

### Bool

```json
{
    "name": "My Bool",
    "description": "Bool type option",
    "variable": "boolOption",
    "type": "bool",
    "initialValue": false
}
```

### Float

```json
{
    "name": "My Float",
    "description": "Float type option",
    "variable": "floatOption",
    "type": "float",
    "initialValue": 0,
    "min": 0,
    "max": 1,
    "change": 0.1,
    "decimals": 2
}
```

### Integer

```json
{
    "name": "My Integer",
    "description": "Integer type option",
    "variable": "integerOption",
    "type": "integer",
    "initialValue": 0,
    "min": 0,
    "max": 10,
    "change": 2
}
```

### String

```json
{
    "name": "My String",
    "description": "String type option",
    "variable": "stringOption",
    "type": "string",
    "initialValue": "Option 0",
    "strings": [
        "Option 0",
        "Option 1",
        "Option 2"
    ]
}
```

### Variables

1. **name**: Defines the name of the option.
1. **description**: Defines the description of the option.
1. **variable**: Defines the variable that will be used in `ClientPrefs.custom`.
1. **type**: Defines the type of the option. It can be “bool,” “float,” “integer,” or “string.”
1. **initialValue**: Defines the default value of the variable and the option.
1. **min**: (Only for “float” and “integer”) Defines the lowest number that can be selected.
1. **max**: (Only for “float” and “integer”) Defines the highest number that can be selected.
1. **change**: (Only for “float” and “integer”) Defines how many numbers the option will advance or backward when changed.
1. **decimals**: (Only for “float”) Defines the maximum number of decimal places its value will have.
1. **strings**: (Only for “string”) Defines the options that can be chosen.

## Example

```json
{
	"categories": [
		{
			"stateData": {
				"subState": "funkin.substates.ControlsSubState",
				"script": false
			},
			"name": "Controls"
		},
		{
			"stateData": {
				"state": "game.states.NoteOffsetState",
				"script": false
			},
			"name": "Delay and Combo"
		},
		{
			"options": [
				{
					"variable": "lowQuality",
					"description": "If checked, disables some background details, decreases loading times and improves performance.",
					"initialValue": false,
					"type": "bool",
					"name": "Low Quality"
				},
				{
					"variable": "antialiasing",
					"description": "If unchecked, disables anti-aliasing, increases performance at the cost of sharper visuals.",
					"initialValue": true,
					"type": "bool",
					"name": "Anti-Aliasing"
				},
				{
					"variable": "shaders",
					"description": "If unchecked, disables shaders. It's used for some visual effects, and also CPU intensive for weaker PCs.",
					"initialValue": true,
					"type": "bool",
					"name": "Shaders"
				},
				{
					"variable": "cacheOnGPU",
					"description": "If checked, allows the GPU to be used for caching textures, decreasing RAM usage. Don't turn this on if you have a shitty Graphics Card.",
					"initialValue": true,
					"type": "bool",
					"name": "GPU Caching"
				},
				{
					"change": 1,
					"max": 240,
					"variable": "framerate",
					"description": "Pretty self explanatory, isn't it?",
					"initialValue": 60,
					"min": 30,
					"type": "integer",
					"name": "Framerate"
				}
			],
			"name": "Graphics"
		},
		{
			"options": [
				{
					"change": 1,
					"max": 100,
					"variable": "splashAlpha",
					"description": "How much transparent should the Note Splashes be.",
					"initialValue": 60,
					"min": 0,
					"type": "integer",
					"name": "Note Splash Opacity"
				},
				{
					"variable": "flashing",
					"description": "Uncheck this if you're sensitive to flashing lights!",
					"initialValue": true,
					"type": "bool",
					"name": "Flashing Lights"
				},
				{
					"variable": "pauseMusic",
					"description": "",
					"initialValue": "Tea Time",
					"strings": [
						"None",
						"Breakfast",
						"Tea Time"
					],
					"type": "string",
					"name": "Pause Music"
				},
				{
					"variable": "checkForUpdates",
					"description": "Turn this on to check for updates when you start the game.",
					"initialValue": true,
					"type": "bool",
					"name": "Check for Updates"
				},
				{
					"variable": "discordRPC",
					"description": "Uncheck this to prevent accidental leaks, it will hide the Application from your \"Playing\" box on Discord.",
					"initialValue": true,
					"type": "bool",
					"name": "Discord Rich Presence"
				}
			],
			"name": "Visuals and UI"
		},
		{
			"options": [
				{
					"variable": "downScroll",
					"description": "If checked, notes go Down instead of Up, simple enough.",
					"initialValue": false,
					"type": "bool",
					"name": "Downscroll"
				},
				{
					"variable": "ghostTapping",
					"description": "If checked, you won't get misses from pressing keys while there are no notes able to hit.",
					"initialValue": true,
					"type": "bool",
					"name": "Ghost Tapping"
				},
				{
					"variable": "noReset",
					"description": "If checked, pressing Reset won't do anything.",
					"initialValue": false,
					"type": "bool",
					"name": "Disable Reset Button"
				}
			],
			"name": "Gameplay"
		}
	]
}
```