![O'Deadly Skyrim](docs/ODeadly_Skyrim_cover.jpg)

# O'Deadly Skyrim (A SkyrimNet environmental mod)

**v0.5**
By **That Guy (Coronerra)**
Skyrim SE / AE · ESL-flagged plugin · Adults only

**[Download v0.5](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.5)** · [Changelog](CHANGELOG.md) · [Earlier v0.4](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.4) · [v0.3](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.3) · [v0.2](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.2) · [v0.1](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.1)

Version 0.5 (`ODeadly_Skyrim_0.5.zip`) adds support for [Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288): O'Deadly detects it, leaves a downed player to it, and tells SkyrimNet what happens. If both Baka Defeat and ODefeat Reforged are installed you get an on-screen warning: use only one, preferably Baka Defeat. See [New in 0.5](#new-in-05-baka-defeat--ostim-edition-support) and the [changelog](CHANGELOG.md).

Feedback welcome: please report issues on [GitHub Issues](https://github.com/Coronerra/ODeadly-Skyrim/issues) with your Papyrus log.

This repository is the full public source and notes: Papyrus scripts, the plugin, the SkyrimNet decision pack, the compile and plugin-builder tools, the [changelog](CHANGELOG.md), and hook-level details in **[AI_CONTEXT.md](AI_CONTEXT.md)** (start there if you are an AI assistant or a modder extending this). License: [MIT for coronerra's work](LICENSE).

---

I really don't care for most of the features of this mod, but I realized I have a superpower. Because of my messed-up past, I can look at things with a clinical, non-judgmental mind. I saw a lot of what was on LoversLab, so I told my agent to try to make a true all-in-one, environmentally adjusting world for SkyrimNet that should work with any system. Instead of hunting for a million different environmental mods, just one big dark one the end user can tweak to their personal preferences or likings. This is what it gave me.

This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223). I never downloaded ODangerous Nights, so I have no idea if it is compatible. ODangerous Nights is not needed — this does the same thing, and so much more. All I could think was: why are all these mods based on the player being a chick and getting assaulted? Where are the followers? Why not the followers? So many of them are hotter. So from there I added on, and on, and on.

Its intent is to make Skyrim as… whatever as the end user wants. It is 100% based on the standard environment — as in Skyrim — not dependent on other environmental mods. Inns, jails, barracks, roads, camps and the wilderness are the ones already in the game. Version 0.2 can also pick up a few popular mods you may already have (iActions, Dirt and Blood, Bathing in Skyrim, Blood and OStim, Sacrosanct) when they are installed, 0.3 tells SkyrimNet what happens in OStim Kidnapped Redux and ODefeat Reforged, 0.4 can use Mihail's Killer Rabbit of Caerbannog for the climax fauna easter egg, and 0.5 does the same for Baka Defeat – OStim Edition, but none of them is required.

If there are any other scenarios you want added that can work without additional mod requirements, I can.

If you like it, just [reply with a thumbs up](https://github.com/Coronerra/ODeadly-Skyrim/issues/1). If enough people like it, I'll upload it as a plugin for SkyrimNet.

---

## Contents

- [What it does](#what-it-does)
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
- **OCreatures** + creature scene packs: unlocks the Creatures page. Locked off without it.
- **OCum**: messier memories.
- **ZaZ Animation Pack**: jail scenes prefer restraint scenes; made-to-watch narration.
- **OStimNet / OStim Navigator**: better scene tags.
- **ODangerousNights**: not needed. This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223), but I never downloaded it, so I have no idea if they are compatible. This already does the same thing, and so much more.
- **iActions** (0.2): its alcohol list (including its `extra_alcohol.json`) is used to count your drinks, and NPCs it marks as drunk, plastered or blacked out are preferred for the morning after. Without it, vanilla and DLC drinks are recognised.
- **Dirt and Blood** or **Bathing in Skyrim** (0.2): needed for the Bathing module. Only a real wash counts, never swimming or rain. With both installed, one wash still gives one roll.
- **Blood and OStim** (0.2): the Dark Gift becomes a feeding scene.
- **Sacrosanct** (0.2): the Dark Gift turns you through Sacrosanct's own vampirism.
- **JContainers**: only used to read iActions' `extra_alcohol.json` directly.
- **[OStim Kidnapped Redux](https://www.patreon.com/posts/175042213)** (0.3, [Lirael's](https://www.patreon.com/LiraelAtelier) OStim conversion of vinfamy's SexLab Kidnapped Redux): SkyrimNet hears when you are taken, slip an ambush, escape, are let go or are sold. O'Deadly holds its own encounters while you are held.
- **[ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196)** (0.3, by [Lirael](https://www.patreon.com/LiraelAtelier)): SkyrimNet hears when you are defeated and what happens next. A downed player is left to ODefeat Reforged; O'Deadly's Defeat module keeps handling followers.
- **[The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905)** (0.4, by Mihail): unlocks the third Climax fauna option, which can spawn his killer rabbits after a climax. The unique rabbit in the Cave of Caerbannog is left alone.
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
7. Hit or activate an attacker (or activate a victim) to stop it. Attackers may turn on you; cheating partners do not.
8. Afterwards: spawned actors leave and are cleaned up, a mod event fires (`ODeadlySkyrim_Done(Int kind, Form victim, Form attacker, Bool spawned, Bool intervened, Bool consensual)`), SkyrimNet stores a memory. There are no forgive / confront menus: SkyrimNet and you decide what happens next.

No polling: everything runs from game events (sleep, wait menu, location change, bleedout, OStim events, drink and magic-effect events while the related 0.2 module is on, mod events from the bath mods, the panic key) plus one-shot timers. The only waits are short and bounded (for example, a bath that rolled a hit waits for the wash to finish, at most a minute).

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
| Creatures (OCreatures) | OFF, locked without OCreatures | Player OFF even when available. |
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
- The scene starts after the wash is done, so the bath mod can finish its own animation first.
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

General (master switch, panic key, installed mods, scenes, SkyrimNet, modifiers) — Night attacks — Relationships — Jail & inns (now with the shared room option) — Danger (now with follower rescue) — Creatures — More encounters (morning after, bathing, watched, Dark Gift, and the climax fauna easter egg at the very bottom) — This location — Protected followers — Debug.

## Test checklist

1. MCM > General: bind the Panic key, then turn the master switch on.
2. MCM > Debug: enable debug tools and debug notifications.
3. Stand near an adult follower, press "Night attack", sleep 2 hours. A scene should start.
4. Press the panic key during the scene: it must stop at once, spawns vanish, the mod switches off (MCM shows the master OFF).
5. Turn the master back on and try other force buttons (jail needs a jail and a guard; cheating needs your spouse nearby; road robbery: wait 1h outdoors).
6. 0.2 force buttons (turn the module on first): morning after (next sleep), bathing (next real wash), shared room (sleep in an inn with a follower), Dark Gift (next sleep), watched (next outdoor scene), climax fauna (next climax).
7. 0.3 / 0.5, with OStim Kidnapped Redux, ODefeat Reforged or Baka Defeat installed: MCM > General shows them as installed. Use their own menus to force a kidnapping or get defeated, then check that SkyrimNet narrates it.
8. Follower rescue: turn it on (Danger page) and set the chance to 100, then let a follower go down in a fight with humans. One enemy should start a scene with them while the others keep fighting; hit that enemy to stop it. Try the panic key during one too.
9. Check the Papyrus log for `[ODeadlySkyrim]` lines.

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

## Repository contents

- `README.md` — these notes (a copy also ships in the zip as `ODeadlySkyrim_README.md`)
- `docs/ODeadly_Skyrim_cover.jpg` — the cover shown at the top of this page
- `CHANGELOG.md` — what changed in each version
- `AI_CONTEXT.md` — engine overview, module kinds, form IDs, events, and how to rebuild
- `LICENSE` — MIT for work by That Guy (Coronerra)
- `src/` — Papyrus source
- `Data/` — `ODeadlySkyrim.esp`, compiled `.pex`, source copy, and the SkyrimNet pack
- `tools/` — Caprica compile script, plugin builder, verifier, and compile-only stubs (the stubs are not in the player zip)
- The installable zip is on the [Releases](https://github.com/Coronerra/ODeadly-Skyrim/releases) page (latest: `ODeadly_Skyrim_0.5.zip`)

## Credits

- That Guy (Coronerra).
- This was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223). I never downloaded it, so I have no idea if they are compatible. No ODN files are used; this is not an ODN patch.
- Built on OStim Standalone, SkyUI, powerofthree's Papyrus Extender and SkyrimNet APIs (none of their files are included).
- Optional 0.2 integrations read the public events and forms of iActions, Dirt and Blood, Bathing in Skyrim, Blood and OStim and Sacrosanct. Thanks to their authors; none of their files are included.
- Optional 0.3 listeners for Lirael's [OStim Kidnapped Redux](https://www.patreon.com/posts/175042213) (an OStim conversion of SexLab Kidnapped Redux by vinfamy) and Lirael's [ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196) use only their documented / public mod events. Thanks to [Lirael](https://www.patreon.com/LiraelAtelier) and vinfamy; none of their files are included and neither is a master.
- Optional 0.4 Climax fauna support for Mihail's [The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) uses only a runtime check for `mihailkillerbunny.esp` and his killer-rabbit race. Thanks to Mihail; none of his files are included, and his plugin is not a master.
- Optional 0.5 listener for [Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288) uses only its own mod events and a runtime check for `SexLabDefeat.esp`. OStim conversion by Lauffey, released on [Lirael Atelier's Patreon](https://www.patreon.com/LiraelAtelier); original SexLab Defeat by Goubo; Baka Edition by BakaFactory. Thanks to all of them; none of their files are included, and the plugin is not a master.

## Other work

Other open-source mods by the same author live under [github.com/Coronerra](https://github.com/Coronerra).
