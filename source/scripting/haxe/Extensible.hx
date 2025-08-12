package scripting.haxe;

import rulescript.scriptedClass.RuleScriptedClass;

import flixel.*;
import flixel.ui.*;
import flixel.math.*;
import flixel.group.*;
import flixel.graphics.*;
import flixel.addons.ui.*;
import flixel.addons.display.*;

import scripting.lua.LuaPresetBase;

class Extensible {}

class ScriptObject extends FlxObject implements RuleScriptedClass {}

class ScriptSprite extends FlxSprite implements RuleScriptedClass {}

class ScriptText extends FlxText implements RuleScriptedClass {}

class ScriptGroup extends FlxGroup implements RuleScriptedClass {}

class ScriptTimer extends FlxTimer implements RuleScriptedClass {}

class ScriptSound extends FlxSound implements RuleScriptedClass {}

class ScriptRect extends FlxRect implements RuleScriptedClass {}

class ScriptButton extends FlxButton implements RuleScriptedClass {}

class ScriptBar extends FlxBar implements RuleScriptedClass {}

class ScriptGraphic extends FlxGraphic implements RuleScriptedClass {}

class ScriptBasic extends FlxBasic implements RuleScriptedClass {}

class ScriptLuaPresetBase extends LuaPresetBase implements RuleScriptedClass {}