package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import Type;

using StringTools;

class LuaReflect extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);

        set("getProperty", function(variable:String, ?allowMaps:Bool = false)
            {
                var split:Array<String> = variable.split('.');

                if (split.length > 1)
                    return LuaPresetUtils.getVarInArray(lua, LuaPresetUtils.getPropertyLoop(lua, split, true, allowMaps), split[split.length-1], allowMaps);

                return LuaPresetUtils.getVarInArray(lua, type == STATE ? FlxG.state : FlxG.state.subState, variable, allowMaps);
            }
        );

        set('setProperties', (tag:String, properties:Dynamic) ->
        {
            var obj = LuaPresetUtils.parseVariable(lua, tag);

            if (obj != null)
                LuaPresetUtils.applyProps(obj, properties);
        });

        set('setPropertiesFromClass', function(classVar:String, variables:Dynamic)
        {
            var myClass:Dynamic = Type.resolveClass(classVar);

            if (myClass == null)
            {
                errorPrint('Class "' + classVar + '" not found');
        
                return null;
            }
        
            LuaPresetUtils.applyProps(myClass, variables);

            return variables;
        });

		set("setProperty", function(variable:String, value:Dynamic, allowMaps:Bool = false)
        {
			var split:Array<String> = variable.split('.');

			if (split.length > 1)
            {
				LuaPresetUtils.setVarInArray(lua, LuaPresetUtils.getPropertyLoop(lua, split, true, allowMaps), split[split.length-1], value, allowMaps);

				return true;
			}

            return false;
		});

        set('setPropertyFromClass', function(classVar:String, variable:String, value:Dynamic, ?allowMaps:Bool = false)
        {
			var myClass:Dynamic = Type.resolveClass(classVar);

			if (myClass == null)
			{
				errorPrint('Class $classVar not found');

				return null;
			}

			var split:Array<String> = variable.split('.');

			if (split.length > 1)
            {
				var obj:Dynamic = LuaPresetUtils.getVarInArray(lua, myClass, split[0], allowMaps);

				for (i in 1...(split.length - 1))
					obj = LuaPresetUtils.getVarInArray(lua, obj, split[i], allowMaps);

				LuaPresetUtils.setVarInArray(lua, obj, split[split.length - 1], value, allowMaps);

				return value;
			}
            
			LuaPresetUtils.setVarInArray(lua, myClass, variable, value, allowMaps);

			return value;
		});

        set("getPropertyFromClass", function(classVar:String, variable:String, ?allowMaps:Bool = false)
        {
            var myClass:Dynamic = Type.resolveClass(classVar);

            if (myClass == null)
            {
                errorPrint('getPropertyFromClass: Class $classVar not found');

                return null;
            }

            var split:Array<String> = variable.split('.');

            if (split.length > 1)
            {
                var obj:Dynamic = LuaPresetUtils.getVarInArray(lua, myClass, split[0], allowMaps);

                for (i in 1...(split.length-1))
                    obj = LuaPresetUtils.getVarInArray(lua, obj, split[i], allowMaps);

                return LuaPresetUtils.getVarInArray(lua, obj, split[split.length-1], allowMaps);
            }

            return LuaPresetUtils.getVarInArray(lua, myClass, variable, allowMaps);
        });

        set("getPropertyFromGroup", function(obj:String, index:Int, variable:Dynamic, ?allowMaps:Bool = false)
        {
            var split:Array<String> = obj.split('.');

            var realObject:Dynamic = null;

            if (split.length > 1)
                realObject = LuaPresetUtils.getPropertyLoop(lua, split, false, allowMaps);
            else
                realObject = Reflect.getProperty(type == STATE ? FlxG.state : FlxG.state.subState, obj);

            if (Std.isOfType(realObject, FlxTypedGroup))
            {
                var result:Dynamic = LuaPresetUtils.getGroupStuff(realObject.members[index], variable, allowMaps);
                
                return result;
            }

            var leArray:Dynamic = realObject[index];

            if (leArray != null)
            {
                var result:Dynamic = null;

                if (Type.typeof(variable) == ValueType.TInt)
                    result = leArray[variable];
                else
                    result = LuaPresetUtils.getGroupStuff(leArray, variable, allowMaps);

                return result;
            }
            
            errorPrint("getPropertyFromGroup: Object #" + index + " from group: " + obj + " doesn't exist!");

            return null;
        });

        set("setPropertyFromGroup", function(obj:String, index:Int, variable:Dynamic, value:Dynamic, ?allowMaps:Bool = false)
        {
            var split:Array<String> = obj.split('.');

            var realObject:Dynamic = null;

            if (split.length > 1)
                realObject = LuaPresetUtils.getPropertyLoop(lua, split, false, allowMaps);
            else
                realObject = Reflect.getProperty(type == STATE ? FlxG.state : FlxG.state.subState, obj);

            if (Std.isOfType(realObject, FlxTypedGroup))
            {
                LuaPresetUtils.setGroupStuff(realObject.members[index], variable, value, allowMaps);

                return value;
            }

            var leArray:Dynamic = realObject[index];

            if (leArray != null)
            {
                if (Type.typeof(variable) == ValueType.TInt)
                {
                    leArray[variable] = value;

                    return value;
                }

                LuaPresetUtils.setGroupStuff(leArray, variable, value, allowMaps);
            }

            return value;
        });

        set("removeFromGroup", function(obj:String, index:Int, dontDestroy:Bool = false)
        {
            var groupOrArray:Dynamic = Reflect.getProperty(type == STATE ? FlxG.state : FlxG.state.subState, obj);

            if (Std.isOfType(groupOrArray, FlxTypedGroup))
            {
                var obj:Dynamic = groupOrArray.members[index];

                if (!dontDestroy)
                    obj.kill();

                groupOrArray.remove(obj, true);

                if (!dontDestroy)
                    obj.destroy();

                return;
            }

            groupOrArray.remove(groupOrArray[index]);
        });
            
        set("callMethod", function(funcToRun:String, ?args:Array<Dynamic> = null)
        {
            return LuaPresetUtils.callMethodFromObject(lua, FlxG.state, funcToRun, LuaPresetUtils.parseInstances(lua, args));
        });

        set("callMethodFromClass", function(className:String, funcToRun:String, ?args:Array<Dynamic> = null)
        {
            return LuaPresetUtils.callMethodFromObject(lua, Type.resolveClass(className), funcToRun, LuaPresetUtils.parseInstances(lua, args));
        });
    
        set("createInstance", function(variableToSave:String, className:String, ?args:Array<Dynamic> = null)
        {
            variableToSave = variableToSave.trim().replace('.', '');

            if (!variables.exists(variableToSave))
            {
                if (args == null)
                    args = [];

                var myType:Dynamic = Type.resolveClass(className);
        
                if (myType == null)
                {
                    errorPrint('createInstance: Variable $variableToSave is already being used and cannot be replaced!');

                    return false;
                }

                var obj:Dynamic = Type.createInstance(myType, args);

                if (obj != null)
                    variables.set(variableToSave, obj);
                else
                    errorPrint('createInstance: Failed to create $variableToSave, arguments are possibly wrong.');

                return (obj != null);
            } else {
                errorPrint('createInstance: Variable $variableToSave is already being used and cannot be replaced!');
            }

            return false;
        });

        set('addInstance', function(tag:String)
        {
            deprecatedPrint('Use "add" instead of "addInstance"');

            if (tagIs(tag, flixel.FlxBasic))
                if (type == STATE)
                    FlxG.state.add(getTag(tag));
                else
                    FlxG.state.subState.add(getTag(tag));
        });

        set("instanceArg", function(instanceName:String, ?className:String = null)
        {
            var retStr:String = '${LuaPresetUtils.instanceStr}::$instanceName';

            if (className != null)
                retStr += '::$className';

            return retStr;
        });
    }
}