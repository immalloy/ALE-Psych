package scripting.lua.callbacks;

import scripting.lua.LuaPresetBase;

import scripting.lua.LuaPresetUtils;

import funkin.visuals.cutscenes.DialogueBoxPsych;

import sys.FileSystem;

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

        /**
         * Termina la canción
         */
        set('endSong', function()
        {
            game.KillNotes();

            game.endSong();
        });

        /**
         * Reinicia la canción
         */
        set('restartSong', function()
        {
            game.paused = true;
            game.vocals.volume = 0;

            game.shouldClearMemory = false;

            FlxG.sound.music.volume = 0;
            
            CoolUtil.resetState();
        });

        /**
         * Sale de la canción hacia el menú correspondiente
         */
        set('exitSong', function()
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

        /**
         * Define el objetivo de la cámara del juego
         * 
         * @param target Objetivo de la cámara. Puede ser `gf`/`girlfriend`, `dad`/`opponent` o `bf`/`boyfriend`
         */
        set('cameraSetTarget', function(target:String)
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

        /**
         * Ejecuta un evento en la canción
         * 
         * @param name Nombre del evento
         * @param arg1 Primer argumento del evento
         * @param arg2 Segundo argumento del evento
         */
        set('triggerEvent', function(name:String, arg1:Dynamic, arg2:Dynamic)
        {
			game.triggerEvent(name, arg1, arg2, Conductor.songPosition);
        });

        /**
         * Ejecuta la lógica del baile a un personaje
         * 
         * @param character Personaje que se usará. Puede ser `gf`/`girlfriend`, `dad`/`opponent` o `bf`/`boyfriend`
         */
        set('characterDance', function(character:String)
        {
			switch (character.toLowerCase())
            {
				case 'dad', 'opponent':
                    game.dad.dance();
				case 'gf' | 'girlfriend':
                    if (game.gf != null)
                        game.gf.dance();
				default:
                    game.boyfriend.dance();
			}
        });
        
        /**
         * Inicia el diálogo de la canción
         * 
         * @param dialogueFile Archivo que contiene el diálogo
         * @param music Ruta del audio que se reproducirá como música
         */
        set('startDialogue', function(dialogueFile:String, ?music:String)
        {
            var path:String = CoolUtil.searchComplexFile(PlayState.songRoute + '/' + dialogueFile);

			if (FileSystem.exists(path))
			{
				var shit:DialogueFile = DialogueBoxPsych.parseDialogue(path);

				if (shit.dialogue.length > 0)
					game.startDialogue(shit, music);
			}
        });

        /**
         * Realiza un tween sobre una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param props Tabla de variables que se van a modificar
         * @param time Duración del tween
         * @param options Opciones del tween. Véase [TweenOptions](https://api.haxeflixel.com/flixel/tweens/TweenOptions.html)
         */
        set('noteTween', function(tag:String, note:Int, props:Dynamic, ?time:Float, ?options:Dynamic)
        {
            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], props, time, options));
        });

        /**
         * Realiza un tween sobre la variable `x` de una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param value Valor de la variable
         * @param duration Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `noteTween` en su lugar
         */
        set('noteTweenX', function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenX"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], {x: value}, duration, {ease: ease}));
        });

        /**
         * Realiza un tween sobre la variable `y` de una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param value Valor de la variable
         * @param duration Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `noteTween` en su lugar
         */
        set('noteTweenY', function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenY"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], {y: value}, duration, {ease: ease}));
        });

        /**
         * Realiza un tween sobre la variable `angle` de una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param value Valor de la variable
         * @param duration Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `noteTween` en su lugar
         */
        set('noteTweenAngle', function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenAngle"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], {angle: value}, duration, {ease: ease}));
        });

        /**
         * Realiza un tween sobre la variable `direction` de una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param value Valor de la variable
         * @param duration Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `noteTween` en su lugar
         */
        set('noteTweenDirection', function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenDirection"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], {direction: value}, duration, {ease: ease}));
        });

        /**
         * Realiza un tween sobre la variable `alpha` de una nota
         * 
         * @param tag ID del tween
         * @param note Posición de la nota en el strumLine
         * @param value Valor de la variable
         * @param duration Duración del tween
         * @param ease Ease del tween
         * 
         * @deprecated Use `noteTween` en su lugar
         */
        set('noteTweenAlpha', function(tag:String, note:Int, value:Dynamic, duration:Float, ease:String)
        {
            deprecatedPrint('Use "noteTween" instead of "noteTweenAlpha"');

            setTag(tag, LuaPresetUtils.complexTween(lua, tag, game.strumLineNotes.members[note], {alpha: value}, duration, {ease: ease}));
        });
		
        /**
         * Añade un objeto al juego detrás de la entidad Girlfriend
         * 
         * @param obj ID del objeto
         */
        set('addBehindGF', function(obj:String)
        {
            game.insert(game.members.indexOf(game.gfGroup), getTag(obj));
        });
        
        /**
         * Añade un objeto al juego detrás de la entidad Boyfriend
         * 
         * @param obj ID del objeto
         */
        set('addBehindBF', function(obj:String)
        {
            game.insert(game.members.indexOf(game.boyfriendGroup), getTag(obj));
        });
        
        /**
         * Añade un objeto al juego detrás de la entidad Dad
         * 
         * @param obj ID del objeto
         */
        set('addBehindDad', function(obj:String)
        {
            game.insert(game.members.indexOf(game.dadGroup), getTag(obj));
        });
    }
}