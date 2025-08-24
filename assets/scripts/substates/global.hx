function onUpdate(elapsed:Float)
{
    if (FlxG.keys.justPressed.ESCAPE && CoolVars.data.developerMode)
        close();
}