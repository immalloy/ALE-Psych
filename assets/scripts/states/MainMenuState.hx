import flixel.text.FlxTextBorderStyle;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;
import funkin.states.OptionsState;

var bg:FlxSprite;
var magentaBg:FlxSprite;

var options:Array = ['storyMode', 'freeplay', 'credits', 'options'];

var sprites:FlxTypedGroup = new FlxTypedGroup();

var selInt:Int = CoolUtil.save.custom.data.mainMenu ?? 0;

var version:FlxText;

var camPos = 0;

Paths.sound('scrollMenu');

function onCreate()
{
    bg = new FlxSprite().loadGraphic(Paths.image('ui/menuBGYellow'));
    add(bg);
    bg.antialiasing = ClientPrefs.data.antialiasing;
    bg.scrollFactor.set(0, 0.75 / options.length);
    bg.scale.set(1.25, 1.25);
    bg.screenCenter('x');

    magentaBg = new FlxSprite().loadGraphic(Paths.image('ui/menuBGMagenta'));
    add(magentaBg);
    magentaBg.antialiasing = ClientPrefs.data.antialiasing;
    magentaBg.scrollFactor.set(0, 0.75 / options.length);
    magentaBg.scale.set(1.25, 1.25);
    magentaBg.screenCenter('x');
    magentaBg.visible = false;
    
    add(sprites);

    for (i in 0...options.length)
    {
        var img = new FlxSprite(0, 22.5 + i * 175 + 108 - (options.length - options.length / 2) * 54);
        img.frames = Paths.getSparrowAtlas('mainMenuState/' + options[i]);
        img.animation.addByPrefix('basic', 'basic', 24, true);
        img.animation.addByPrefix('white', 'white', 24, true);
        img.animation.play('basic');
        sprites.add(img);
        img.antialiasing = ClientPrefs.data.antialiasing;
        img.scrollFactor.set(0, options.length / 10);
        img.x = FlxG.width / 2 - img.width / 2;
    }

    version = new FlxText(10, 0, 0, 'ALE Psych ' + CoolVars.engineVersion + '\n');
    version.setFormat(Paths.font('vcr.ttf'), 17, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    add(version);
    version.scrollFactor.set();
    version.y = FlxG.height - version.height - 10;

    changeShit();
}

var canSelect:Bool = true;

function onUpdate(elapsed:Float)
{
    game.camGame.scroll.y = CoolUtil.fpsLerp(game.camGame.scroll.y, camPos, 0.15);

    if (canSelect)
    {
        if (Controls.UI_UP_P || Controls.UI_DOWN_P || FlxG.mouse.wheel != 0)
        {
            if (Controls.UI_UP_P || FlxG.mouse.wheel > 0)
            {
                if (selInt > 0)
                    selInt--;
                else
                    selInt = sprites.members.length - 1;
            }
    
            if (Controls.UI_DOWN_P || FlxG.mouse.wheel < 0)
            {
                if (selInt < sprites.members.length - 1)
                    selInt++;
                else
                    selInt = 0;
            }
    
            changeShit();
    
            FlxG.sound.play(Paths.sound('scrollMenu'));
        }

        if (Controls.ACCEPT)
        {
            if (ClientPrefs.data.flashing)
                FlxFlicker.flicker(magentaBg, 1.1, 0.15, false);
            
            canSelect = false;

            for (i in 0...sprites.members.length)
            {
                if (i == selInt)
                {
                    if (ClientPrefs.data.flashing)
                        FlxFlicker.flicker(sprites.members[i], 0, 0.05);
                } else {
                    FlxTween.tween(sprites.members[i], {alpha: 0}, 60 / Conductor.bpm, {ease: FlxEase.cubeIn});
                }
            }
        
            new FlxTimer().start(1, function(tmr:FlxTimer)
            {
                switch (options[selInt])
                {
                    case 'storyMode':
                        CoolUtil.switchState(new CustomState(CoolVars.data.storyMenuState));
                    case 'freeplay':
                        CoolUtil.switchState(new CustomState(CoolVars.data.freeplayState));
                    case 'credits':
                        CoolUtil.switchState(new CustomState('CreditsState'));
                    case 'options':
                        CoolUtil.switchState(new OptionsState());
                }
            });

            FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
        }

        if (Controls.ENGINE_CHART)
        {
            canSelect = false;

            CoolUtil.switchState(new funkin.editors.MasterEditorMenu());
        }

        if (Controls.BACK)
        {
            CoolUtil.switchState(new CustomState(CoolVars.data.initialState));
    
            canSelect = false;

            FlxG.sound.play(Paths.sound('cancelMenu'));
        }
    }
}

function changeShit()
{
    var totalHeight:Float = 0;

    var offset:Float = 0;
    
    for (sprite in sprites)
        totalHeight += sprite.height + 175;

    for (index => sprite in sprites)
    {
        if (index == selInt)
        {
            sprite.animation.play('white');
            
            camPos = sprite.y + sprite.height / 2 - FlxG.height / 2;
        } else {
            sprite.animation.play('basic');
        }
    
        sprite.centerOffsets();
        sprite.x = FlxG.width / 2 - sprite.width / 2;
    }
}

function onDestroy()
{
    CoolUtil.save.custom.data.mainMenu = selInt;
    CoolUtil.save.custom.flush();
}