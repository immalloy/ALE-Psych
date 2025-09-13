# Creating Custom Modules/Classes

Thanks to RuleScript, ALE Psych has the ability to create custom Classes/Modules using HScript. I won't go into much detail about this feature, as you can find information about it in the [Library Repository](https://github.com/Kriptel/RuleScript/tree/dev).

## Creating a Class

All classes are located in the `scripts/classes` folder. If we compare it to a project that uses source code, this folder acts as the `source` folder.

Example:
`scripts/classes/pack/MyClass.hx`

## Extending Other Classes

The only classes you can extend are found in [`Extensible`](https://github.com/ALE-Psych-Crew/ALE-Psych/blob/main/source/scripting/haxe/Extensible.hx). You can also extend custom classes; you just need to import them.

Example:
```haxe
import scripting.haxe.ScriptSprite;

class MySprite extends ScriptSprite
{
    public function new()
    {
        super();

        trace('This is My Custom Sprite');
    }
}
```

## Accessing a Custom Class

In HScript, it's as easy as adding an `import` like any other.

Example:
`import pack.MyClass;`