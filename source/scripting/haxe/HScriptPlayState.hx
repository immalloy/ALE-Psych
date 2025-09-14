package scripting.haxe;

import flixel.FlxBasic;

class HScriptPlayState
{
    public var game:PlayState = PlayState.instance;

    public function new(hs:HScript)
    {
        hs.set('addBehindGF', function(obj:FlxBasic)
        {
            game.insert(game.members.indexOf(game.gfGroup), obj);
        });
        
        hs.set('addBehindBF', function(obj:FlxBasic)
        {
            game.insert(game.members.indexOf(game.boyfriendGroup), obj);
        });
        
        hs.set('addBehindDad', function(obj:FlxBasic)
        {
            game.insert(game.members.indexOf(game.dadGroup), obj);
        });
    }
}