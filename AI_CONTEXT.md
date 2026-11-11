# AI_CONTEXT: how O'Deadly Skyrim works

This file is for AI assistants, bots and modders who want to understand this mod quickly and extend it (new vanilla-environment scenarios, patches, SkyrimNet hooks). Everything written by That Guy (Coronerra) is MIT. Third-party APIs belong to their authors (see LICENSE).

## 1. What problem it solves

Most "dangerous world" adult mods for Skyrim are narrow (nights only, prisons only) and often treat the player as the only victim. O'Deadly Skyrim is one all-in-one, toggleable engine for OStim + optional SkyrimNet. Events already in vanilla Skyrim (sleep, wait, lingering in a jail or barracks, inns, defeat, trespass, roads, wilderness) can start a scene with the people who are actually there, including followers. The end user turns on what they want. A master kill switch and a panic hotkey exist for family-safe play.

It is inspired by ODangerousNights. No ODN files are used; this is not an ODN patch.

## 2. Hard rules

- Adults only. Children are refused for every role. There is no toggle.
- The master switch defaults to OFF. With it off, nothing in the mod can fire.
- The panic key (unbound by default) or turning the master off aborts scenes, deletes spawns, returns stolen gold, clears calming / essential flags, purges pending SkyrimNet dialogue, cancels timers, and leaves the switch OFF.
- Scenarios are based on the standard Skyrim environment. Optional mods (SkyrimNet, OCreatures, OCum, ZaZ, OStimNet, ODN) are soft-detected at runtime and are never plugin masters.

## 3. Plugin and files

- `ODeadlySkyrim.esp`: ESL-flagged, master `Skyrim.esm` only. Holds the main quest (`ODS_MainQuest` / `ODS_Main` plus 12 aliases), the MCM quest (`ODS_MCMQuest` / `ODS_MCM`) and 8 spawn form lists.
- Scripts are prefixed `ODS_`: `ODS_Main`, `ODS_MCM`, `ODS_PlayerAlias`, `ODS_FollowerAlias`, `ODS_AttackerAlias`, `ODS_VictimAlias`.
- SkyrimNet pack: `SKSE/Plugins/SkyrimNet/external/coronerra.odeadly/` (`manifest.json` and `prompts/decisions/odeadly/would_act.prompt`). Used to ask whether a character would act, given their bio. Ignored without SkyrimNet. Needs SkyrimNet beta 28+ and a decisions provider; otherwise a built-in character filter (Morality, relationship) is used.
- Papyrus log lines start with `[ODeadlySkyrim]`. Done event: `ODeadlySkyrim_Done(Int kind, Form victim, Form attacker, Bool spawned, Bool intervened, Bool consensual)`.
- **Game versions:** not locked to SE 1.5.97. ESL, `Skyrim.esm` only, no SKSE DLL. Should run on SE and AE 1.6.x (including GOG) with matching SKSE64, SkyUI, Papyrus Extender and OStim Standalone. Built against 1.5.97; untested on AE. Will not work on Oldrim or Skyrim VR.

## 4. Engine

Event-based, no polling. One event at a time, a 4-hour cooldown (default), and an abort check at every step. Triggers: sleep, the sleep/wait menu, location change, bleedout, OStim thread start/end/scene-changed, the panic key, and one-shot timers (jail linger, road travel).

Location categories (walled-city player home, other player home, inn, city/town, settlement, wilderness, camp, dungeon, plus jail/barracks) are resolved from vanilla location keywords and cell/location names. If SkyrimNet beta 29+ is present and "Use SkyrimNet places" is on (default), a tagged named place wins over keywords. Untagged places fall back to keywords. The AI is not asked to classify untagged cells.

## 5. Modules (0.1)

Night attacks (followers by default), cheating spouse, caught in the act, follower betrayal, imprisonment and barracks in every hold (sleep, wait or linger — never on door entry), inns (drunk patrons, spiked drinks), defeat (bleedout; optional "keep the player alive"), trespass, travel and roads (gold is moved to the thief, never deleted), optional OCreatures types probed against installed scenes, vampire seduction (present vampires only, no spawns), blackmail and public rumours (SkyrimNet), OCum / ZaZ options, group scenes with fallback to one-on-one, drunk/skooma chance multiplier, named/essential NPC toggle (default off).

Defaults: everything off except the night-attack module inside the master switch, and the drunk/skooma modifier. Player-as-victim is off in most modules.

## 6. Limits in 0.1

- Untested in game.
- No hook for vanilla arrest dialogue; the stand-in clears the bounty after a jail scene with the player.
- Pickpocket and brawl escalation are shown as locked in the MCM, not built.
- A jail or barracks that shares a location with its town is only caught by sleeping or waiting there.
- ZaZ only changes preferred scenes plus narration. No ZaZ functions are called.
- Defeat of the player needs the optional "keep the player alive" setting, or they die normally.

## 7. Rebuild

From this repo, with Caprica (`-g skyrim`) and import folders for vanilla/SKSE, SkyUI SDK (`SKI_ConfigBase` must include `SetInputOptionValue`), OStim Standalone, powerofthree's Papyrus Extender and the SkyrimNet API:

```
CAPRICA=/path/to/caprica IMPORTS=/path/to/import1:/path/to/import2 ./tools/compile.sh
python3 tools/scrub.py build/Scripts/*.pex
python3 tools/mkesp.py build/ODeadlySkyrim.esp
python3 tools/verify.py build/ODeadlySkyrim.esp
```

`scrub.py` strips compile paths and machine names from `.pex` headers (source basename, user `coronerra`, machine `-`).

## 8. Credit and publishing

Public credit is "That Guy (Coronerra)". Do not add personal names, home paths or machine names to shipped files or docs. This repo is the public source. Do not treat a Nexus listing as authorized unless the author says so.
