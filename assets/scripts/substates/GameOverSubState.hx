import funkin.states.PlayState;
import funkin.visuals.game.Character;

import flixel.util.FlxColor;
import flixel.sound.FlxSound;
import flixel.FlxObject;

var deathMusic:FlxSound;
var deathStart:FlxSound;

var bfCamera:FlxCamera;

var bf:Character;

function onCreate()
{
    Paths.music('gameOverEnd');

    deathMusic = new FlxSound().loadEmbedded(Paths.music(PlayState.isPixelStage ? 'gameOver-pixel' : 'gameOver'));
	FlxG.sound.list.add(deathMusic);
    deathMusic.looped = true;

    deathStart = new FlxSound().loadEmbedded(Paths.sound(PlayState.isPixelStage ? 'fnf_loss_sfx-pixel' : 'fnf_loss_sfx'));
	FlxG.sound.list.add(deathStart);
    deathStart.play();

    bfCamera = new FlxCamera();
    FlxG.cameras.add(bfCamera, false);
    bfCamera.zoom = game.camGame.zoom;
    bfCamera.scroll.x = game.camGame.scroll.x;
    bfCamera.scroll.y = game.camGame.scroll.y;

    bf = new Character(PlayState.instance.boyfriend.x, PlayState.instance.boyfriend.y, PlayState.instance.boyfriend.deadVariant, true);
    add(bf);
    bf.cameras = [bfCamera];
    bf.playAnim('firstDeath');

    bf.animation.finishCallback = (name:String) -> {
		if (name == 'firstDeath')
		{
			deathMusic.play();

			bf.playAnim('deathLoop', true);
		}
	};
    
    var camFollow = new FlxObject(0, 0, 1, 1);
    camFollow.setPosition(bf.getGraphicMidpoint().x + bf.cameraPosition[0], bf.getGraphicMidpoint().y + bf.cameraPosition[1]);
    bfCamera.follow(camFollow, null, 0.025);
}

var canPress:Bool = true;

function onUpdate()
{
    if (canPress)
    {
        if (Controls.ACCEPT)
        {
            deathStart.stop();
            deathMusic.stop();
            
            FlxG.sound.play(Paths.music(PlayState.isPixelStage ? 'gameOverEnd-pixel' : 'gameOverEnd'));

            bf.playAnim('deathConfirm', true);

            FlxTween.cancelTweensOf(bfCamera);

            FlxTween.tween(bf, {alpha: 0}, 2, {ease: FlxEase.quintIn, onComplete: (_) -> { CoolUtil.resetState(); }});

            FlxTween.tween(bf.scale, {x: bf.scale.x - 0.1, y: bf.scale.y - 0.1}, 2, {ease: FlxEase.quintIn});

            canPress = false;
        }

        if (Controls.BACK)
		{
			PlayState.instance.vocals.volume = 0;

			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			PlayState.changedDifficulty = false;
			PlayState.chartingMode = false;
			
			PlayState.instance.paused = true;

			CoolVars.skipTransIn = true;

			FlxG.camera.followLerp = 0;

			FlxG.sound.playMusic(Paths.music('freakyMenu'));

			CoolUtil.switchState(new CustomState(PlayState.isStoryMode ? CoolVars.data.storyMenuState : CoolVars.data.freeplayState));
            
            close();
        }
    }
}

function onDestroy()
{
    FlxG.cameras.remove(bfCamera);
}