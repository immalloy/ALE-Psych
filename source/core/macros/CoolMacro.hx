package core.macros;

// Author: Kriptel

import haxe.macro.Context;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.Field;
import haxe.macro.Type;

class CoolMacro
{
	public static function build(utils:Array<String>):Array<Field>
	{
        final list:Array<Type> = utils.map(t -> Context.getType(t));

		var fields:Array<Field> = Context.getBuildFields();
		
		for (index => t in list)
		{
			switch (t)
			{
				case TInst(type, params):
					final type = type.get();

					for (field in type.statics.get())
						fields.push(toField(field));

				default:
			}
		}

		return fields;
	}

	static function varAccessToString(va:VarAccess, getOrSet:String):String
	{
		return switch (va)
		{
			case AccNormal | AccCtor: "default";
			case AccNo: "null";
			case AccNever: "never";
			case AccResolve: throw null;
			case AccCall: getOrSet;
			case AccInline: "default";
			case AccRequire(_, _): "default";
		}
	}

	static function toField(cf:ClassField):Field
	{
		return
		{
			var access:Array<Access> = [APublic, AStatic];
			if (cf.meta.has(":final"))
			{
				access.push(AFinal);
			}
			if (cf.params.length == 0)
				{
					name: cf.name,
					doc: cf.doc,
					access: access,
					kind: switch ([cf.kind, cf.type])
					{
						case [FVar(read, write), ret]:
							FProp(varAccessToString(read, "get"), varAccessToString(write, "set"), Context.toComplexType(ret), null);
						case [FMethod(_), TFun(args, ret)]:
							FFun({
								args: [
									for (a in args)
										{
											name: a.name,
											opt: a.opt,
											type: Context.toComplexType(a.t),
										}
								],
								ret: Context.toComplexType(ret),
								expr: null,
							});
						case [FMethod(_), TLazy(t)]:
							switch (t())
							{
								case TFun(args, ret):
									FFun({
										args: [
											for (a in args)
												{
													name: a.name,
													opt: a.opt,
													type: Context.toComplexType(a.t),
												}
										],
										ret: Context.toComplexType(ret),
										expr: null,
									});
								default:
									null;
							}

						default:
							throw([cf.kind, cf.type] : Array<Dynamic>);
					},
					pos: cf.pos,
					meta: cf.meta.get(),
				}
			else
			{
				throw null;
			}
		}
	}
}