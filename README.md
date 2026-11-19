![O'Deadly Skyrim](docs/ODeadly_Skyrim_cover.jpg)

# O'Deadly Skyrim (A SkyrimNet environmental mod)

**v1.1.7**
By **That Guy (Coronerra)**
Skyrim SE / AE · ESL-flagged plugin · Adults only

**[Download v1.1](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v1.1)** · [Changelog](CHANGELOG.md) · [Earlier v1.0.2](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v1.0.2) · [v1.0.1](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v1.0.1) · [v1.0](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v1.0) · [v0.9](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.9) · [v0.8](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.8) · [v0.7](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.7) · [v0.6](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.6) · [v0.5](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.5) · [v0.4](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.4) · [v0.3](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.3) · [v0.2](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.2) · [v0.1](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.1)

> **Talking to a victim during a scene:** pressing **E** (activate) on a victim counts as you trying to save them. It breaks the scene on purpose, and the attackers may turn on you. If you just want to talk to them, use SkyrimNet (its talk / voice input); that does not interrupt the scene. See [Playing the hero](#playing-the-hero).

Version 1.1.7 (`ODeadly_Skyrim_1.1.7.zip`) keeps every O'Deadly message at OStim scene start out of the way: "X has seen you…" (Caught) and "You feel eyes on you…" (Watched from a distance) are now always corner notifications, never a message box, whatever the MCM message style.

Version 1.1.6 (`ODeadly_Skyrim_1.1.6.zip`) removes Bitch in Heat's in-game "how many?" box, which popped up at the same time as OStim's own menu. You now set how many join in the MCM ahead of time (1, 2, 3 or random), for werewolves, werebears and vampire lords alike.

Version 1.1.5 (`ODeadly_Skyrim_1.1.5.zip`) widens Bitch in Heat to werebears and vampire lords (mixed packs, or taking turns where no group scenes exist) and adds the new Werewolf and Vampire Lord OStim 0.3.1 three-actor scenes. It also follows Growl's werebear totem, gives turned NPC vampires Sacrosanct's treatment when Sacrosanct is installed, and lets existing vampire followers (Serana and others) become vampire lords through SkyrimNet (off by default). Only OStim Beast Form is needed; Growl and Sacrosanct are detected, never required. See [New in 1.1.5](#new-in-115-bitch-in-heat-for-every-beast-growl-and-sacrosanct).

Version 1.1.4 (`ODeadly_Skyrim_1.1.4.zip`) lets O'Deadly change followers with Growl's beastblood through SkyrimNet too, and gives any NPC it infected the beast body whenever they are in beast form, whichever mod changed them (Growl included).

Version 1.1.3 (`ODeadly_Skyrim_1.1.3.zip`) fixes NPCs with their own skin (most custom followers) showing only a head in werewolf, werebear or vampire lord form: the beast skin is swapped in while they are changed and their own skin is given back afterwards. Followers with Growl's beastblood are left to Growl.

Version 1.1.2 (`ODeadly_Skyrim_1.1.2.zip`) gives O'Deadly a proper log file for bug reports: every game load writes a header plus what was found and what is switched on, then one line per event and the reason an event was skipped. See [Troubleshooting / log files](#troubleshooting--log-files).

Version 1.1.1 (`ODeadly_Skyrim_1.1.1.zip`) fixes Blood Born Pathogen never running in game (1.1) and makes werewolf, werebear and vampire lord blood turn people at once, no incubation. Version 1.1 opens Blood Born Pathogen to everyone: anyone who has sex with a werewolf, vampire lord or werebear may catch it (you too, and NPCs in their own scenes), with a chance per form and a world cap (default 10). NPCs this mod turned can change into their beast form and back through SkyrimNet, and there is a blood gift (SkyrimNet or a key). See [New in 1.1](#new-in-11-blood-born-pathogen-for-everyone-beast-forms-through-skyrimnet-blood-gift).

Version 1.0.2 (`ODeadly_Skyrim_1.0.2.zip`) makes Blood Born Pathogen problems visible: while the debug force is armed, the reason a partner could not be infected is shown on screen, MCM > Debug shows the last result, and everything O'Deadly logs also goes to its own `ODeadlySkyrim.log` (no Papyrus logging needed). See [New in 1.0.2](#new-in-102-blood-born-pathogen-diagnostics).

Version 1.0.1 is a Blood Born Pathogen fix: the log (and Debug notifications) now say why a partner could not be infected, an on-screen notice tells you when someone catches it (on by default), essential no longer blocks your own followers and spouse, and a new toggle lets protected followers / your spouse still catch it (off by default). Save-safe in-place update from 1.0. See [New in 1.0.1](#new-in-101-blood-born-pathogen-fix).

Version 1.0 (`ODeadly_Skyrim_1.0.zip`) adds three optional modules, all off by default: **Join in** (walk in on your spouse or a companion in a consensual scene and join them), **wild creatures** on the road (needs OCreatures), **OStim Beast Form** support (werewolves at night, choices when you transform, and Bitch in Heat: other werewolves drawn to a werewolf scene), **Blood Born Pathogen** (a werewolf or vampire player can pass it on through sex) and **Saturalia** (needs the Saturalia Holiday Pack). See [New in 1.0](#new-in-10-join-in-wild-creatures-ostim-beast-form).

Version 0.9 added two optional wilderness-road events, both off by default: Savior Complex (a bandit is forcefully taking a traveler; you can watch, join in, or rescue them) and Killer Rabbit vs Vigilants of Stendarr (two Vigilants are losing to a Killer Rabbit; you can kill it and save them). The rabbit event needs Mihail's Killer Rabbit of Caerbannog. See [New in 0.9](#new-in-09-savior-complex-and-killer-rabbit-vs-vigilants).

Version 0.8 fixed NPCs staying in their sleeping or sitting pose during a scene: anyone in a bed, bedroll or chair, or asleep, now gets up before the scene starts. See [New in 0.8](#new-in-08-nobody-stays-in-bed-pose).

Version 0.7 had two fixes. Sleep events now begin as you wake, after the sleep has finished, which makes O'Deadly work with NPC AI Position Fix (before, saving after a sleep event could crash). A bath scene now waits until the wash has really ended, so long bath animations (for example the Malignis Animations patch for Dirt and Blood) are no longer cut short. See [New in 0.7](#new-in-07-sleep-events-and-bath-timing).

Version 0.6 was a bug fix: on some setups no scenes ever started, because the main script stopped during its first startup. Updating from 0.5 keeps your settings except the protected-NPC list, which must be set again. See [New in 0.6](#new-in-06-bug-fix-scenes-never-started).

Version 0.5 added support for [Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288): O'Deadly detects it, leaves a downed player to it, and tells SkyrimNet what happens. If both Baka Defeat and ODefeat Reforged are installed you get an on-screen warning: use only one, preferably Baka Defeat. See [New in 0.5](#new-in-05-baka-defeat--ostim-edition-support) and the [changelog](CHANGELOG.md).

Feedback welcome: please report issues on [GitHub Issues](https://github.com/Coronerra/ODeadly-Skyrim/issues) with your Papyrus log.

This repository is the full public source and notes: Papyrus scripts, the plugin, the SkyrimNet decision pack, the compile and plugin-builder tools, the [changelog](CHANGELOG.md), and hook-level details in **[AI_CONTEXT.md](AI_CONTEXT.md)** (start there if you are an AI assistant or a modder extending this). License: [MIT for coronerra's work](LICENSE).

---

I really don't care for most of the features of this mod, but I realized I have a superpower. Because of my messed-up past, I can look at things with a clinical, non-judgmental mind. I saw a lot of what was on LoversLab, so I told my agent to try to make a true all-in-one, environmentally adjusting world for SkyrimNet that should work with any system. Instead of hunting for a million different environmental mods, just one big dark one the end user can tweak to their personal preferences or likings. This is what it gave me.

This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223). I never downloaded ODangerous Nights, so I have no idea if it is compatible. ODangerous Nights is not needed — this does the same thing, and so much more. All I could think was: why are all these mods based on the player being a chick and getting assaulted? Where are the followers? Why not the followers? So many of them are hotter. So from there I added on, and on, and on.

Its intent is to make Skyrim as… whatever as the end user wants. It is 100% based on the standard environment — as in Skyrim — not dependent on other environmental mods. Inns, jails, barracks, roads, camps and the wilderness are the ones already in the game. Version 0.2 can also pick up a few popular mods you may already have (iActions, Dirt and Blood, Bathing in Skyrim, Blood and OStim, Sacrosanct) when they are installed, 0.3 tells SkyrimNet what happens in OStim Kidnapped Redux and ODefeat Reforged, 0.4 can use Mihail's Killer Rabbit of Caerbannog for the climax fauna easter egg, 0.5 does the same for Baka Defeat – OStim Edition, 0.9 can start a Savior Complex or Killer Rabbit vs Vigilants road event (the rabbit event needs Mihail's Killer Rabbit of Caerbannog), and 1.0 can use OCreatures and OStim Beast Form for wilderness and beast-form encounters, but none of them is required.

If there are any other scenarios you want added that can work without additional mod requirements, I can.

If you like it, just [reply with a thumbs up](https://github.com/Coronerra/ODeadly-Skyrim/issues/1). If enough people like it, I'll upload it as a plugin for SkyrimNet.

---

## Contents

- [What it does](#what-it-does)
- [Playing the hero](#playing-the-hero)
- [Family-safe master switch](#family-safe-master-switch-read-this-first)
- [Requirements](#requirements)
- [Optional auto-detected mods](#optional-auto-detected-never-required-never-masters)
- [Install](#install-mo2)
- [How the engine works](#how-the-engine-works)
- [Modules and defaults](#modules-and-defaults)
- [New in 0.2](#new-in-02-mcm-page-more-encounters-inn-rooms-on-jail--inns)
- [New in 0.3](#new-in-03-follower-rescue-skyrimnet-messages-for-ostim-kidnapped-redux-and-odefeat-reforged)
- [New in 0.4](#new-in-04-killer-rabbit-of-caerbannog-climax-fauna-option)
- [New in 0.5](#new-in-05-baka-defeat--ostim-edition-support)
- [New in 0.6](#new-in-06-bug-fix-scenes-never-started)
- [New in 1.1.5](#new-in-115-bitch-in-heat-for-every-beast-growl-and-sacrosanct)
- [New in 1.0](#new-in-10-join-in-wild-creatures-ostim-beast-form)
- [New in 0.9](#new-in-09-savior-complex-and-killer-rabbit-vs-vigilants)
- [New in 0.8](#new-in-08-nobody-stays-in-bed-pose)
- [New in 0.7](#new-in-07-sleep-events-and-bath-timing)
- [MCM pages](#mcm-pages)
- [Test checklist](#test-checklist)
- [Known limits](#known-limits)
- [Repository contents](#repository-contents)
- [Credits](#credits)

## Design goals

- As few hard dependencies as possible, so it stays compatible with a wide range of lists.
- Events can involve the whole world, not only the player: followers and the people already around you.
- Every chance is toggleable and adjustable, from light to very dark.
- You can install it and leave it alone until something actually happens.

## What it does

One engine, one download, every feature on its own toggle, all of it behind one master switch. When the moment is right (you sleep, wait, linger in a cell, travel, or get beaten), a roll can start an OStim scene with the people who are actually around you. If SkyrimNet is installed, it can check a character's bio before they act, narrate what happened, and leave memories and rumours behind.

This is not a prison-only pack and not a nights-only pack. Night attacks, jails, inns, defeat, trespass, roads, relationships, optional creatures and the 0.2 modules (morning after, bathing, shared inn rooms, watched from a distance, Dark Gift and a silly climax easter egg) are all modules of the same engine.

**Adults only.** Children are refused for every role, always. This is not a setting.

Found a problem? Please report it with your Papyrus log (lines start with `[ODeadlySkyrim]`) and which modules you had on.

## Playing the hero

You walk into the inn and find bandits on your follower, mid-scene. Walk up to the victim and press **E** (activate): O'Deadly treats that as you stepping in to save them. The scene breaks on purpose, and the attackers may turn on you, so be ready to fight. (Hitting or activating an attacker works the same way.)

If you only want to talk to the victim, don't press E. Use SkyrimNet instead (its talk / voice input). That does not interrupt the scene.

## Family-safe master switch (read this first)

- The very first MCM option is the **master switch**. It is **OFF by default**. With it off, nothing in this mod ever happens.
- Bind a **Panic key** right under it (unbound by default so it does not steal one of your keys). One press, at any time:
  - stops any scene this mod started (OStim redresses everyone),
  - removes every actor this mod spawned,
  - gives back any gold a robber just took,
  - stops SkyrimNet's NPCs from talking about it right now,
  - turns the whole mod OFF until you switch it on again.
- Turning the master switch OFF in the MCM does exactly the same.
- This covers every module, including all 0.2 modules and the climax fauna easter egg: pending morning-after / bathing rolls are cancelled, a distant watcher and any rabbits or butterflies are removed.
- After a panic you get either nothing or a plain "O'Deadly Skyrim is off." (your choice).
- The default message style is a small corner notification, not a pop-up box.

## Requirements

These are the only hard requirements. The scenarios themselves use vanilla Skyrim locations and events. You do not need ODangerous Nights or a stack of other danger / environment mods — this does the same thing, and so much more.

### Game versions

This mod is **not locked to Skyrim SE 1.5.97**. The plugin is a normal ESL with only `Skyrim.esm` as a master, the scripts are standard Skyrim Papyrus, and there is no SKSE .dll of ours, so nothing in this download is tied to one game executable.

It should run on **Skyrim Special Edition and Anniversary Edition (1.6.x)**, including GOG builds, as long as that setup has matching versions of the requirements below. Use the SKSE64 and Papyrus Extender builds that match your game executable. It was built against SE 1.5.97; AE reports are welcome. It will not work on Skyrim Legendary Edition (Oldrim) or Skyrim VR.

- Skyrim SE or AE + SKSE64
- OStim Standalone (7.5.x, API 7.1+)
- SkyUI (MCM)
- powerofthree's Papyrus Extender (the build that matches your game version)

## Optional (auto-detected, never required, never masters)

- **SkyrimNet** (recommended): start narration, memories, rumours, blackmail, named places (beta 29+), and "would this character do it?" checks against their bio (beta 28+, needs a SkyrimNet decisions provider). Without SkyrimNet the engine still runs, using a built-in character filter instead of bios.
- **OCreatures** + creature scene packs: unlocks the Creatures page, including the 1.0 wild creature road events. Locked off without it.
- **OStim Beast Form** (1.0, tested against 0.8, either the Growl or the TWO edition): unlocks the Beast Form page (werewolves at night, choices when you transform). O'Deadly checks for the plugin and for Beast Form's own start scenes; without them the page is locked. None of its files are included.
- **Saturalia Holiday Pack** (1.0, Creation Club `ccvsvsse001-winter.esl`): unlocks the Saturalia countdown and Agrane Peryval's gifts.
- **Growl - Werebeasts of Skyrim** (1.0): followers infected with lycanthropy by Blood Born Pathogen get Growl's own follower beastblood. 1.1.5: Growl's werebear totem decides whether Growl's fight changes make them werewolves or werebears; O'Deadly still does SkyrimNet changes and the body. Detection of a werewolf / vampire player also works with vanilla and Sacrosanct.
- **OCum**: messier memories.
- **ZaZ Animation Pack**: jail scenes prefer restraint scenes; made-to-watch narration.
- **OStimNet / OStim Navigator**: better scene tags.
- **NPC AI Position Fix**: works with it from 0.7. Sleep events begin as you wake, after the sleep has finished, so nothing is moved or spawned while that mod is tracking the rest. (0.6 and earlier could crash on the next save after a sleep event.)
- **ODangerousNights**: not needed. This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223), but I never downloaded it, so I have no idea if they are compatible. This already does the same thing, and so much more.
- **iActions** (0.2): its alcohol list (including its `extra_alcohol.json`) is used to count your drinks, and NPCs it marks as drunk, plastered or blacked out are preferred for the morning after. Without it, vanilla and DLC drinks are recognised.
- **Dirt and Blood** or **Bathing in Skyrim** (0.2): needed for the Bathing module. Only a real wash counts, never swimming or rain. With both installed, one wash still gives one roll.
- **Blood and OStim** (0.2): the Dark Gift becomes a feeding scene.
- **Sacrosanct** (0.2): the Dark Gift turns you through Sacrosanct's own vampirism. 1.1.5: NPCs turned by Blood Born Pathogen get Sacrosanct's NPC vampire treatment (no Foster Childe message), with an optional race change.
- **JContainers**: only used to read iActions' `extra_alcohol.json` directly.
- **[OStim Kidnapped Redux](https://www.patreon.com/posts/175042213)** (0.3, [Lirael's](https://www.patreon.com/LiraelAtelier) OStim conversion of vinfamy's SexLab Kidnapped Redux): SkyrimNet hears when you are taken, slip an ambush, escape, are let go or are sold. O'Deadly holds its own encounters while you are held.
- **[ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196)** (0.3, by [Lirael](https://www.patreon.com/LiraelAtelier)): SkyrimNet hears when you are defeated and what happens next. A downed player is left to ODefeat Reforged; O'Deadly's Defeat module keeps handling followers.
- **[The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905)** (0.4 / 0.9, by Mihail): unlocks the third Climax fauna option, which can spawn his killer rabbits after a climax, and the 0.9 Killer Rabbit vs Vigilants road event. The unique rabbit in the Cave of Caerbannog is left alone.
- **[Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288)** (0.5, `SexLabDefeat.esp`; OStim conversion by Lauffey, released on [Lirael Atelier's Patreon](https://www.patreon.com/LiraelAtelier); original SexLab Defeat by Goubo, Baka Edition by BakaFactory): SkyrimNet hears when you are beaten and taken, what happens next, companions taken after a lost fight, and NPCs beaten by NPCs. A downed player is left to Baka Defeat; O'Deadly's Defeat module keeps handling followers.
- **Use only one defeat mod.** Baka Defeat and ODefeat Reforged both take over a downed player, so running both can start two scenes at once or leave you stuck on the ground. Pick one, preferably **Baka Defeat**, since it does more (NPC vs NPC, you as the aggressor, robbery, the inn wake-up, followers, creatures). ODefeat Reforged is lighter if you only want player defeat. If O'Deadly finds both, it warns you on screen and on the MCM.

None of these mods' files are included, and none of them is a master of this plugin.

## Install (MO2)

1. Install the zip as a mod and enable `ODeadlySkyrim.esp` (ESL-flagged, master Skyrim.esm only).
2. If you were using an earlier Sleep Ambush test build, **disable it**. This mod already contains those features; running both would roll twice.
3. No Pandora / FNIS run needed. A new game is not required.
4. Load order: it is an ESL with no real conflicts. Place it by hand near the end of your plugins; no LOOT needed. **Nolvus users: do not place this plugin below Paper Maps.**
5. Open the MCM, bind the panic key, then turn the master switch on.

Updating from 0.1: overwrite the old files. Settings carry over; the new modules start OFF. The MCM gains a "More encounters" page (it may take a moment to appear on an existing save).

Files: `ODeadlySkyrim.esp`, `Scripts/*.pex`, `Scripts/Source/*.psc`, `SKSE/Plugins/SkyrimNet/external/coronerra.odeadly/` (SkyrimNet decision template, ignored without SkyrimNet).

## How the engine works

Every module goes through the same steps, one event at a time:

1. Master switch on? Module on? Chance roll hits? Not on cooldown (4 game hours by default)? You are not already in combat or another OStim scene?
2. Pick who is at risk: you and/or nearby adult followers, depending on that module's toggles, the victim gender filter, the protect list and Serana protection.
3. Pick who acts: real nearby people first (guards in a jail, patrons in an inn, the owner of the house, the bandit who just beat you). Spawns only where it fits (road bandits, wilderness creatures). Quest characters (essential / protected unique NPCs) are left alone unless you allow them.
4. With SkyrimNet, peaceful NPCs are checked against their bio: "would this character do this?". Without an answer, a character filter (Morality, how they feel about the victim) decides.
5. OStim must have a suitable installed scene for that exact group. Group scenes fall back to one on one; no scene at all means nothing happens and any spawn is removed.
6. The scene starts, SkyrimNet narrates it, you get a short message.
7. Hit or activate an attacker (or activate a victim) to stop it. Attackers may turn on you; cheating partners do not. Pressing **E** on a victim always counts as a rescue and breaks the scene on purpose. To just talk to someone in a scene, use SkyrimNet's talk / voice input instead; it does not interrupt the scene.
8. Afterwards: spawned actors leave and are cleaned up, a mod event fires (`ODeadlySkyrim_Done(Int kind, Form victim, Form attacker, Bool spawned, Bool intervened, Bool consensual)`), SkyrimNet stores a memory. There are no forgive / confront menus: SkyrimNet and you decide what happens next.

No polling: everything runs from game events (sleep, wait menu, location change, bleedout, OStim events, drink and magic-effect events while the related 0.2 module is on, mod events from the bath mods, the panic key) plus one-shot timers (1.0 Saturalia and Blood Born Pathogen incubation ride the same single game-time timer; infected NPCs only react to their own combat start, death and a Cure Disease potion being added, plus one single update after a fight they changed for (1.1: no timed change back); Agrane's gift walk is one bounded walk per visit. 1.0 Bitch in Heat: the summoned werewolves only react to their own combat, hit and race events, plus one bounded walk-in / walk-away each; 1.0: after you transform into beast form, at most 12 single-update checks about 10 seconds apart, only while the Beast Form choices are on). The only waits are short and bounded (for example, a bath that rolled a hit waits for the wash to finish, at most 150 seconds).

If you have SkyrimNet beta 29 or newer, the MCM "This location" page can use SkyrimNet named places. A tagged place wins over vanilla keywords, so you can mark a rented inn room as a player home, or tag a custom cell as a jail or barracks. Untagged spots fall back to normal Skyrim location keywords and cell names.

## Modules and defaults

| Module | Default | Notes |
|---|---|---|
| Master switch | **OFF** | Nothing runs while off. |
| Night attacks | ON (inside the master) | Followers only unless "Player can be a victim". |
| Cheating spouse | OFF | Consensual scenes only. |
| Caught in the act | OFF | Your spouse / a follower walks in on another mod's OStim scene with you. |
| Follower betrayal | OFF | A follower may take advantage of you asleep, drunk or downed. |
| Imprisonment & barracks | OFF | Every hold. Player OFF, followers ON. |
| Inns: drunk patrons take the player | OFF | |
| Inns: spiked drinks | OFF | Player OFF, followers ON. |
| Defeat | OFF | Player OFF, followers ON. |
| Follower rescue (0.3) | OFF | 50% when a follower goes down mid-fight. Downed follower: Both (or Female / Male). |
| Trespass | OFF | Player OFF, followers ON. |
| Travel & roads | OFF | Robbery; may turn into a scene. Player OFF, followers ON. |
| Savior Complex (0.9) | OFF | Rare wilderness-road event: a bandit is forcefully taking a traveler. Watch, join or rescue. |
| Killer Rabbit vs Vigilants (0.9) | OFF, locked without Mihail's Killer Rabbit | Two Vigilants losing to a Killer Rabbit; you can kill it and save them. |
| Creatures (OCreatures) | OFF, locked without OCreatures | Player OFF even when available. |
| Join in (1.0) | OFF | Walk in on your spouse / a companion in a consensual scene: watch, join in, or stop them. 100% when possible; take over if no three-person scene. |
| Wild creatures (1.0) | OFF, locked without OCreatures | 2% per game hour / wait hour on a wilderness road. Travelers and companions ON, player OFF. Watch or rescue. |
| Werewolves at night (1.0) | OFF, locked without OStim Beast Form | 3% per night hour / wait hour on a wilderness road. Travelers and companions ON, player OFF. Watch or rescue. |
| Beast form choices (1.0) | OFF, locked without OStim Beast Form | 50% per transformation: take a beaten bandit, or claim a willing spouse / companion. |
| Bitch in Heat (1.0) | OFF, locked without OStim Beast Form | 25% per scene between a male in full beast form (werewolf, werebear or vampire lord, 1.1.5) and a human with you in it: 1-3 more join (1.1.6: set in the MCM ahead of time, "How many join", default random 1-3; no in-game box). |
| Blood Born Pathogen (1.0, 1.1) | OFF | Anyone in a scene with a werewolf, vampire lord or werebear: 35% per form in beast form, 10% from a carrier in human form. Followers and spouse only by default (any NPC option); world cap 10; NPC scenes and you catching it ON. 1.1.1: turns at once from a werewolf, werebear or vampire lord; 'Always infect (no chance roll)' OFF; ~3 days incubation only from a human-form vampire (Cure Disease stops it). SkyrimNet beast forms ON. |
| Saturalia (1.0) | OFF, locked without the Saturalia Holiday Pack | Countdown 22-24 Evening Star; on the 25th Agrane Peryval hands out gifts in towns and inns (3 visits). |
| Vampire seduction | OFF | |
| Blackmail / public rumours | OFF | Need SkyrimNet. |
| OCum memories | OFF, locked without OCum | |
| ZaZ restraints | OFF, locked without ZaZ | |
| Group scenes | OFF | 1-3 extra participants (2 by default), so 2-4 attackers. |
| Drunk / skooma modifier | ON | Multiplies chances (x2) only for modules that are already on. |
| Named / essential NPCs | OFF | |
| Morning after (0.2) | OFF | Drink 4+ in 2 game hours, then sleep: 50%. |
| Bathing (0.2) | OFF, locked without Dirt and Blood or Bathing in Skyrim | 15% per wash. Player and followers ON. |
| Inns full: shared room (0.2) | OFF | 4% per hour slept in an inn with your party. |
| Watched from a distance (0.2) | OFF | 25% per outdoor scene, 2 game hour cooldown. |
| Dark Gift (0.2) | OFF | 1% per hour slept. Vampirism ON (unless immune). |
| Climax fauna easter egg (0.2 / 0.4) | OFF | Off, Vanilla rabbits, or Killer Rabbit of Caerbannog if Mihail's mod is detected. 5% per climax, 20 rabbits. Last option in the MCM. |

### Night attacks

- One roll per hour slept (1h+). Optional: waiting counts as sleeping.
- 0.7: the event begins as you wake, once the sleep has finished and the Sleep/Wait menu has closed, not partway through the sleep.
- 8 place categories with separate attack and cheating chances (all can be 0), per-place overrides, and SkyrimNet named places (beta 29+, switches itself off on older SkyrimNet).
- Attackers: real nearby hostiles first, then a spawned bandit, or a creature if the Creatures module is on.
- Guards: "Nearby guards prevent attacks" ON, guard range 3000, guards as attackers OFF, guards as victims OFF, guards as cheating partners ON. In a jail or barracks, guard blocking is skipped when guards may be attackers.
- Cheating spouse: spouse = vanilla marriage, PlayerMarriedFaction, or (optional) Lover-rank followers. Inn "patrons drunk" SkyrimNet event.

Default chances (% per hour slept):

| Category | Attack | Cheating |
|---|---|---|
| Walled-city player home | 0.0 | 1.0 |
| Other player home | 1.0 | 1.0 |
| Inn | 1.5 | 8.0 |
| City / town | 1.0 | 3.0 |
| Settlement | 3.0 | 3.0 |
| Wilderness | 6.0 | 1.0 |
| Camp | 7.0 | 0.5 |
| Dungeon | 7.0 | 0.5 |

Other defaults: creature chance 40%, victim range 2000, scene duration 60-120 s.

### Imprisonment & barracks

- Jails in every hold (`LocTypeJail`, or "Jail" / "Prison" in the location or cell name) and guard barracks (`LocTypeBarracks`, or "Barracks" / "Guard House" / "Guardhouse" / "Garrison" in the name). Tag any custom cell on the MCM "This location" page.
- Rolls when you sleep or wait there (10% per hour) or after you have lingered a while (15% per check, every 0.5 game hours). Never the moment you walk through the door.
- Uses the guards who are already there. Optional: copy a guard who is present to fill a group scene.
- "Pay your bounty with your body" (OFF): this works inside jail only. After a jail scene with you, your bounty in that hold is cleared. Vanilla arrest dialogue is not touched.

### Inns

- Drunk patrons can go after the player (3% per hour slept or waited).
- Spiked drinks (3% per hour). Patrons must be awake adults; SkyrimNet / the character filter decides who would.

### Defeat

- Event-based: when you or a follower enter bleedout. 50% chance the winner takes them. Every hostile nearby calms down until you change location.
- The player only bleeds out if essential. "Keep the player alive for defeat" (OFF) makes you essential while Defeat is on; if no defeat scene happens, you die the normal way.
- Follower rescue (0.3, below) is a separate option: when it is on and starts, the fight goes on instead. When it is off, or does not start, this module works exactly as before.
- With ODefeat Reforged (0.3) or Baka Defeat – OStim Edition (0.5) installed, the player part of this module stands aside, so the two mods never both grab you. Your settings are kept; downed followers are still handled here.

### Trespass

- Sleeping or waiting in a house you do not own: the owner or a resident may find you (8% per hour).

### Travel & roads

- One roll per game hour while outdoors in the wilderness (3%), and per hour waited outdoors (5%).
- A robber takes 25% of your gold into their own pockets (kill them to get it back; it is never deleted). 50% chance it turns into a scene.
- No carriage or fast-travel ambushes.

### Savior Complex (0.9)

- **OFF by default**, behind the master switch and the panic key, adults only. Own toggle and chance (2% per game hour on a wilderness road, and per hour waited outdoors), independent of Travel & roads.
- You come upon a spawned bandit forcefully taking a spawned traveling merchant or traveler (vanilla templates; never a world or quest NPC). It does not fire in interiors, cities or towns, or near a unique essential or protected NPC.
- When it starts, SkyrimNet is told plainly that the bandit is forcefully taking the traveler, so the AI is not left to guess. You then choose: **Watch** (the scene continues; you are not involved), **Join in** (you are added when OStim has a three-person animation; otherwise you stay and watch), or **Rescue** (the scene stops and the bandit turns on you). SkyrimNet is told what you chose. If you save them, the traveler thanks you through SkyrimNet. Pressing E on them, or hitting the bandit, while you were watching also counts as a rescue.
- Spawned actors are cleaned up afterwards.

### Killer Rabbit vs Vigilants of Stendarr (0.9)

- **OFF by default**, behind the master switch and the panic key. Own toggle and chance (2% per game hour / wait hour). Needs [Mihail's The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) (`mihailkillerbunny.esp`); without that plugin the option is locked. None of his files are included, and his plugin is not a master.
- On a wilderness road, two spawned generic Vigilants of Stendarr (vanilla templates only, never Keeper Carcette or other unique Vigilants) are fighting a Killer Rabbit and losing. The rabbit is a vanilla hare reskinned to Mihail's killer-rabbit race, the same method as the climax-fauna option; his unique cave rabbit is never copied or moved. It does not fire in interiors, cities or towns, or near a unique essential or protected NPC.
- You can kill the rabbit. SkyrimNet is told who won. Surviving Vigilants thank you and are embarrassed that a rabbit was beating them. They are knocked unconscious when they are about to lose, not flagged essential, and no essential flags are left on anyone. The panic key wakes anyone who was unconscious and clears the fight.

### Creatures (needs OCreatures)

- Werewolves, draugr, trolls, falmer, spriggans, giants, hagravens. Each type is probed against OStim's library and only used if scenes exist.
- 5% per hour camping outdoors / in camps or dungeons, 1% per game hour in the wild. Real creatures nearby are used first.
- No creature files are included; scenes come from the packs you installed.

### Relationships, vampires, aftermath

- Caught in the act, follower betrayal, vampire seduction (uses a vampire already in the lair, no spawns), blackmail later (one time, via SkyrimNet), public rumours after jail / defeat, OCum memories.
- Failed pickpocket and tavern brawl escalation are **not included** (no clean hook); the MCM shows them as locked.

## New in 0.2 (MCM page "More encounters", inn rooms on "Jail & inns")

Every one of these is **OFF by default**, needs the master switch, is stopped by the panic key, and never involves children. Plugin names, form IDs and mod events for the optional integrations are in [AI_CONTEXT.md](AI_CONTEXT.md).

### Morning after

- The mod counts your own drinks. With **iActions** it uses iActions' alcohol list (plus its `extra_alcohol.json`); without it, vanilla, Hearthfire and Dragonborn drinks are recognised.
- More than 3 drinks (4 by default) within 2 game hours, then a sleep later on (within 12 hours): 50% chance you wake up in a random bed nearby with someone, mid-encounter.
- Who: people iActions marks as plastered or blacked out first, then anyone drunk, then any suitable adult nearby. If nobody fits, a stranger (optional).

### Bathing

- Needs **Dirt and Blood** or **Bathing in Skyrim** (either or both). Rolls once when a real wash starts, for you or a follower. Swimming and rain never count.
- The scene starts after the wash is done (0.7: up to 150 seconds, however long the bath animation is), so the bath mod can finish its own animation and redress first. Nobody still in a bath is picked as the partner.
- Who: someone already bathing with you, then your companions, then strangers who would (bio / character check), then an optional stranger.

### Inns full: shared room

- Sleeping in an inn with at least one follower: the party shares one room. 4% per hour slept for an encounter between you and a follower, or between two followers (both on by default). Uses a bed in the room when one is free.
- Separate from the 0.1 drunk patron and spiked drink options, which work as before.

### Watched from a distance

- During any outdoor OStim scene with you or a follower: 25% that a hunter or traveller sees it from a distance (a real person nearby first; optionally a passing hunter).
- SkyrimNet is told where they are (direction and distance), who they saw and what was going on. The watcher then leaves, calls out, or comes closer.

### Dark Gift

- While you sleep (1% per hour), a vampire wakes you with a love scene. A vampire already nearby is used first.
- With **Blood and OStim** it is a feeding scene.
- Afterwards: if you are immune to disease (or already a vampire), nothing infectious happens. Otherwise you contract vampirism, through **Sacrosanct** when it is installed, or the vanilla Sanguinare Vampiris disease when it is not. The vampirism part has its own toggle.

### Climax fauna (easter egg)

- The very last option in the MCM, now a three-way menu: **Off** (default), **Vanilla rabbits**, or **Killer Rabbit of Caerbannog**. 5% after your climax: twenty of them appear in a ring around you, glare, and charge once the scene is over, while a cloud of butterflies swirls around you. Everything vanishes again a minute later. It is exactly as silly as it sounds.
- The third option needs [Mihail's The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) (`mihailkillerbunny.esp`). Without that plugin it is locked and labelled "not installed". None of his files are included, and his plugin is not a master. The unique rabbit in the Cave of Caerbannog is never moved or copied; the burst uses vanilla hares reskinned to his killer-rabbit race. If the race cannot be found, it falls back to vanilla rabbits.

## New in 1.1.5 (Bitch in Heat for every beast, Growl and Sacrosanct)

Only **OStim Beast Form** is needed. **Growl** and **Sacrosanct** are detected and used when present, never required; the log's startup block says whether each was found.

### Bitch in Heat
- **Trigger:** one of the two actors in an OStim scene with you is a male in **full beast form**: werewolf, werebear or vampire lord. A werewolf or vampire in human form does not count. Wilderness only, adults only, you in the scene. The human at the centre is female, or male when Werewolf and Vampire Lord OStim's male partner scenes are installed.
- **Werewolves:** 1-3 more join one group scene. New from Werewolf and Vampire Lord OStim 0.3.1: the three-actor Billyy scenes Dog Spit, Hang 2 and Stand Spit (and their male-centre versions, plus Hold DP M). The older scenes are still used; OCreatures is the last resort.
- **Werebears** (Dragonborn's werebears): with Beast Form's "werebears use werewolf scenes" on, they join the werewolf group scenes and packs can be mixed (werewolves and werebears together). With it off they take turns in pair scenes.
- **Vampire lords** (Dawnguard): there are no group scenes for them, so they take turns in Werewolf and Vampire Lord OStim's vampire lord pair scenes. They never share a scene with werewolves.
- The newcomers arrive already changed, are never hostile and don't run timers. When it's over they walk away and vanish out of sight. When they take turns, each one waits his turn nearby. SkyrimNet is told plainly what came and what happened.
- The how-many box now reads "Others of their kind are answering" (text only; same record and FormID). 1.1.6: the box is no longer shown at all.

### Growl
- Followers who get Growl's beastblood change in fights the way Growl decides: a werebear with Growl's werebear totem, otherwise a werewolf (Circle members always werewolves). O'Deadly still makes the SkyrimNet changes (in the beast they caught) and swaps in the beast body for everyone. Without Growl, O'Deadly owns the werewolf and werebear fight changes. Every decision is logged.

### Sacrosanct
- An NPC turned into a vampire always gets the vampire faction, NPC sun damage and VampireVampirism. With Sacrosanct installed they also get its NPC treatment (resistances, poison resistance, a drain that grows with level), without the Foster Childe message.
- **"Sacrosanct: turned vampires get its vampire race"** (MCM > More encounters > Blood Born Pathogen, OFF by default): also changes them to Sacrosanct's matching vampire race. This is skipped (and logged) if the NPC's own skin has no body for that race. "Cure everyone" takes all of it back.

### Existing vampire followers as vampire lords
- **"Existing vampire followers can become Vampire Lords"** (same page, OFF by default, needs Dawnguard and SkyrimNet). Followers who already are vampires (Serana and others) can change into a vampire lord when you ask or when it fits, using SkyrimNet's new **BecomeVampireLord** action, and back with **TransformBack**. A follower with their own body skin wears the vampire lord skin while changed. The panic key and master switch change them back.

Updating from 1.1.4: overwrite the old files. In-place and save-safe. The plugin keeps all records and FormIDs; only the text of the Bitch in Heat message box changed.

## New in 1.1 (Blood Born Pathogen for everyone, beast forms through SkyrimNet, blood gift)

Blood Born Pathogen (MCM > More encounters, still **OFF by default**) now works for everyone in an OStim scene, not only for your partners.

- **Anyone can catch it.** When an OStim scene ends and someone in it is a werewolf, a vampire lord or a werebear (or a werewolf / vampire in human form: you, an NPC this mod turned, a Circle member, a vampire), the others may catch it: your partners, **you**, and NPCs in scenes of their own (OStimNet and other mods; "NPC scenes without you spread it too", ON by default). Each person rolls once, against the strongest carrier in the scene.
- **Chance per form:** werewolf in beast form, vampire lord, werebear (35% each by default), and one chance for a carrier in human form (10%).
- **World cap**, default **10** (MCM slider, 1-10), checked first: with the cap reached, scenes are not even tracked (only you can still catch it).
- **Immune:** anyone already a werewolf, vampire or vampire lord (Serana, Harkon, the Companions' Circle, Volkihar, Dawnguard, the werewolf and vampire factions, Growl beastblood holders), anyone in beast form, and anyone already infected. **Children are always refused.** The followers / spouse only switch, essential and Protected followers rules work as before.
- **You can catch it** ("You can catch it from a partner", ON by default): 1.1.1: from a werewolf or werebear you turn at once and get the vanilla Beast Form power (with Growl, pick the werebear path in Growl); from a vampire lord you become a vampire at once (VampireChange, Sacrosanct-aware) with the Vampire Lord power; from a vampire in human form you get the vanilla Sanguinare Vampiris.
- **Werebears:** infected NPCs can carry werebear blood (Dragonborn's werebear race; Growl's werebears count). Turned werebears change into a werebear in night fights like werewolves.
- **SkyrimNet beast forms** ("SkyrimNet: turned NPCs change at will", ON by default): NPCs this mod turned know what they are, who gave it to them and whether they are in beast form right now. Two SkyrimNet actions: **TransformToBeast** (werewolf, vampire lord or werebear, whatever their blood is) when you ask or when it fits, and **TransformBack** when asked. There is **no timer**: an NPC who changed because you asked (or because they chose to) stays changed until they change back. An NPC who changed for a fight changes back once the fight is over.
- **Blood gift (no roll):** through SkyrimNet, an NPC can accept your blood gift (**AcceptBloodGift**) when you offer it, and an NPC this mod turned can give you theirs (**GiveBloodGift**) when you ask. Or bind the new **Blood gift key**, look at an adult NPC and press it: a yes / no box asks. They turn at once; with Growl, a werewolf gift uses Growl's companion beastblood. The world cap and every immunity still apply. Never children.
- **Scene choice:** O'Deadly's own beast scenes now prefer OStim Beast Form 1.0's `OBF*Idle*` start scenes (male werewolf or vampire lord with a woman, two female werewolves) and only fall back to OCreatures' `OCr*Idle*` scenes.
- Event-driven as before: one check when an OStim scene starts and ends, the infected NPCs' own combat events, one single update after a fight they changed for. No polling.
- New record: one message box (`ODS_BloodGiftChoice`, 0x82D). Existing FormIDs unchanged. MCM `GetVersion` 14. New settings at the end of `ODS_Main`. SkyrimNet pack `coronerra.odeadly` 1.1.0 (new actions and a character bio section; needs PapyrusUtil, which the mod already uses).

Updating from 1.0.2: overwrite the old files (in-place, save-safe). NPCs infected under 1.0.x keep their state and get the SkyrimNet context on the next load. The world cap you set before is kept (new installs start at 10).

## New in 1.0.2 (Blood Born Pathogen diagnostics)

- **The debug force tells you why.** "Blood Born Pathogen (next scene)" (MCM > Debug) only skips the chance roll. If a partner fails an eligibility check, they are not infected, the force stays armed, and the reason is now shown on screen even without Debug notifications.
- **Last result** on MCM > Debug: whether the force is armed, the last pathogen result (tracked scene, reason, roll, infection) and who is infected.
- **Own log file:** every O'Deadly log line also goes to `Data/SKSE/Plugins/ODeadlySkyrim.log` (with MO2: the overwrite folder), with a timestamp. Needs PapyrusUtil. Toggle: MCM > Debug > "Write ODeadlySkyrim.log" (ON by default).
- **More log lines:** scenes that are not tracked (and why), and the cases where an infection could not be stored (no free slot, missing quest or alias) are now logged instead of failing silently.
- **Timer fix:** the game-time timer is no longer dropped when OStim is not ready; it retries an hour later, and pathogen stages still advance.
- **Clearer MCM text:** infected or turned NPCs look normal; a turned werewolf only changes in a fight at night.
- MCM `GetVersion` 13. The plugin description says v1.0.2 (records and FormIDs unchanged). SkyrimNet pack unchanged.

Updating from 1.0.1: overwrite the old files (in-place, save-safe); settings carry over.

## New in 1.0.1 (Blood Born Pathogen fix)

- **Why not?** The Papyrus log now says why a partner could not be infected (for example: on the Protected followers list, not detected as a follower or spouse, already a werewolf or vampire, limit reached), each chance roll, and when you have no lycanthropy or vampirism it can find. With Debug notifications on (MCM > Debug) you also see these on screen.
- **"Tell me when someone is infected"** (MCM > More encounters, **ON by default**): a short on-screen note when a partner catches it from you.
- **Essential followers and spouses can catch it.** Being essential no longer blocks your own followers or your spouse (sex never kills anyone). Other essential NPCs are still never infected.
- **"Protected followers / spouse can still catch it"** (**OFF by default**): with it on, your own followers and spouse on the Protected followers page can catch it from you, and stay protected from everything else.
- MCM `GetVersion` 12 (the pages rebuild). Scripts only: plugin, records and FormIDs unchanged, and the SkyrimNet pack is unchanged.

Updating from 1.0: overwrite the old files (in-place, save-safe); settings carry over and the two new options start at their defaults.

## New in 1.0 (join in, wild creatures, OStim Beast Form)

Three new modules. Each one is **OFF by default**, has its own MCM toggles and chance slider, needs the master switch, is stopped by the panic key, and never involves children in any role. OCreatures and OStim Beast Form are detected at runtime; neither is a master and none of their files are included.

### Join in (MCM > Relationships)

- When one of this mod's consensual scenes involves your spouse or a companion and someone else (cheating spouse, shared inn room, bathing), and you are not in it, you get a choice: **Watch**, **Join in**, or **Stop them**.
- Joining ends the two-person scene and starts a three-person scene with you, your spouse / companion and their partner, if OStim has one for that group. If not, you **take over** instead: their partner steps aside and you take their place (toggle; off means you just keep watching).
- Never offered for forced scenes, and never for creature scenes.
- SkyrimNet is told plainly that you walked in on them and joined, or pushed the other person aside.

### Wild creatures (MCM > Creatures, needs OCreatures)

- A rare wilderness-road event: a creature is forcefully taking a spawned traveler, your spouse / a companion (your spouse first when nearby), or you. Each victim type has its own toggle (player OFF by default).
- When it is not you, you choose **Watch** or **Rescue**. Rescuing breaks the scene and the creature turns on you; SkyrimNet is told whether you saved them or watched.
- Only creature types with installed OStim scenes are used (the same probe as the Creatures page), never draugr or falmer outdoors. With OStim Beast Form installed, werewolves are left to the Beast Form page.
- Uses the existing travel timer, only fires in the wilderness away from towns, interiors and unique essential or protected NPCs. Spawns are cleaned up afterwards.

### OStim Beast Form (MCM > Beast Form)

- **Werewolves at night:** between 20:00 and 05:00 on a wilderness road, a werewolf in full beast form may be aggressively taking a spawned traveler, your spouse / a companion, or you (player OFF by default). Watch or rescue, as above. Not while you are in beast form yourself.
- **When you transform:** a short while after you turn into a werewolf or vampire lord (at most one offer per transformation), you may be offered to **take a beaten bandit** (a hostile adult nearby who is down or badly hurt; in werewolf form in the wilderness, a bandit who ambushed you if nobody is around) or to **claim your spouse or a willing companion**. Claiming is consensual: your spouse is always willing; a companion is asked through SkyrimNet's decision model from their bio when available, otherwise their relationship with you decides.
- Scenes start through OStim on Beast Form's own start scenes, so Beast Form's menu takes it from there. If the plugin or its start scenes are missing, none of these options appear.
- No join-in for any beast or creature scene.

### Bitch in Heat (MCM > Beast Form)

- **OFF by default**, own toggle and chance (25% per eligible scene), behind the master switch and the panic key. Adults only.
- When an OStim scene with you starts between a male werewolf in beast form and a human (either of you can be the werewolf), outdoors and away from towns, the howls and the scent can draw other werewolves in the area to join. SkyrimNet is told plainly what drew them and what happens.
- You choose how many come in the MCM ahead of time (1.1.6: "How many join": 1, 2, 3 or 0 = random 1-3, the default). Nothing pops up in game, so OStim's own menu is the only one at the start of the scene. If the chosen count has no installed scene for that cast, the nearest count that has one is used (logged). Counts are checked against the installed scenes: Beast Form's multi-werewolf scenes and Werewolf and Vampire Lord OStim's two-, three- and four-werewolf scenes (female and male human versions). The human is always the centre; if your partner is not human (for example two werewolves), nothing is offered.
- The newcomers are always in werewolf beast form (checked before they are used and again before the scene starts; otherwise the event is skipped). They are never hostile: they arrive from out of sight, walk in, the current scene ends and a bigger one starts with the same human, and afterwards they walk away and vanish once out of sight. They never attack you, your followers or anyone else before, during or after.

### Blood Born Pathogen (MCM > More encounters)

- **OFF by default**, own toggle and two chance sliders (10% per partner per scene, 35% while you are in werewolf or vampire lord form). Master switch and panic key apply. Adults only.
- If you are a werewolf or a vampire (vanilla, Growl or Sacrosanct) and finish an OStim scene with an adult human partner, you can pass it on. By default only your followers and your spouse can catch it; an option allows any eligible NPC, with a cap (5 by default, at most 10).
- Never children, essential NPCs who are not your follower or spouse, protected NPCs (including the MCM protected list, unless you turn on "Protected followers / spouse can still catch it", 1.0.1), the Companions' Circle, the Volkihar clan or the Dawnguard, or anyone who already is a werewolf or vampire.
- 1.1.1: from a werewolf, werebear or vampire lord they turn at once when the scene ends (no incubation). From a vampire in human form: about 3 game days of incubation with symptom updates. A potion of Cure Disease, given to them (or already in their pack when the next update comes), stops it during that time.
- **Lycanthropy:** they become a werewolf. In a fight at night they can turn into a werewolf in full beast form (Beast Form's body if you use it) for about 30 seconds, then change back, with a 90 second cooldown. Never while sitting, sleeping or riding, and anyone still changed is turned back on load and by the panic key. With Growl installed, a follower gets Growl's own beastblood instead and Growl handles their changes. Growl still makes its own fight changes; 1.1.4: SkyrimNet `TransformToBeast` / `TransformBack` work for those followers too, and whichever mod changes them, O'Deadly swaps in the beast body.
- **Vampirism:** no race change. They join the vampire faction and the sun burns them.
- SkyrimNet is told plainly at every step (infection, symptoms, turning, first change) that you, by name, passed it to them through sex, and it becomes part of their memories and bio, so they can bring it up with you.
- MCM: a list of who is infected, and a button to cure everyone this mod infected. From 1.0.1: an on-screen notice when someone is infected (on by default), and the reason in the Papyrus log when someone could not be.

### Saturalia (MCM > More encounters, needs the Saturalia Holiday Pack)

- **OFF by default**, locked without the Creation Club Saturalia Holiday Pack (`ccvsvsse001-winter.esl`). Not a master; none of its files are included.
- 22, 23 and 24 Evening Star: once a day, SkyrimNet hears that Saturalia is 3, 2, then 1 day away (and on the 25th, that it is Saturalia).
- 25 Evening Star, 08:00-21:00: a few times (3 by default) when you are out of combat in a town, city, settlement, inn or shop, Agrane Peryval, the merchant from the camp north of Windward Ruins, comes from just out of sight and hands 1-3 adults nearby a small gift (a sweetroll, mead, a gem or a Saturalia hat). SkyrimNet is told, so they can react.
- At midnight (or on the next load after the 25th) he goes back to his camp. Works every year. Never during combat, never into jails, dungeons, castles or homes.
- Uses the same timer the mod already has; nothing polls.

Updating from 0.9: overwrite the old files; settings carry over. Existing plugin records and FormIDs are unchanged; 1.0 only adds new records (message boxes, the Bitch in Heat faction, list, switches and helper quest, and two helper quests for Saturalia and Blood Born Pathogen). All new options stay off until you turn them on. MCM `GetVersion` 11 (the pages rebuild, and a new "Beast Form" page appears). SkyrimNet pack 1.0.0 adds a second decision template (`would_consent`).

## New in 0.9 (Savior Complex and Killer Rabbit vs Vigilants)

Two new wilderness-road events, each with its own MCM toggle (**OFF by default**) and chance slider. They share the existing travel timer (one roll per game hour outdoors, plus waiting). Master switch, panic key and the no-children rule apply. They never use world or quest NPCs, never fire in interiors or towns, and never start next to a unique essential or protected NPC.

- **Savior Complex** (MCM > Danger): a bandit is forcefully taking a traveler. SkyrimNet is told that in plain words when it starts, then you choose to watch, join in, or rescue them, and SkyrimNet is told what you chose. A successful rescue gets a thanks through SkyrimNet.
- **Killer Rabbit vs Vigilants of Stendarr** (MCM > Danger): needs Mihail's Killer Rabbit of Caerbannog (locked without it; none of his files are included). Two Vigilants are losing to the rabbit; you can kill it and save them. SkyrimNet is told who won. No essential flags are left behind.
- Debug tools can force either event now if you are already on a wilderness road, or queue it for the next travel hour / wait.
- Updating from 0.8 or 0.7: overwrite the old files; settings carry over. Existing plugin records and FormIDs are unchanged (0.9 only adds `ODS_PoolTraveler`, `ODS_PoolVigilant`, and `ODS_SaviorChoice`). The two new options stay off until you turn them on. 0.8's furniture fix is included.

## New in 0.8 (nobody stays in bed pose)

- **Fixed:** an NPC who was lying in a bed (for example a partner sleeping next to you), sitting, or asleep could stay in that pose while the scene played around them. Before any scene starts, every NPC in it who is in a bed, bedroll or chair, or asleep, is now taken out of it first. O'Deadly waits up to about 4 seconds for them to get up, then the scene starts. Bed scenes still use the bed: OStim places everyone on it.
- **Not changed, on purpose:** pressing **E** (activate) on a victim during a scene still counts as you trying to save them and breaks the scene, and the attackers may turn on you. To talk to someone in a scene without interrupting it, use SkyrimNet's talk / voice input.
- Nothing else changes: same plugin records and FormIDs (only its description now reads v0.8), same settings and defaults, master switch still OFF. SkyrimNet pack version 0.8.0.
- Updating from 0.7: overwrite the old files; settings carry over.

## New in 0.7 (sleep events and bath timing)

- **Fixed: crash on save with NPC AI Position Fix.** That mod tracks every NPC that is moved or loaded in while you sleep or wait, and repositions them when the rest ends. 0.6 woke you and spawned its sleep-event characters while the sleep was still running, so they ended up on that mod's list and were later removed, which could crash the game on the next save.
- Sleep events now begin as you wake. The roll still happens when you lie down, with the same chances as before, but nothing is moved, spawned or started until the sleep has finished and the Sleep/Wait menu has closed, plus a one-second pause so other mods can finish their own after-rest work. The morning after already worked this way and now waits for the menu too. Wait events also pause a second after the menu closes.
- If something else cuts your sleep short (another mod's event, an attack), the event rolled for that sleep is dropped.
- Loading a save, the panic key or turning the master switch off clears any sleep event that has not started yet.
- **Fixed:** a Bathing scene could start before a long bath had finished. Vanilla Dirt and Blood ends its wash about 25 seconds after the lather, but with [Malignis Animations - BiSR DnB Patch](https://www.nexusmods.com/skyrimspecialedition/mods/166293) a woman's bath runs about 65 seconds (58 s wash, about 6 s drying, then the redress). 0.6 stopped waiting after 60 seconds, so the scene could start while the bath mod was still drying and re-dressing her, and clothes or controls could come back in the middle of the scene.
- One path now covers every bath mod and animation: O'Deadly waits until the actor has really left the bath (Dirt and Blood's bathing list, or Bathing in Skyrim's bathing effect / finish event), up to 150 seconds, then pauses 2.5 seconds so clothes and controls are restored, then stages the scene. If the actor is somehow still bathing after 150 seconds, no scene is started for that wash.
- Someone who is still inside a running bath is never picked as the partner.
- Nothing else changes: same plugin records and FormIDs (only its description now reads v0.7), same settings, defaults and master switch (OFF), and the same kill switch, panic key and adults-only rules. SkyrimNet pack version 0.7.0.
- Updating from 0.6: overwrite the old files; settings carry over.

## New in 0.6 (bug fix: scenes never started)

- **Fixed:** on first load the main script could stop at its first startup step (Papyrus log: "Cannot cast from None to Form[]" in `ODS_Main.InitArrays`). After that no encounter could start ("Cannot access an element of a None array", "Mismatched types assigning to variable named acts", "trespass: no resident with a scene").
- The protected-NPC list is stored under a new name, startup creates the lists scenes need before the MCM lists, and scene actor lists no longer depend on OStim's `OActorUtil.CreateArray`. Scene choice, defaults and every safety rule are unchanged.
- Updating from 0.5: overwrite the old files; settings carry over, except the protected-NPC list (MCM > Protected followers), which must be set again.

## New in 0.5 (Baka Defeat – OStim Edition support)

A new SkyrimNet listener for [Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288) (plugin `SexLabDefeat.esp`; OStim conversion by Lauffey, released on [Lirael Atelier's Patreon](https://www.patreon.com/LiraelAtelier); original SexLab Defeat by Goubo, Baka Edition by BakaFactory). Like the 0.3 listeners, O'Deadly does not start, stop or change anything in Baka Defeat: it listens to Baka's own mod events and tells SkyrimNet what happened. Toggle: MCM > General > SkyrimNet > "Baka Defeat events" (ON, locked when the mod is missing). It also follows "Narration when it starts" and "Memory afterwards". With the master switch off or after the panic key, nothing is sent. Adults only: a scene with a child in it is never narrated.

- **Beaten and taken**: when the first Baka scene with you as the victim starts, narration says who beat you, where, and that they force themselves on you. Later turns get a short line. A memory is written once the first scene ends.
- **Afterwards**: waking up in an inn bed, being left for dead, being robbed, or getting away: narration and a memory each.
- **Companions**: a follower taken after a lost fight (Baka's collateral scenes): narration and a memory with both names.
- **NPC vs NPC**: an NPC beaten and taken by another NPC near you: narration and a memory.
- **You on top**: when you use Baka's own actions on a beaten NPC: narration and a memory.
- Consensual, paid and corpse scenes from Baka Defeat are not narrated.
- A downed player is left to Baka Defeat; O'Deadly's Defeat module still handles your followers. While Baka Defeat has you, O'Deadly does not start its own encounters.
- **Both defeat mods installed**: once per game load you get a notification, and the first time on a save a message box: *"O'Deadly Skyrim: Both ODefeat Reforged and Baka Defeat (OStim Edition) were detected. For stability use only one, preferably Baka Defeat since it does more."* MCM > General > Installed mods shows the same advice. O'Deadly still stands aside for a downed player and does not narrate the same defeat twice.
- Updating from 0.4: overwrite the old files; settings carry over.

## New in 0.4 (Killer Rabbit of Caerbannog climax fauna option)

MCM > More encounters > Climax fauna. Still **Off by default**, behind the master switch and the panic key.

- The old on/off toggle is now Off / Vanilla rabbits / Killer Rabbit of Caerbannog. Chance and rabbit-count sliders are unchanged, and only apply when the option is not Off.
- If you already had the easter egg on, it becomes Vanilla rabbits. The third choice stays locked until `mihailkillerbunny.esp` is loaded.
- Updating from 0.3: overwrite the old files; other settings carry over.

## New in 0.3 (follower rescue, SkyrimNet messages for OStim Kidnapped Redux and ODefeat Reforged)

### Follower rescue (mid-battle)

MCM > Danger > "Follower rescue (mid-battle)". **OFF by default**, behind the master switch and the panic key, adults only.

- When a follower goes down (bleedout) in a fight while you are still standing, there is a chance (50% by default) that one nearby enemy starts taking them right there. Only that enemy and that follower stop fighting; the rest of the fight goes on around you.
- "Downed follower": Both (default), Female or Male. This only applies to this option; the victim gender on the General page is not changed.
- Rescue them: hit that enemy (or kill them). The scene stops, your follower gets back up with some health, and the enemy goes back to fighting you.
- If the scene ends before you get there, both are released the same way and the enemy turns back to the fight.
- Protected followers (Protected followers page) are never picked. Creatures only take part through the Creatures module, guards only with "guards can be attackers", named NPCs as attackers only with the named-NPC option.
- At most one rescue at a time and one per game hour. While one runs, another follower who goes down just bleeds out as usual, and O'Deadly's other encounters wait.
- It does not need the Defeat module. With Defeat on, a downed follower goes to the rescue first; if the rescue does not start (chance, no enemy with a matching scene), Defeat works as before and ends the fight.
- SkyrimNet: narration when it starts; a memory of whether you pulled them away or did not get there in time.

### SkyrimNet listeners

Two listeners, not new encounter modules: O'Deadly does not start, stop or change anything in those mods. It listens to their public mod events and tells SkyrimNet what happened, using your name and the place. Each has a toggle on MCM > General > SkyrimNet (ON, locked when the mod is missing) and also follows "Narration when it starts" and "Memory afterwards". With the master switch off or after the panic key, nothing is sent. Adults only, as everywhere in this mod.

#### [OStim Kidnapped Redux](https://www.patreon.com/posts/175042213) (Lirael)

- Taken (its own ambush, or handed over by another mod): narration and a memory of being dragged off to the hideout, near where it happened.
- Slipped the ambush: one line of narration.
- Escaped, let go exhausted, or sold into slavery: narration and a memory of how it ended.
- While you are held, O'Deadly does not start its own encounters.
- Kidnapped Redux only knows to leave its night rolls to ODangerousNights, so with both O'Deadly's night attacks and Kidnapped Redux on, either one can still happen at night.

#### [ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196) (Lirael)

- Defeated: narration that you are at the mercy of whoever won, by name when the scene shows who.
- Escaped (you won the struggle), robbed, left where you fell, arrested by a guard, sold into slavery, or executed: narration, plus a memory (except for execution, which reloads your last save).
- A downed player is left to ODefeat Reforged; O'Deadly's Defeat module still handles your followers.

## MCM pages

General (master switch, panic key, installed mods, scenes, SkyrimNet, modifiers) — Night attacks — Relationships (now with Join in) — Jail & inns (now with the shared room option) — Danger (now with follower rescue, Savior Complex, and Killer Rabbit vs Vigilants) — Creatures (now with wild creatures) — Beast Form (1.0) — More encounters (morning after, bathing, watched, Dark Gift, and the climax fauna easter egg at the very bottom) — This location — Protected followers — Debug.

## Test checklist

1. MCM > General: bind the Panic key, then turn the master switch on.
2. MCM > Debug: enable debug tools and debug notifications.
3. Stand near an adult follower, press "Night attack", sleep 2 hours. A scene should start.
4. Press the panic key during the scene: it must stop at once, spawns vanish, the mod switches off (MCM shows the master OFF).
5. Turn the master back on and try other force buttons (jail needs a jail and a guard; cheating needs your spouse nearby; road robbery: wait 1h outdoors).
6. 0.2 force buttons (turn the module on first): morning after (next sleep), bathing (next real wash), shared room (sleep in an inn with a follower), Dark Gift (next sleep), watched (next outdoor scene), climax fauna (next climax).
7. 0.3 / 0.5, with OStim Kidnapped Redux, ODefeat Reforged or Baka Defeat installed: MCM > General shows them as installed. Use their own menus to force a kidnapping or get defeated, then check that SkyrimNet narrates it.
8. Follower rescue: turn it on (Danger page) and set the chance to 100, then let a follower go down in a fight with humans. One enemy should start a scene with them while the others keep fighting; hit that enemy to stop it. Try the panic key during one too.
9. 0.9 Savior Complex: turn it on (Danger page), set the chance to 100 or use Debug > "Savior Complex (now if on a road)" while outdoors in the wilderness, away from towns. Confirm the aggressive narration, the Watch / Join in / Rescue box, each choice (including a successful rescue and the thanks), and that the panic key stops it and removes the spawns.
10. 0.9 Killer Rabbit vs Vigilants: requires Mihail's Killer Rabbit of Caerbannog. Turn the option on, then force it on a wilderness road. Confirm the Vigilants are losing, that you can kill the rabbit, that survivors thank you and sound embarrassed, that SkyrimNet is told who won, and that the panic key clears the fight with no leftover essential flags.
11. 1.0 Join in: turn it on (Relationships page) along with cheating spouse, shared room or bathing, and force one of those with your spouse / a companion nearby. Confirm the Watch / Join in / Stop them box, that joining starts a three-person scene (or a take-over), and the SkyrimNet memory.
12. 1.0 wild creatures (OCreatures) and werewolves at night (OStim Beast Form): turn them on, then use Debug > "Wild creature" / "Werewolf (now if on a road)" on a wilderness road (werewolves need night). Confirm watch, rescue, the narration, and that the panic key removes the spawns.
13. 1.0 beast form choices (OStim Beast Form): turn them on, press Debug > "Beast form choice", then transform (or press it while transformed). Confirm the take / claim box and that the scene opens on Beast Form's start scene.
14. 1.0 Bitch in Heat (OStim Beast Form + multi-werewolf scenes): turn it on, press Debug > "Bitch in Heat", then start a beast-form scene with a human outdoors. Confirm that no box pops up (1.1.6: the count comes from MCM "How many join"), that the newcomers are werewolves in beast form, never hostile, that the bigger scene starts with the same human, that they walk off and vanish afterwards, and that the panic key removes them.
15. 1.0 Blood Born Pathogen: as a werewolf or vampire, turn it on (More encounters), press Debug > "Blood Born Pathogen" and finish a scene with a follower. Wait or sleep through about 3 game days and confirm the symptom narration names you, that a Cure Disease potion given during that time stops it, and (lycanthropy) that they change in a night fight and change back after about 30 seconds.
16. 1.0 Saturalia (Saturalia Holiday Pack): turn it on, stand in a town or inn with adults around and press Debug > "Saturalia gift visit". Agrane should walk up from out of sight and hand out gifts, then be back at his camp a couple of game hours later.
17. Check the Papyrus log for `[ODeadlySkyrim]` lines.

## Troubleshooting / log files

O'Deadly writes its own log, so you do not need to turn on Papyrus logging:

- **Where:** `Data/SKSE/Plugins/ODeadlySkyrim.log`. With MO2 it lands in `overwrite/SKSE/Plugins/ODeadlySkyrim.log` (Vortex / manual: the game's `Data/SKSE/Plugins`).
- **What it records:** a header every game load (version, game time, real date and time on each line); a startup block a few seconds after loading (SKSE, PapyrusUtil, OStim, powerofthree's Papyrus Extender, JContainers, SkyrimNet, OCreatures, OCum, OStim Beast Form and its scenes, Growl, Dirt and Blood, Bathing in Skyrim, the defeat mods and the other optional mods it found, which modules are on, Blood Born Pathogen settings, SkyrimNet settings); then one line per event: rest rolls, each event staged / started / skipped and why, defeat, ambushes, jail, join in, wild creatures, Bitch in Heat, Saturalia, follower rescue, Blood Born Pathogen (tracking, rolls, reasons, infections, changes), SkyrimNet actions (`TransformToBeast`, `TransformBack`, `AcceptBloodGift`, `GiveBloodGift`) and why one was ignored, SkyrimNet narration and memories, panic key.
- **MCM:** O'Deadly Skyrim > Debug > **Write log file** (ON by default). Turn it off and nothing is written.
- **Size:** one line per event, nothing per frame. The file starts over after 10 game loads (a small counter in `SKSE/Plugins/StorageUtilData/ODeadlySkyrim_log.json`), and one game load writes at most 3000 lines.
- **Needs PapyrusUtil** (already required). Without it nothing is written and nothing errors.
- **Bug reports:** attach `ODeadlySkyrim.log`. If the game crashed, copy the log **before** you load again. Every line also goes to `Papyrus.0.log` (tagged `[ODeadlySkyrim]`) when Papyrus logging is on.

## Known limits

- Barracks / jails that share a location with the rest of the town are only caught by sleeping or waiting there, not by lingering (lingering needs a location change).
- Guard detection is `Actor.IsGuard()` plus "Guard" in the name.
- The SkyrimNet bio check needs a decisions provider; otherwise the character filter is used.
- Morning after counts drinks from the moment the module is on; it cannot see drinks from before.
- Bathing in Skyrim's wash-start event only exists for the player; followers are caught through its bathing effect instead.
- The watcher "comes closer" by walking toward the scene; what they say is up to SkyrimNet.
- With Sacrosanct installed, the Dark Gift turns you right away through Sacrosanct instead of the multi-day disease.
- The fauna butterflies are vanilla critters; some may flutter off early.
- Follower rescue needs an OStim scene for the pair that starts while combat is going on around them; how smoothly that plays depends on your OStim setup and animations. A stray hit from another enemy can still land on the follower during the scene (they are kept from dying if they were not already protected).
- Followers are picked up for bleedout events when you change location (or load, or turn an option on), like the Defeat module; someone who joined you in the same area is covered after the next location change.
- OStim Kidnapped Redux does not say who the kidnappers are or whether followers were taken, so its SkyrimNet text names you and the place only.
- ODefeat Reforged's escape is read from its scene tag when the scene ends; third-party ODefeat outcomes other than slavery are not narrated.
- Baka Defeat does not announce the knockdown, the surrender or the struggle itself, so SkyrimNet first hears about a defeat when Baka's first scene with you starts. A defeat that ends without a scene is only told through its outcome (robbed, left for dead, woke up at an inn, got away). Tied-up victims and Baka's third-party post-assault events are not narrated.
- Creature probe spawns a hidden actor for a moment when the Creatures module is enabled and on load; if a type shows "No scenes found" wrongly, stand next to a follower and press Re-check.

- Savior Complex needs an OStim scene for the spawned bandit and traveler. Joining in also needs a three-person scene; without one you stay and watch.
- Join in needs an OStim scene for the three of you (or, for a take-over, for you and your spouse / companion). Without one you keep watching.
- Wild creatures and werewolves need installed scenes for the exact pair; no scene means nothing happens and the spawns are removed. The werewolf is a vanilla werewolf template; if it does not come out in beast form on your setup, the event is skipped.
- Beast form choices appear a few seconds after the transformation, once you are out of combat. Vanilla beast form has a timer; if you change back mid-scene, how that plays is up to OStim Beast Form.
- Bitch in Heat needs a scene for that exact cast (werewolves first, the human last). The walk-in is capped at 25 seconds; after that OStim places everyone. The newcomers walk off after the scene and are removed once out of sight (at the latest after half a game hour).
- Blood Born Pathogen: the werewolf change is a direct race change without a transformation animation, and how armor looks during it depends on your body and Beast Form setup. 1.1.3: an NPC with its own skin gets the beast race's skin while changed and its own skin back afterwards; if a turned NPC still shows only a head, check `ODeadlySkyrim.log` for the `skin:` lines. Vampires get no eye change and no vampire lord form. Followers with Growl use Growl's own beastblood for fight changes (1.1.4: O'Deadly still gives them the beast body and handles SkyrimNet changes). Up to 10 infected NPCs at a time.
- Saturalia: Agrane is placed on the navmesh just out of sight; in small interiors he may appear in the next room. If a fight starts he stops handing out gifts.
- Killer Rabbit vs Vigilants is locked without Mihail's The Killer Rabbit of Caerbannog. The rabbit is as strong as his race makes it; two generic Vigilants are expected to lose without help.

## Repository contents

- `README.md` — these notes (a copy also ships in the zip as `ODeadlySkyrim_README.md`)
- `docs/ODeadly_Skyrim_cover.jpg` — the cover shown at the top of this page
- `CHANGELOG.md` — what changed in each version
- `AI_CONTEXT.md` — engine overview, module kinds, form IDs, events, and how to rebuild
- `LICENSE` — MIT for work by That Guy (Coronerra)
- `src/` — Papyrus source
- `Data/` — `ODeadlySkyrim.esp`, compiled `.pex`, source copy, and the SkyrimNet pack
- `tools/` — Caprica compile script, plugin builder, verifier, and compile-only stubs (the stubs are not in the player zip)
- The installable zip is on the [Releases](https://github.com/Coronerra/ODeadly-Skyrim/releases) page (latest: `ODeadly_Skyrim_1.1.zip`)

## Credits

- That Guy (Coronerra).
- This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223). I never downloaded it, so I have no idea if they are compatible. No ODN files are used; this is not an ODN patch.
- Built on OStim Standalone, SkyUI, powerofthree's Papyrus Extender and SkyrimNet APIs (none of their files are included).
- Optional 0.2 integrations read the public events and forms of iActions, Dirt and Blood, Bathing in Skyrim, Blood and OStim and Sacrosanct. Thanks to their authors; none of their files are included.
- Optional 0.3 listeners for Lirael's [OStim Kidnapped Redux](https://www.patreon.com/posts/175042213) (an OStim conversion of SexLab Kidnapped Redux by vinfamy) and Lirael's [ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196) use only their documented / public mod events. Thanks to [Lirael](https://www.patreon.com/LiraelAtelier) and vinfamy; none of their files are included and neither is a master.
- Optional 0.4 Climax fauna support and the 0.9 Killer Rabbit vs Vigilants road event for Mihail's [The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) use only a runtime check for `mihailkillerbunny.esp` and his killer-rabbit race (vanilla hares are reskinned; his unique cave rabbit is never copied). Thanks to Mihail; none of his files are included, and his plugin is not a master.
- Optional 1.0 support for OCreatures and OStim Beast Form uses only runtime plugin checks and their OStim scene IDs. Thanks to their authors; none of their files are included, and neither is a master.
- Optional 1.0 Saturalia support uses only a runtime check for Bethesda's Creation Club Saturalia Holiday Pack and its merchant's reference; Blood Born Pathogen hands followers to Growl's own follower beastblood ability (by Simon Magus) when Growl is installed. None of their files are included, and neither is a master.
- Optional 0.5 listener for [Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288) uses only its own mod events and a runtime check for `SexLabDefeat.esp`. OStim conversion by Lauffey, released on [Lirael Atelier's Patreon](https://www.patreon.com/LiraelAtelier); original SexLab Defeat by Goubo; Baka Edition by BakaFactory. Thanks to all of them; none of their files are included, and the plugin is not a master.

## Other work

Other open-source mods by the same author live under [github.com/Coronerra](https://github.com/Coronerra).
