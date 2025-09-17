<h1 align="center">
  <img src="art/githubLogo.png" alt="ALE Psych Logo">
</h1>

<h2 align="center">
  "If Psych was so good, why wasn’t there a Psych 2?"  
</h2>

---

## Overview
**ALE Psych** is a fork of **Psych Engine 0.7.3**, created to replace **ALE Engine**, fix long-standing issues, and add new features.  

The goal is simple: give developers the tools to build complete mods **without touching the source code**, while keeping the comfort and flexibility that Psych Engine provided.  

---

## Downloads
Official releases are still in progress. For now, you can grab the latest build from [GitHub Actions](https://github.com/ALE-Engine-Crew/ALE-Psych/actions).  

- We recommend waiting for tagged releases for stability.  
- If you’re experimenting, builds from Actions are fine.  

See the [Getting Started Guide](https://github.com/ALE-Psych-Crew/ALE-Psych/wiki) for setup instructions.  

**For players:** press **Ctrl + Shift + M** to open the Mods menu.  

Join the [Discord server](https://discord.gg/NP4U9CUrsH) to get help, follow updates, or contribute.  

---

## Key Differences from Psych
- Scripted **menus and submenus** (Lua and HScript).  
- Support for **custom classes**.  
- Configurable **data.json** for engine/game properties.  
- JSON-based **options and credits**.  
- Integration with **RuleScript** for advanced HScript features.  
- Reorganized source structure, especially Lua.  
- Memory cleanup on menu changes.  
- Redesigned song loading (charts, scripts, audio).  
- `CoolUtil.save` replaces `FlxG.save` to avoid conflicts between mods.  
- Access the **Game Console** with `F2`.  

---

## Current Limitations
ALE Psych is still **work in progress**:  

- Editors are unstable and may crash. Use Psych 0.7.3 for editor work.  
- Some performance issues may still exist.  
- Documentation is incomplete.  
- Certain HScript/Lua functions are missing.  
- Transitions, pause menu, game over, and default songs are not fully customizable.  
- Original week backgrounds are still in source; planned rewrite in HScript.  
- Options menu rewrite and note color customization are pending.  
- More Lua functions and extensible classes are planned.  

---

## Contributing
We welcome contributions:  

- Report issues and request features via [Issues](https://github.com/ALE-Engine-Crew/ALE-Psych/issues).  
- Submit pull requests that follow the existing coding style.  
- Test changes on at least one desktop platform.  
- Document new features in the [Wiki](https://github.com/ALE-Psych-Crew/ALE-Psych/wiki).  

---

## Credits
- **AlejoGDOfficial** — Director and Lead Programmer  
- **Kriptel** — RuleScript integration  
- **ManuArtz** — Art  
- **Malloy** — Rewrote Readme + Made Wiki
- **Psych Engine Team** — Original base project
- And [all contributors](https://github.com/ALE-Psych-Crew/ALE-Psych/graphs/contributors)  

---

## License
ALE Psych is released under the **Apache License 2.0**.  
See [LICENSE](LICENSE) for details.  
