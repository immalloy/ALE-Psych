import flixel.group.FlxTypedGroup;

import stages.RunningTankman;

var sky:FlxSprite;

var clouds:FlxSprite;
var mountains:FlxSprite;
var buildings:FlxSprite;

var ruins:FlxSprite;

var smokeLeft:FlxSprite;
var smokeRight:FlxSprite;
var watchTower:FlxSprite;

var tank:FlxSprite;

var ground:FlxSprite;

var foreground:FlxTypedGroup;

var tankSpeed:Float = FlxG.random.float(5, 7);
var tankAngle:Float = FlxG.random.int(-90, 45);

var tankmanRun:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

function onCreate()
{
	sky = createSprite('sky', -400, -400, 1, 0);

	if (!ClientPrefs.data.lowQuality)
	{
		clouds = createSprite('clouds', FlxG.random.int(-700, -100), FlxG.random.int(-20, 20), 1, 0.1);
		clouds.velocity.x = FlxG.random.float(5, 15);

		mountains = createSprite('mountains', -300, -20, 1.2, 0.2);

		buildings = createSprite('buildings', -200, 0, 1.1, 0.3);
	}

	ruins = createSprite('ruins', -200, 0, 1.1, 0.35);

	if (!ClientPrefs.data.lowQuality)
	{
		smokeLeft = createSprite('smokeLeft', -200, -100, 1, 0.4, true, [['smoke', 'SmokeBlurLeft']], true);
		smokeRight = createSprite('smokeRight', 1100, -100, 1, 0.4, true, [['smoke', 'SmokeRight']], true);

		watchTower = createSprite('watchTower', 100, 50, 1, 0.5, true, [['idle', 'watchtower gradient color']]);
	}

	tank = createSprite('tank', 0, 0, 1, 0.5, true, [['idle', 'BG tank w lighting']], true);

	addBehindGF(tankmanRun);

	ground = createSprite('ground', -420, -150, 1.15);
	
	foreground = new FlxTypedGroup();
	add(foreground);

	foreground.add(createSprite('tank0', -500, 650, 1, 1.5, true, [['idle', 'fg']]));

	foreground.members[foreground.members.length - 1].scrollFactor.x = 1.7;

	if (!ClientPrefs.data.lowQuality)
	{
		foreground.add(createSprite('tank1', -300, 720, 1, 0.2, true, [['idle', 'fg']]));

		foreground.members[foreground.members.length - 1].scrollFactor.x = 2;
	}

	foreground.add(createSprite('tank2', 450, 940, 1, 1.5, true, [['idle', 'foreground']]));

	if (!ClientPrefs.data.lowQuality)
		foreground.add(createSprite('tank4', 1300, 900, 1, 1.5, true, [['idle', 'fg']]));

	foreground.add(createSprite('tank5', 1620, 700, 1, 1.5, true, [['idle', 'fg']]));

	if (!ClientPrefs.data.lowQuality)
	{
		foreground.add(createSprite('tank3', 1300, 1200, 1, 2.5, true, [['idle', 'fg']]));

		foreground.members[foreground.members.length - 1].scrollFactor.x = 3.5;
	}
}

function onBeatHit(curBeat:Int)
{
	for (sprite in foreground)
		sprite.animation.play('idle', true);
}

function onUpdate(elapsed:Float)
{
	tankAngle += elapsed * tankSpeed;
	tank.angle = tankAngle - 90 + 15;
	tank.x = 400 + 1500 * Math.cos(Math.PI / 180 * (tankAngle + 180));
	tank.y = 1300 + 1100 * Math.sin(Math.PI / 180 * (tankAngle + 180));
}

function createSprite(image:String, ?x:Float, ?y:Float, ?scale:Float, ?scroll:Float, ?addInState:Bool, ?animations:Array, ?loop:Bool):FlxSprite
{
	var sprite:FlxSprite = new FlxSprite(x, y);

	if (animations == null)
	{
		sprite.loadGraphic(Paths.image('stages/tank/' + image));
	} else {
		if (loop == null)
			loop = false;

		sprite.frames = Paths.getSparrowAtlas('stages/tank/' + image);

		for (anim in animations)
			sprite.animation.addByPrefix(anim[0], anim[1], 24, loop);

		sprite.animation.play(animations[0][0]);
	}

	if (addInState == null)
		addInState = true;

	if (addInState)
		addBehindGF(sprite);

	sprite.scale.x = sprite.scale.y = scale ?? 1;
	sprite.updateHitbox();
	sprite.scrollFactor.x = sprite.scrollFactor.y = scroll ?? 1;
	sprite.antialiasing = ClientPrefs.data.antialiasing;

	return sprite;
}

var showRunningTankmans:Bool = PlayState.SONG.gfVersion == 'pico-speaker';

var animationNotes:Array<Dynamic> = [];

var tankmanPool:Array<RunningTankman> = [];

function getTankman():RunningTankman
{
	for (t in tankmanPool)
		if (!t.alive)
			return t;

	var newTank = new RunningTankman(0, 0, true);
	tankmanPool.push(newTank);
	tankmanRun.add(newTank);

	return newTank;
}

function postCreate()
{
	if (!showRunningTankmans)
		return;

	animationNotes = game.gf.animationNotes;

	var firstTank:RunningTankman = new RunningTankman(20, 500, true);
	firstTank.resetShit(20, 1500, true);
	firstTank.strumTime = 10;
	firstTank.visible = false;
	tankmanRun.add(firstTank);

	for (anim in animationNotes)
	{
		if (FlxG.random.bool(16))
		{
			var tankBih = getTankman();
			tankBih.strumTime = anim[0];
			tankBih.resetShit(500, 250 + FlxG.random.int(50, 100), anim[1] < 2);
			tankmanRun.add(tankBih);
		}
	}
}