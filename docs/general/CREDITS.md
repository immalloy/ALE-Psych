# Modifying Credits

As in Psych Engine, you can modify the options with a file, in this case, `credits.json`. Below we will show you how to properly create this file.

## Getting Started

The first thing to do is add the `categories` variable.

```json
{
    "categories": []
}
```

## Creating a Category

```json
{
    "name": "My Category",
    "developers": []
}
```

### Variables

1. **name**: Defines the name of the category/group.
1. **developers**: This is the list containing each of the members of the category.

## Creating a Member

```json
{
    "name": "My Member",
    "icon": "memberIcon",
    "link": "https://example.com/",
    "description": "Collaborated on my mod as a coder",
    "color": "00FFFF"
}
```

### Variables

1. **name**: Defines the name of the member.
1. **icon**: Defines the icon that the game will look for in `images/credits/`. It must be in PNG format.
1. **link**: Defines the link to which the game will redirect when that member is selected.
1. **description**: Useful for defining the role that the member played in the development of the mod.
1. **color**: Defines the color that the menu background will change to when that developer is selected. It is written as a string.

## Example

```json
{
    "categories": [
        {
            "name": "ALE Psych Crew",
            "developers": [
                {
                    "name": "AlejoGDOfficial",
                    "icon": "alejo",
                    "link": "https://www.youtube.com/@alejogdofficial",
                    "description": "Director and Lead Programmer",
                    "color": "5457B0"
                },
                {
                    "name": "Kriptel",
                    "icon": "kriptel",
                    "link": "https://www.youtube.com/@kriptel_pro",
                    "description": "Collaborated on the Implementation of RuleScript\nProgrammed some Macros",
                    "color": "731D1D"
                },
                {
                    "name": "ManuArtz",
                    "icon": "manu",
                    "link": "https://www.youtube.com/@MArtz_06",
                    "description": "Main Artist",
                    "color": "43406E"
                },
                {
                    "name": "Aleja",
                    "icon": "aleja",
                    "link": "https://www.youtube.com/@ale_engine",
                    "description": "Co-founder of ALE Engine",
                    "color": "692F2F"
                }
            ]
        },
        {
            "name": "Psych Engine Team",
            "developers": [
                {
                    "name": "Shadow Mario",
                    "icon": "shadowmario",
                    "link": "https://ko-fi.com/shadowmario",
                    "description": "Main Programmer and Head of Psych Engine",
                    "color": "444444"
                },
                {
                    "name": "Riveren",
                    "icon": "riveren",
                    "link": "https://twitter.com/riverennn",
                    "description": "Main Artist/Animator of Psych Engine",
                    "color": "14967B"
                }
            ]
        },
        {
            "name": "Former Psych Engine Members",
            "developers": [
                {
                    "name": "bb-panzu",
                    "icon": "bb",
                    "link": "https://twitter.com/bbsub3",
                    "description": "Ex-Programmer of Psych Engine",
                    "color": "3E813A"
                },
                {
                    "name": "shubs",
                    "icon": "face",
                    "link": "",
                    "description": "Ex-Programmer of Psych Engine\nI don't support them.",
                    "color": "A1A1A1"
                }
            ]
        },
        {
            "name": "Psych Engine Contributors",
            "developers": [
                {
                    "name": "CrowPlexus",
                    "icon": "crowplexus",
                    "link": "https://twitter.com/crowplexus",
                    "description": "Input System v3, Major Help and Other PRs",
                    "color": "A1A1A1"
                },
                {
                    "name": "Keoiki",
                    "icon": "keoiki",
                    "link": "https://twitter.com/Keoiki_",
                    "description": "Note Splash Animations and Latin Alphabet",
                    "color": "D2D2D2"
                },
                {
                    "name": "SqirraRNG",
                    "icon": "sqirra",
                    "link": "https://twitter.com/gedehari",
                    "description": "Crash Handler and Base code for\nChart Editor's Waveform",
                    "color": "E1843A"
                },
                {
                    "name": "EliteMasterEric",
                    "icon": "mastereric",
                    "link": "https://twitter.com/EliteMasterEric",
                    "description": "Runtime Shaders support",
                    "color": "FFBD40"
                },
                {
                    "name": "PolybiusProxy",
                    "icon": "proxy",
                    "link": "https://twitter.com/polybiusproxy",
                    "description": ".MP4 Video Loader Library (hxCodec)",
                    "color": "DCD294"
                },
                {
                    "name": "Tahir",
                    "icon": "tahir",
                    "link": "https://twitter.com/tahirk618",
                    "description": "Implementing & Maintaining SScript and Other PRs",
                    "color": "A04397"
                },
                {
                    "name": "iFlicky",
                    "icon": "flicky",
                    "link": "https://twitter.com/flicky_i",
                    "description": "Composer of Psync and Tea Time\nMade the Dialogue Sounds",
                    "color": "9E29CF"
                },
                {
                    "name": "KadeDev",
                    "icon": "kade",
                    "link": "https://twitter.com/kade0912",
                    "description": "Fixed some issues on Chart Editor and Other PRs",
                    "color": "64A250"
                },
                {
                    "name": "superpowers04",
                    "icon": "superpowers04",
                    "link": "https://twitter.com/superpowers04",
                    "description": "LUA JIT Fork",
                    "color": "B957ED"
                },
                {
                    "name": "CheemsAndFriends",
                    "icon": "face",
                    "link": "https://twitter.com/CheemsnFriendos",
                    "description": "Creator of FlxAnimate\n(Icon will be added later, merry christmas!)",
                    "color": "A1A1A1"
                }
            ]
        },
        {
            "name": "Funkin' Crew",
            "developers": [
                {
                    "name": "ninjamuffin99",
                    "icon": "ninjamuffin99",
                    "link": "https://twitter.com/ninja_muffin99",
                    "description": "Programmer of Friday Night Funkin'",
                    "color": "CF2D2D"
                },
                {
                    "name": "PhantomArcade",
                    "icon": "phantomarcade",
                    "link": "https://twitter.com/PhantomArcade3K",
                    "description": "Animator of Friday Night Funkin'",
                    "color": "FADC45"
                },
                {
                    "name": "evilsk8r",
                    "icon": "evilsk8r",
                    "link": "https://twitter.com/evilsk8r",
                    "description": "Artist of Friday Night Funkin'",
                    "color": "5ABD4B"
                },
                {
                    "name": "kawaisprite",
                    "icon": "kawaisprite",
                    "link": "https://twitter.com/kawaisprite",
                    "description": "Composer of Friday Night Funkin'",
                    "color": "378FC7"
                }
            ]
        }
    ]
}
```