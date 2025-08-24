import flixel.util.FlxColor;

import funkin.visuals.objects.OptionText;

var subCamera:FlxCamera;

var sprites:FlxTypedGroup<Alphabet>;

var selInt:Int = 0;

var options:Array<String>;

function onCreate()
{
	options = [
		{
			name: 'Practice Mode',
			description: '',
			variable: 'practice',
			type: 'bool'
		},
		{
			name: 'Botplay',
			description: '',
			variable: 'botplay',
			type: 'bool'
		}
	];

	subCamera = new FlxCamera();
    subCamera.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(subCamera, false);

	var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	add(bg);
	bg.scrollFactor.set();
	bg.cameras = [subCamera];
	bg.alpha = 0;

	FlxTween.tween(bg, {alpha: 0.5}, 0.5, {ease: FlxEase.cubeOut});

	sprites = new FlxTypedGroup<Alphabet>();
	add(sprites);
	sprites.cameras = [subCamera];

	for (index => option in options)
	{
		var sprite:OptionText = new OptionText(option);
		sprite.x = 30 * index;
		sprite.y = 125 * index;
		sprites.add(sprite);
		sprite.cameras = [subCamera];
		sprite.alpha = 0.5;
	}

	changeShit();
}

function onUpdate(elapsed:Float)
{
	if (Controls.UI_UP_P || Controls.UI_DOWN_P || Controls.MOUSE_WHEEL)
	{
		if (Controls.UI_UP_P || Controls.MOUSE_WHEEL_UP)
			if (selInt <= 0)
				selInt = sprites.members.length - 1;
			else
				selInt--;

		if (Controls.UI_DOWN_P || Controls.MOUSE_WHEEL_DOWN)
			if (selInt >= sprites.members.length - 1)
				selInt = 0;
			else
				selInt++;

		changeShit();

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	if (Controls.ACCEPT)
		sprites.members[selInt].value = !sprites.members[selInt].value;

	if (Controls.BACK)
		close();

	subCamera.scroll.x = CoolUtil.fpsLerp(subCamera.scroll.x, 30 * selInt - 250, 0.3);
	subCamera.scroll.y = CoolUtil.fpsLerp(subCamera.scroll.y, 125 * selInt - 300, 0.3);
}

function changeShit()
{
	for (index => sprite in sprites)
	{
		sprite.alpha = index == selInt ? 1 : 0.5;
	}
}

function onDestroy()
{
    FlxG.cameras.remove(subCamera);
}