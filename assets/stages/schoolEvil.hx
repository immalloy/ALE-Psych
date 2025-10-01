var bg:FlxSprite;

function onCreate()
{
    bg = new FlxSprite(400, 200);

    if (ClientPrefs.data.lowQuality)
    {
        bg.loadGraphic(Paths.image('stages/schoolEvil/lowSchool'));
    } else {
        bg.frames = Paths.getSparrowAtlas('stages/schoolEvil/school');
        bg.animation.addByPrefix('idle', 'background 2');
        bg.animation.play('idle');
    }

    bg.scale.set(6, 6);
    addBehindGF(bg);
}

function postCreate()
{
    game.camGame.pixelPerfectRender = true;
    game.camHUD.pixelPerfectRender = true;
}

function onDestroy()
{
    game.camGame.pixelPerfectRender = false;
    game.camHUD.pixelPerfectRender = false;
}