# Creating and Modifying Submenus/Substates

One of the main features of ALE Psych since its inception was to provide the ability to create and modify submenus without using source code. There are different ways to do this, depending on which language you prefer to use or what you want to do.

## HScript

### Creating a SubMenu

Creating a submenu is as simple as adding a script in `scripts/substates/`.

Example: `mods/modName/scripts/substates/MySubMenu.hx`

### Modifying a SubMenu

To modify one of the default submenus in the game, simply go to `assets/scripts/substates`, copy the script for the submenu you want to modify (which you can see from the FPS counter if you don't know which one it is), paste it into `mods/modName/scripts/substates`, and modify it as you wish.


### Accessing a SubMenu

Use the `CoolUtil.openSubState` function as follows: `CoolUtil.openSubState(new CustomSubState('ScriptName'))`

## Lua

### Creating a SubMenu

Creating a submenu is as simple as adding a script in `scripts/substates/`.

Example: `mods/modName/scripts/substates/MySubMenu.lua`

### Modifying a SubMenu

This feature is not available in Lua, as the Base Game SubMenus are written in HScript.

### Accessing a SubMenu

Use the `openSubState` function as follows: `openSubState('funkin.substates.CustomSubState', {'ScriptName'})`