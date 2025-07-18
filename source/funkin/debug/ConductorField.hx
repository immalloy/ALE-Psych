package funkin.debug;

@:access(core.backend.MusicBeatState)
class ConductorField extends DebugField
{
    override public function new()
    {
        super('Conductor Info');
    }

    var theText:String = '';

    override function updateField(elapsed:Float)
    {
        theText = 'Song Position: ' + Conductor.songPosition;
        theText += '\n - Step: ' + (MusicBeatState.instance == null ? MusicBeatState.instance.curStep : 0);
        theText += '\n - Beat: ' + (MusicBeatState.instance == null ? MusicBeatState.instance.curBeat : 0);
        theText += '\n - Section: ' + (MusicBeatState.instance == null ? MusicBeatState.instance.curSection : 0);
        theText += '\nBPM: ' + Conductor.bpm;

        text.text = theText;
    }
}