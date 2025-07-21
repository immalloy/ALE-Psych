package core.config;

import utils.Highscore;

import haxe.io.Path;

import hscript.Expr.ModuleDecl;
import hscript.Printer;

import rulescript.RuleScript;
import rulescript.Tools;
import rulescript.parsers.HxParser;

import scripting.haxe.ALERuleScript;

import rulescript.scriptedClass.RuleScriptedClassUtil;

class MainState extends MusicBeatState
{
	override function create()
	{
		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		super.create();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

		ClientPrefs.loadPrefs();

		Highscore.load();

		FlxG.mouse.useSystemCursor = true;

		RuleScriptedClassUtil.buildBridge = customBuildRuleScript;

		RuleScript.resolveScript = importCustomClass;

		CoolUtil.reloadGameMetadata();

        FlxG.autoPause = !CoolVars.data.developerMode || !CoolVars.data.scriptsHotReloading;

		CoolUtil.switchState(new CustomState(CoolVars.data.initialState));
		
		openalFix();
	}

    function openalFix()
    {
		#if desktop
		var origin:String = #if hl Sys.getCwd() #else Sys.programPath() #end;

		var configPath:String = Path.directory(Path.withoutExtension(origin));

		#if windows
		configPath += "/plugins/alsoft.ini";
		#elseif mac
		configPath = Path.directory(configPath) + "/Resources/plugins/alsoft.conf";
		#else
		configPath += "/plugins/alsoft.conf";
		#end

		Sys.putEnv("ALSOFT_CONF", configPath);
		#end	
    }

	static function importCustomClass(name:String):Dynamic
	{
		var path:String = 'scripts/classes/' + name.replace('.', '/') + '.hx';

		if (!Paths.fileExists(path))
			return null;

		var parser = new HxParser();
		parser.allowAll();
		parser.mode = MODULE;

		var module:Array<ModuleDecl> = parser.parseModule(File.getContent(Paths.getPath(path)));

		var newModule:Array<ModuleDecl> = [];

		var extend:String = null;

		for (decl in module)
		{
			switch (decl)
			{
				case DPackage(_), DUsing(_), DImport(_):
					newModule.push(decl);
				case DClass(c):
					if (name.split('.').pop() == c.name)
					{
						newModule.push(decl);

						if (c.extend != null)
							extend = new Printer().typeToString(c.extend);
					}
				default:
			}
		}

		var obj:Dynamic = null;

		if (extend == null)
		{
			var script = new ALERuleScript();

			script.execute(Tools.moduleDeclsToExpr(newModule));

			obj = {};

			for (key => value in script.variables)
				Reflect.setField(obj, key, value);
		} else {
			var cl = Type.resolveClass(extend);

			var f = function(args:Array<Dynamic>)
			{
				return Type.createInstance(cl, [name, args]);
			}

			obj = Reflect.makeVarArgs(f);
		}

		return obj;
	}

	static function customBuildRuleScript(typeName:String, superInstance:Dynamic):RuleScript
	{
		var script = new ALERuleScript();

		script.getParser(HxParser).mode = MODULE;

		script.superInstance = superInstance;

		script.interp.skipNextRestore = true;

		script.execute(File.getContent(Paths.getPath('scripts/classes/' + typeName.replace('.', '/') + '.hx')));

		return script;
	}
}