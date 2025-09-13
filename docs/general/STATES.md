# Creating and Modifying Menus/States

One of the main features of ALE Psych since its inception was to provide the ability to create and modify menus without using source code. There are different ways to do this, depending on which language you prefer to use or what you want to do.

## HScript

### Creating a Menu

Creating a menu is as simple as adding a script in `scripts/states/`.

Example: `mods/modName/scripts/states/MyMenu.hx`

### Modifying a Menu

To modify one of the default menus in the game, simply go to `assets/scripts/states`, copy the script for the menu you want to modify (which you can see from the FPS counter if you don't know which one it is), paste it into `mods/modName/scripts/states`, and modify it as you wish.


### Accessing a Menu

Use the `CoolUtil.switchState` function as follows: `CoolUtil.switchState(new CustomState('ScriptName'))`

## Lua

### Creating a Menu

Creating a menu is as simple as adding a script in `scripts/states/`.

Example: `mods/modName/scripts/states/MyMenu.lua`

### Modifying a Menu

This feature is not available in Lua, as the Base Game Menus are written in HScript.

### Accessing a Menu

Use the `switchState` function as follows: `switchState('funkin.states.CustomState', {'ScriptName'})`