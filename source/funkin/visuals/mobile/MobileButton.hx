package funkin.visuals.mobile;

import core.backend.MobileControls;

import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;

class MobileButton extends FlxSpriteGroup
{
    public var keys:Null<Array<Null<FlxKey>>>;

    @:unreflective var replacedMap:Map<FlxKey, MobileButton> = new Map<FlxKey, MobileButton>();

    public var label:FlxSprite;
    public var bg:FlxSprite;
    
    override public function new(?x:Float, ?y:Float, keys:Array<Null<FlxKey>>, letter:String, ?width:Float, ?height:Float)
    {
        super(x, y);

        var theWidth:Int = Math.floor(width ?? 125);
        var theHeight:Int = Math.floor(height ?? 125);

        bg = new FlxSprite();
        add(bg);

        label = new FlxSprite();
        add(label);

        if (letter != null)
        {
            bg.makeGraphic(theWidth, theHeight, 0x80404040);

            label.frames = Paths.getSparrowAtlas('ui/alphabet');
            label.animation.addByPrefix('idle', letter.toLowerCase() + ' instance 1');
            label.animation.play('idle');
            label.setGraphicSize(0, theHeight - theHeight * 0.4);
            label.updateHitbox();
            label.offset.x -= theWidth / 2 - label.width / 2;
            label.offset.y -= theHeight / 2 - label.height / 2;
            label.color = FlxColor.BLACK;
        } else {            
            bg.makeGraphic(theWidth, theHeight, FlxColor.TRANSPARENT);

            label.makeGraphic(theWidth, theHeight, 0xFF404040);
            
            alpha = 0.5;
        }

        for (key in keys)
            if (key != null)
            {
                if (MobileControls._controlsMap.exists(key))
                    replacedMap.set(key, MobileControls._controlsMap.get(key));

                MobileControls._controlsMap.set(key, this);
            }

        this.keys = keys;
    }

    public var overlaped(get, never):Bool;
    function get_overlaped():Bool
        return FlxG.mouse.overlaps(bg, bg.cameras[0]);
    
    public var pressed:Bool = false;

    public var justPressed:Bool = false;

    public var justReleased:Bool = false;

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        justPressed = false;

        justReleased = false;

        if (Controls.MOUSE_P && overlaped)
        {
            pressed = true;

            justPressed = true;

            label.alpha = 0.5;
        }

        if (Controls.MOUSE_R && pressed)
        {
            pressed = false;

            justReleased = true;

            label.alpha = 1;
        }
    }

    override public function destroy()
    {
        for (key in keys)
            if (key != null)
                if (replacedMap.exists(key))
                    MobileControls._controlsMap.set(key, replacedMap.get(key));
                else
                    MobileControls._controlsMap.remove(key);

        super.destroy();
    }
}