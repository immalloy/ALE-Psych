package core.macros;

import haxe.macro.Context;
import haxe.macro.Expr;

class CoolMacro
{
    public static macro function build():Array<Field>
    {
        var fields = Context.getBuildFields();

        var utils:Array<String> = [
            'utils.cool.ColorUtil',
            'utils.cool.EngineUtil',
            'utils.cool.FileUtil',
            'utils.cool.LogUtil',
            'utils.cool.MathUtil',
            'utils.cool.PlayStateUtil',
            'utils.cool.ShaderUtil',
            'utils.cool.StateUtil',
            'utils.cool.StringUtil',
            'utils.cool.SystemUtil'
        ];

        for (cls in utils)
        {
            var t = Context.getType(cls);

            switch (t)
            {
                case TInst(c, _):
                    for (func in c.get().statics.get())
                    {
                        if (func.type.match(TFun(_)) && func.isPublic && !func.isExtern)
                        {
                            fields.push(
                                {
                                    pos: Context.currentPos(),
                                    name: func.name,
                                    access: [APublic, AStatic],
                                    kind: FFun(
                                        {
                                            args: [],
                                            ret: null,
                                            expr: null
                                        }
                                    )
                                }
                            );
                        }
                    }
                default:
            }
        }

        return fields;
    }
}