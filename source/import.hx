#if !macro

import core.config.DiscordRPC;

#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import core.backend.Controls;
import core.backend.MusicBeatState;
import core.backend.MusicBeatSubState;
import core.backend.ScriptState;
import core.backend.ScriptSubState;
import core.backend.Conductor;
import core.backend.Mods;

import funkin.states.CustomState;
import funkin.substates.CustomSubState;

import core.config.ClientPrefs;

import funkin.visuals.stages.BaseStage;

import utils.CoolUtil;
import utils.CoolVars;
import utils.Paths;
import utils.ALEJson as Json;

import utils.cool.LogUtil.debugTrace;

import funkin.visuals.objects.Alphabet;
import funkin.visuals.stages.BGSprite;

import funkin.states.PlayState;

#if flxanimate
import flxanimate.*;
#end

import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;
#end
