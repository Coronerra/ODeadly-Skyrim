# O'Deadly Skyrim (A SkyrimNet environmental mod)

**v0.1 — UNTESTED IN GAME**
By **That Guy (Coronerra)**
Skyrim SE / AE · ESL-flagged plugin · Adults only

Download the installable zip from the **[v0.1 release](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.1)**. This repo holds the source: Papyrus scripts, the SkyrimNet decision pack, the plugin builder and the docs. AI assistants: start with **[AI_CONTEXT.md](AI_CONTEXT.md)**. License: [MIT for coronerra's work](LICENSE).

---

I really don't care for most of the features of this mod, but I realized I have a superpower. Because of my messed-up past, I can look at things with a clinical, non-judgmental mind. I saw a lot of what was on LoversLab, so I told my agent to try to make a true all-in-one, environmentally adjusting world for SkyrimNet that should work with any system. Instead of hunting for a million different environmental mods, just one big dark one the end user can tweak to their personal preferences or likings. This is what it gave me.

The original idea came when I saw the description of ODangerous Nights. All I could think was: why are all these mods based on the player being a chick and getting assaulted? Where are the followers? Why not the followers? So many of them are hotter. So from there I added on, and on, and on.

Its intent is to make Skyrim as… whatever as the end user wants. It is 100% based on the standard environment — as in Skyrim — not dependent on other environmental mods. Inns, jails, barracks, roads, camps and the wilderness are the ones already in the game.

If there are any other scenarios you want added that can work without additional mod requirements, I can.

If you like it, just [reply with a thumbs up](https://github.com/Coronerra/ODeadly-Skyrim/issues/1). If enough people like it, I'll upload it as a plugin for SkyrimNet.

---

## What it does

One engine, one download, every feature on its own toggle, all of it behind one master switch. When the moment is right (you sleep, wait, linger in a cell, travel, or get beaten), a roll can start an OStim scene with the people who are actually around you. If SkyrimNet is installed, it can check a character's bio before they act, narrate what happened, and leave memories and rumours behind.

This is not a prison-only pack and not a nights-only pack. Night attacks, jails, inns, defeat, trespass, roads, relationships and optional creatures are all modules of the same engine.

**Adults only.** Children are refused for every role, always. This is not a setting.

**UNTESTED IN GAME.** Scripts were compiled with Caprica and the plugin was built by script and parse-verified only. Expect bugs. Please report them with your Papyrus log (lines start with `[ODeadlySkyrim]`).

## Family-safe master switch (read this first)

- The very first MCM option is the **master switch**. It is **OFF by default**. With it off, nothing in this mod ever happens.
- Bind a **Panic key** right under it (unbound by default so it does not steal one of your keys). One press, at any time:
  - stops any scene this mod started (OStim redresses everyone),
  - removes every actor this mod spawned,
  - gives back any gold a robber just took,
  - stops SkyrimNet's NPCs from talking about it right now,
  - turns the whole mod OFF until you switch it on again.
- Turning the master switch OFF in the MCM does exactly the same.
- After a panic you get either nothing or a plain "O'Deadly Skyrim is off." (your choice).
- The default message style is a small corner notification, not a pop-up box.

## Requirements

These are the only hard requirements. The scenarios themselves use vanilla Skyrim locations and events. You do not need ODangerous Nights or a stack of other danger / environment mods.

- Skyrim SE 1.5.97 (or compatible) + SKSE64
- OStim Standalone (7.5.x, API 7.1+)
- SkyUI (MCM)
- powerofthree's Papyrus Extender

## Optional (auto-detected, never required, never masters)

- **SkyrimNet** (recommended): start narration, memories, rumours, blackmail, named places (beta 29+), and "would this character do it?" checks against their bio (beta 28+, needs a SkyrimNet decisions provider). Without SkyrimNet the engine still runs, using a built-in character filter instead of bios.
- **OCreatures** + creature scene packs: unlocks the Creatures page. Locked off without it.
- **OCum**: messier memories.
- **ZaZ Animation Pack**: jail scenes prefer restraint scenes; made-to-watch narration.
- **OStimNet / OStim Navigator**: better scene tags.
- **ODangerousNights**: soft-compatible; this mod stays out of the way if ODN just ran an attack.

## Install (MO2)

1. Install the zip as a mod and enable `ODeadlySkyrim.esp` (ESL-flagged, master Skyrim.esm only).
2. If you were using an earlier Sleep Ambush test build, **disable it**. This mod already contains those features; running both would roll twice.
3. No Pandora / FNIS run needed. A new game is not required.
4. Load order: it is an ESL with no real conflicts. Place it by hand near the end of your plugins; no LOOT needed. **Nolvus users: do not place this plugin below Paper Maps.**
5. Open the MCM, bind the panic key, then turn the master switch on.

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

No polling: everything runs from game events (sleep, wait menu, location change, bleedout, OStim events, the panic key) plus one-shot timers.

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
- "Pay your bounty with your body" (OFF): in 0.1 this works inside jail only. After a jail scene with you, your bounty in that hold is cleared. Vanilla arrest dialogue is not touched.

### Inns

- Drunk patrons can go after the player (3% per hour slept or waited).
- Spiked drinks (3% per hour). Patrons must be awake adults; SkyrimNet / the character filter decides who would.

### Defeat

- Event-based: when you or a follower enter bleedout. 50% chance the winner takes them. Every hostile nearby calms down until you change location.
- The player only bleeds out if essential. "Keep the player alive for defeat" (OFF) makes you essential while Defeat is on; if no defeat scene happens, you die the normal way.

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
- Failed pickpocket and tavern brawl escalation are **not in 0.1** (no clean hook); the MCM shows them as locked.

## MCM pages

General (master switch, panic key, installed mods, scenes, SkyrimNet, modifiers) — Night attacks — Relationships — Jail & inns — Danger — Creatures — This location — Protected followers — Debug.

## Test checklist

1. MCM > General: bind the Panic key, then turn the master switch on.
2. MCM > Debug: enable debug tools and debug notifications.
3. Stand near an adult follower, press "Night attack", sleep 2 hours. A scene should start.
4. Press the panic key during the scene: it must stop at once, spawns vanish, the mod switches off (MCM shows the master OFF).
5. Turn the master back on and try other force buttons (jail needs a jail and a guard; cheating needs your spouse nearby; road robbery: wait 1h outdoors).
6. Check the Papyrus log for `[ODeadlySkyrim]` lines.

## Known limits (0.1)

- Untested in game.
- Barracks / jails that share a location with the rest of the town are only caught by sleeping or waiting there, not by lingering (lingering needs a location change).
- Guard detection is `Actor.IsGuard()` plus "Guard" in the name.
- The SkyrimNet bio check needs a decisions provider; otherwise the character filter is used.
- Creature probe spawns a hidden actor for a moment when the Creatures module is enabled and on load; if a type shows "No scenes found" wrongly, stand next to a follower and press Re-check.

## Credits

- That Guy (Coronerra).
- Design inspired by ODangerousNights. No ODN files are used; this is not an ODN patch.
- Built on OStim Standalone, SkyUI, powerofthree's Papyrus Extender and SkyrimNet APIs (none of their files are included).

## Other work

Other open-source mods by the same author live under [github.com/Coronerra](https://github.com/Coronerra).
