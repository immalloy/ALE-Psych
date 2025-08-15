#if LUA_ALLOWED
package scripting.lua;

import llua.Lua;

class CallbackHandler
{
	public static function call(l:State, fname:String):Int
	{
		try
		{
			var cbf:Dynamic = LuaScript.lastCalledScript.callbacks.get(fname);
			
			if (cbf == null)
				return 0;

			var nparams:Int = Lua.gettop(l);

			var args:Array<Dynamic> = [];

			for (i in 0...nparams)
				args[i] = Convert.fromLua(l, i + 1);

			var ret:Dynamic = null;

			ret = Reflect.callMethod(null,cbf,args);

			if (ret != null)
			{
				Convert.toLua(l, ret);

				return 1;
			}
		} catch (e:Dynamic) {
			throw e;
		}

		return 0;
	}
}
#end