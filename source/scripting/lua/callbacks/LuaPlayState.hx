package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import funkin.visuals.cutscenes.DialogueBoxPsych;

class LuaPlayState extends LuaPresetBase
{
    public var game:PlayState = PlayState.instance;

    override public function new(lua:LuaScript)
    {
        super(lua);
        
		set('inChartEditor', false);
        
		set('curBpm', Conductor.bpm);
		set('bpm', PlayState.SONG.bpm);
		set('scrollSpeed', PlayState.SONG.speed);
		set('crochet', Conductor.crochet);
		set('stepCrochet', Conductor.stepCrochet);
		set('songLength', FlxG.sound.music.length);
		set('songName', PlayState.SONG.song);
        
		set('songPath', PlayState.songRoute);

		set('startedCountdown', false);
		set('curStage', PlayState.SONG.stage);

		set('isStoryMode', PlayState.isStoryMode);
		set('difficulty', PlayState.difficulty);
		set('week', PlayState.week);
		set('seenCutscene', PlayState.seenCutscene);
		set('hasVocals', PlayState.SONG.needsVoices);
        
		set('cameraX', 0);
		set('cameraY', 0);

		set('score', 0);
		set('misses', 0);
		set('hits', 0);
		set('combo', 0);

		set('rating', 0);
		set('ratingName', '');
		set('ratingFC', '');

		set('inGameOver', false);
		set('mustHitSection', false);
		set('altAnim', false);
		set('gfSection', false);
        
		set('healthGainMult', game.healthGain);
		set('healthLossMult', game.healthLoss);

		#if FLX_PITCH
		set('playbackRate', game.playbackRate);
		#else
		set('playbackRate', 1);
		#end

		set('guitarHeroSustains', game.guitarHeroSustains);
		set('botPlay', game.cpuControlled);
		set('practice', game.practiceMode);

		for (i in 0...4)
		{
			set('defaultPlayerStrumX' + i, 0);
			set('defaultPlayerStrumY' + i, 0);
			set('defaultOpponentStrumX' + i, 0);
			set('defaultOpponentStrumY' + i, 0);
		}
		
		set('defaultBoyfriendX', game.BF_X);
		set('defaultBoyfriendY', game.BF_Y);
		set('defaultOpponentX', game.DAD_X);
		set('defaultOpponentY', game.DAD_Y);
		set('defaultGirlfriendX', game.GF_X);
		set('defaultGirlfriendY', game.GF_Y);
		
		set('boyfriendName', PlayState.SONG.player1);
		set('dadName', PlayState.SONG.player2);
		set('gfName', PlayState.SONG.gfVersion);
		
		set('splashAlpha', ClientPrefs.data.splashAlpha);
		
		set('buildTarget', CoolUtil.getBuildTarget());

        set('startCountdown', game.startCountdown);

        set('endSong', function ()
        {
            game.KillNotes();

            game.endSong();
        });

        set('restartSong', function ()
        {
            game.paused = true;
            game.vocals.volume = 0;

            game.shouldClearMemory = false;

            FlxG.sound.music.volume = 0;
            
            CoolUtil.resetState();
        });

        set('exitSong', function ()
        {
            game.vocals.volume = 0;

            PlayState.deathCounter = 0;
            PlayState.seenCutscene = false;

            PlayState.changedDifficulty = false;
            PlayState.chartingMode = false;
            
            game.paused = true;

            FlxG.sound.playMusic(Paths.music('freakyMenu'));

            CoolUtil.switchState(new CustomState(PlayState.isStoryMode ? CoolVars.data.storyMenuState : CoolVars.data.freeplayState));
        });

        set('cameraSetTarget', function (target:String)
        {
			switch(target.trim().toLowerCase())
			{
				case 'gf', 'girlfriend':
					game.moveCameraToGirlfriend();
				case 'dad', 'opponent':
					game.moveCamera(true);
				default:
					game.moveCamera(false);
			}
        });

        set('triggerEvent', function (name:String, arg1:Dynamic, arg2:Dynamic)
        {
			game.triggerEvent(name, arg1, arg2, Conductor.songPosition);
        });

        set('characterDance', function (character:String)
        {
			switch (character.toLowerCase())
            {
				case 'dad':
                    game.dad.dance();
				case 'gf' | 'girlfriend':
                    if (game.gf != null)
                        game.gf.dance();
				default:
                    game.boyfriend.dance();
			}
        });
        
        set('startDialogue', function (dialogueFile:String, music:String = null)
        {
            var path:String = CoolUtil.searchComplexFile(PlayState.songRoute + '/' + dialogueFile);

			if (FileSystem.exists(path))
			{
				var shit:DialogueFile = DialogueBoxPsych.parseDialogue(path);

				if (shit.dialogue.length > 0)
					game.startDialogue(shit, music);
			}
        });

        set('noteTween', function (tag:String, note:Int, props:Dynamic, ?time:Float, ?options:Dynamic)
        {
            setTag(tag, complexTween(tag, note, props, time, options));
        });

        set('noteTweenX', function (tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenX"');

            setTag(tag, complexTween(tag, note, {x: value}, duration, {ease: ease}));
        });

        set('noteTweenY', function (tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenY"');

            setTag(tag, complexTween(tag, note, {y: value}, duration, {ease: ease}));
        });

        set('noteTweenAngle', function (tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenAngle"');

            setTag(tag, complexTween(tag, note, {angle: value}, duration, {ease: ease}));
        });

        set('noteTweenDirection', function (tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenDirection"');

            setTag(tag, complexTween(tag, note, {direction: value}, duration, {ease: ease}));
        });

        set('noteTweenAlpha', function (tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenAlpha"');

            setTag(tag, complexTween(tag, note, {alpha: value}, duration, {ease: ease}));
        });
    }

    public function complexTween(tag:String, note:Int, props:Any, time:Float, options:Any):FlxTween
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

        return FlxTween.tween(game.strumLineNotes.members[note], props, time, opt);
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