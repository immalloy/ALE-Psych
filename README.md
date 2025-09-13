<h1 align="center">
    <img src="art/githubLogo.png">
</h1>

<h2 align="center">
    "If Psych was so good, why wasn’t there a Psych 2?" [WIP]
</h2>

**ALE Psych** is a *fork* of **Psych Engine 0.7.3**, created to replace *ALE Engine*, fix Psych, and add *~~a few~~* new features.

The *idea* behind the engine is ***NOT* to have to use the source code** at all, but to have the tools to make an *incredible mod* with the **comfort** that *Psych Engine* gave us.

If you do not know how to use the Engine, please review the [Getting Started Guide](docs/general/GETTING-STARTED).

Join the [Discord server](https://discord.gg/NP4U9CUrsH)!

#### For Players: I would like to clarify that to **access the Mods menu**, you must press the **[Ctrl + Shift + M]** keys

## What are the differences between Psych and ALE Psych?

- **Support for creating and modifying menus and submenus using scripts (Lua and HScript)**
- **Support for Custom Classes**
- **Added a JSON file where you can adjust various game properties**
- **Added a list of functions related to the Windows API (some of them only work on Windows 11)**
- **Rewrote several menus and submenus in Scripts to make them easier to modify**
- **Several classes are included that, although not used by default in the game, you can use from scripts.**
- Use of RuleScript as an HScript Library
- Reorganization of the Source Code (especially in the Lua section)
- Memory usage has been reduced by clearing it every time the menu is changed (with some exceptions to prevent some things from taking too long to load)
- Redesigned the way songs and their files are searched (Charts, Scripts, and Audios)
- CoolUtil.save is used instead of FlxG.save/FlxSave to make it easier to save preferences/scores without the files conflicting between mods
- Added access to the Game Console by pressing F2

#### And much more...!

## What issues does the Engine still have that would cause it to be considered a work in progress?

- **I'm *NOT* entirely sure, but I suspect there may be some performance issues**
- **Due to the changes that were made, the editors are not working properly, and sometimes crash when saving the file (I recommend doing the part related to the editors in Psych, preferably 0.7.3)**
- **The Engine is not well documented**
- Some necessary functions were removed from HScript and Lua, but they will be added later
- Things like transitions, the pause menu, the death screen, and the default menu song are not easy to customize yet, but I will work on that soon
- The backgrounds from the original weeks are still in the source code, but I will rewrite them in HScript at some point. (as in ALE Engine)
- We plan to add more functions to Lua so that it is not so complicated to work with this language
- The options menu is pending rewriting in HScript
- The menu for customizing note colors has not been added yet
- We plan to add more classes that can be extended through custom classes

## Where can I download it?

Although we recommend waiting for an official release due to ongoing changes, sometimes minor, or having the source code on hand, you can download the engine using [Github Actions](https://github.com/ALE-Engine-Crew/ALE-Psych/actions).

---

That's all for now. I'll start working on the engine documentation soon, or at least that's the plan.

Thank you for your time. I hope you find this project useful!