package funkin.substates;

import haxe.ds.StringMap;

class CustomSubState extends ScriptSubState
{
    public static var instance:CustomSubState;

    public var scriptName:String = '';

    public var arguments:Array<Dynamic>;
    
    public var hsVariables:StringMap<Dynamic>;
    public var luaVariables:StringMap<Dynamic>;

    override public function new(script:String, ?arguments:Array<Dynamic>, ?hsVariables:StringMap<Dynamic>, ?luaVariables:StringMap<Dynamic>)
    {
        super();

        scriptName = script;

        this.arguments = arguments;

        this.hsVariables = hsVariables;
        this.luaVariables = luaVariables;
    }

    override public function create()
    {        
        super.create();

        instance = this;

        loadScripts();

        setOnScripts('arguments', arguments);

        for (map in [hsVariables, luaVariables])
            if (map != null)
                for (key in map.keys())
                    if (map == hsVariables)
                        setOnHScripts(key, map.get(key));
                    else
                        setOnLuaScripts(key, map.get(key));

        openCallback = function() { callOnScripts('onOpen'); };
        closeCallback = function() { callOnScripts('onClose'); };

        callOnScripts('onCreate');

        callOnScripts('postCreate');
    }

    private function loadScripts()
    {
        loadScript(scriptName);
        
        loadScript('global');
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        callOnScripts('onUpdate', [elapsed]);

        callOnScripts('postUpdate', [elapsed]);
    }

    override public function destroy()
    {
        super.destroy();

        callOnScripts('onDestroy');

        instance = null;

        callOnScripts('postDestroy');

        destroyScripts();
    }

    override public function stepHit()
    {
        super.stepHit();

        setOnScripts('curStep', curStep);

        callOnScripts('onStepHit');

        callOnScripts('postStepHit');
    }

    override public function beatHit()
    {
        super.beatHit();

        setOnScripts('curBeat', curBeat);

        callOnScripts('onBeatHit');

        callOnScripts('postBeatHit');
    }

    override public function sectionHit()
    {
        super.sectionHit();

        setOnScripts('curSection', curSection);

        callOnScripts('onSectionHit');

        callOnScripts('postSectionHit');
    }

    override public function onFocus()
    {
        super.onFocus();

        callOnScripts('onOnFocus');

        callOnScripts('postOnFocus');
    }

    override public function onFocusLost()
    {
        super.onFocusLost();

        callOnScripts('onOnFocusLost');

        callOnScripts('postOnFocusLost');
    }
}