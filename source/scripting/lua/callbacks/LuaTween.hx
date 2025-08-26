package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

class LuaTween extends LuaPresetBase
{
    override public function new(lua:LuaScript)
    {
        super(lua);
        
        set('tween', function(tag:String, obj:String, props:Dynamic, ?time:Float, ?options:Dynamic)
        {
            setTag(tag, complexTween(tag, getTag(obj), props, time, options));
        });
        
        set('doTweenX', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenX"');

            setTag(tag, complexTween(tag, getTag(obj), {x: value}, time, {ease: ease}));
        });
        
        set('doTweenY', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenY"');

            setTag(tag, complexTween(tag, getTag(obj), {y: value}, time, {ease: ease}));
        });
        
        set('doTweenAngle', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenAngle"');

            setTag(tag, complexTween(tag, getTag(obj), {angle: value}, time, {ease: ease}));
        });
        
        set('doTweenAlpha', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenAlpha"');

            setTag(tag, complexTween(tag, getTag(obj), {alpha: value}, time, {ease: ease}));
        });
        
        set('doTweenZoom', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenZoom"');

            setTag(tag, complexTween(tag, getTag(obj), {zoom: value}, time, {ease: ease}));
        });
        
        set('doTweenColor', function(tag:String, obj:String, value:Dynamic, ?time:Float, ?ease:String)
        {
			deprecatedPrint('Use "tween" instead of "doTweenColor"');

            setTag(tag, complexTween(tag, getTag(obj), {color: value}, time, {ease: ease}));
        });

        set('cancelTween', function(tag:String)
        {
            if (tagIs(tag, FlxTween))
                getTag(tag).cancel();
        });
    }

    public function complexTween(tag:String, obj:Dynamic, props:Any, time:Float, options:Any):FlxTween
    {
        var opt:TweenOptions = {
            type: tweenTypeByString(Reflect.field(options, 'type') ?? ''),
            startDelay: Reflect.field(options, 'startDelay'),
            onUpdate: (_) -> {
                lua.call('onTweenUpdate', [tag]);
            },
            onStart: (_) -> {
                lua.call('onTweenStart', [tag]);
            },
            onComplete: (_) -> {
                lua.call('onTweenComplete', [tag]);
            },
            loopDelay: Reflect.field(options, 'loopDelay'),
            ease: easeByString(Reflect.field(options, 'ease') ?? '')
        };

        return FlxTween.tween(obj, props, time, opt);
    }

	public function easeByString(?ease:String = '')
    {
		return switch(ease.toLowerCase().trim())
        {
			case 'backin':
				FlxEase.backIn;
			case 'backinout':
				FlxEase.backInOut;
			case 'backout':
				FlxEase.backOut;
			case 'bouncein':
				FlxEase.bounceIn;
			case 'bounceinout':
				FlxEase.bounceInOut;
			case 'bounceout':
				FlxEase.bounceOut;
			case 'circin':
				FlxEase.circIn;
			case 'circinout':
				FlxEase.circInOut;
			case 'circout':
				FlxEase.circOut;
			case 'cubein':
				FlxEase.cubeIn;
			case 'cubeinout':
				FlxEase.cubeInOut;
			case 'cubeout':
				FlxEase.cubeOut;
			case 'elasticin':
				FlxEase.elasticIn;
			case 'elasticinout':
				FlxEase.elasticInOut;
			case 'elasticout':
				FlxEase.elasticOut;
			case 'expoin':
				FlxEase.expoIn;
			case 'expoinout':
				FlxEase.expoInOut;
			case 'expoout':
				FlxEase.expoOut;
			case 'quadin':
				FlxEase.quadIn;
			case 'quadinout':
				FlxEase.quadInOut;
			case 'quadout':
				FlxEase.quadOut;
			case 'quartin':
				FlxEase.quartIn;
			case 'quartinout':
				FlxEase.quartInOut;
			case 'quartout':
				FlxEase.quartOut;
			case 'quintin':
				FlxEase.quintIn;
			case 'quintinout':
				FlxEase.quintInOut;
			case 'quintout':
				FlxEase.quintOut;
			case 'sinein':
				FlxEase.sineIn;
			case 'sineinout':
				FlxEase.sineInOut;
			case 'sineout':
				FlxEase.sineOut;
			case 'smoothstepin':
				FlxEase.smoothStepIn;
			case 'smoothstepinout':
				FlxEase.smoothStepInOut;
			case 'smoothstepout':
				FlxEase.smoothStepOut;
			case 'smootherstepin':
				FlxEase.smootherStepIn;
			case 'smootherstepinout':
				FlxEase.smootherStepInOut;
			case 'smootherstepout':
				FlxEase.smootherStepOut;
			default:
				FlxEase.linear;
		}
	}

	public function tweenTypeByString(?type:String = '')
	{
		return switch (type.toUpperCase().trim())
		{
			case 'BACKWARD':
				FlxTweenType.BACKWARD;
			case 'LOOPING':
				FlxTweenType.LOOPING;
			case 'ONESHOT':
				FlxTweenType.ONESHOT;
			case 'PERSIST':
				FlxTweenType.PERSIST;
			case 'PINGPONG':
				FlxTweenType.PINGPONG;
			default:
				null;
		}
	}
}