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
        theText += '\n - Step: ' + (MusicBeatState.instance == null ? 0 : MusicBeatState.instance.curStep);
        theText += '\n - Beat: ' + (MusicBeatState.instance == null ? 0 : MusicBeatState.instance.curBeat);
        theText += '\n - Section: ' + (MusicBeatState.instance == null ? 0 : MusicBeatState.instance.curSection);
        theText += '\nBPM: ' + Conductor.bpm;

        text.text = theText;
    }
}