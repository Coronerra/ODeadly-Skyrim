# AI_CONTEXT: how O'Deadly Skyrim works

This file is for AI assistants, bots and modders who want to understand this mod quickly and extend it (new vanilla-environment scenarios, patches, SkyrimNet hooks). Everything written by That Guy (Coronerra) is MIT. Third-party APIs belong to their authors (see LICENSE).

## 1. What problem it solves

Most "dangerous world" adult mods for Skyrim are narrow (nights only, prisons only) and often treat the player as the only victim. O'Deadly Skyrim is one all-in-one, toggleable engine for OStim + optional SkyrimNet. Events already in vanilla Skyrim (sleep, wait, lingering in a jail or barracks, inns, defeat, trespass, roads, wilderness) can start a scene with the people who are actually there, including followers. The end user turns on what they want. A master kill switch and a panic hotkey exist for family-safe play.

It was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223). The author never downloaded it, so compatibility is unknown, and it is not required — this already does the same thing and more. No ODN files are used; this is not an ODN patch. If `ODangerousNights.esp` is present, the engine tries to stay out of the way after an ODN attack; that path is untested.

## 2. Hard rules

- Adults only. Children are refused for every role. There is no toggle.
- The master switch defaults to OFF. With it off, nothing in the mod can fire.
- The panic key (unbound by default) or turning the master off aborts scenes, deletes spawns, returns stolen gold, clears calming / essential flags, purges pending SkyrimNet dialogue, cancels timers, and leaves the switch OFF. In 0.2 it also cancels pending morning-after and bathing rolls, removes a spawned watcher and the easter-egg rabbits / butterflies, and switches the drink / wash listeners off.
- Every module is its own MCM toggle. Every 0.2 module defaults to OFF. The 0.3 follower rescue defaults to OFF. The 0.3 SkyrimNet bridges default ON but only do anything when their mod is installed, and send nothing with the master off. The 0.4 climax-fauna menu defaults to Off (`iFaunaMode` 0).
- Scenarios are based on the standard Skyrim environment. Optional mods (SkyrimNet, OCreatures, OCum, ZaZ, OStimNet, ODN, and in 0.2 iActions, Dirt and Blood, Bathing in Skyrim, Blood and OStim, Sacrosanct, JContainers; in 0.3 OStim Kidnapped Redux and ODefeat Reforged; in 0.4 Mihail's The Killer Rabbit of Caerbannog, `mihailkillerbunny.esp`) are soft-detected at runtime and are never plugin masters. Code that needs another mod's script types sits in small interface scripts (`ODS_DnB`, `ODS_IActions`, `ODS_Vamp`) whose global functions are only called after the plugin / SKSE plugin is confirmed loaded. Compile-only stubs for those types live in `tools/stubs/` and are never shipped.

## 3. Plugin and files

- `ODeadlySkyrim.esp`: ESL-flagged, master `Skyrim.esm` only. Holds the main quest (`ODS_MainQuest` / `ODS_Main` plus 12 aliases), the MCM quest (`ODS_MCMQuest` / `ODS_MCM`) and 13 form lists of vanilla forms: 8 spawn pools from 0.1, plus `ODS_PoolVampire`, `ODS_PoolWatcher` (hunter), `ODS_AlcoholVanilla`, `ODS_PoolFauna` (hare) and `ODS_PoolButterfly` in 0.2.
- Scripts are prefixed `ODS_`: `ODS_Main`, `ODS_MCM`, `ODS_PlayerAlias`, `ODS_FollowerAlias`, `ODS_AttackerAlias`, `ODS_VictimAlias`, and the 0.2 interface scripts `ODS_DnB`, `ODS_IActions`, `ODS_Vamp`.
- SkyrimNet pack: `SKSE/Plugins/SkyrimNet/external/coronerra.odeadly/` (`manifest.json` and `prompts/decisions/odeadly/would_act.prompt`). Used to ask whether a character would act, given their bio. Ignored without SkyrimNet. Needs SkyrimNet beta 28+ and a decisions provider; otherwise a built-in character filter (Morality, relationship) is used.
- Papyrus log lines start with `[ODeadlySkyrim]`. Done event: `ODeadlySkyrim_Done(Int kind, Form victim, Form attacker, Bool spawned, Bool intervened, Bool consensual)`.
- **Game versions:** not locked to SE 1.5.97. ESL, `Skyrim.esm` only, no SKSE DLL. Should run on SE and AE 1.6.x (including GOG) with matching SKSE64, SkyUI, Papyrus Extender and OStim Standalone. Built against 1.5.97; AE reports welcome. Will not work on Oldrim or Skyrim VR.

## 4. Engine

Event-based, no polling. One event at a time, a 4-hour cooldown (default), and an abort check at every step. Triggers: sleep (start and stop), the sleep/wait menu, location change, bleedout, OStim thread start/end/scene-changed and `ostim_actor_orgasm`, the panic key, and one-shot timers (jail linger, road travel). 0.2 adds, only while the related module is on: `OnObjectEquipped` (potions) on the player alias, `OnMagicEffectApply` on the player and follower aliases (held in a "Watching" alias state so the handlers do not exist otherwise), and the Bathing in Skyrim mod events.

Location categories (walled-city player home, other player home, inn, city/town, settlement, wilderness, camp, dungeon, plus jail/barracks) are resolved from vanilla location keywords and cell/location names. If SkyrimNet beta 29+ is present and "Use SkyrimNet places" is on (default), a tagged named place wins over keywords. Untagged places fall back to keywords. The AI is not asked to classify untagged cells.

## 5. Modules

Night attacks (followers by default), cheating spouse, caught in the act, follower betrayal, imprisonment and barracks in every hold (sleep, wait or linger — never on door entry), inns (drunk patrons, spiked drinks), defeat (bleedout; optional "keep the player alive"), trespass, travel and roads (gold is moved to the thief, never deleted), optional OCreatures types probed against installed scenes, vampire seduction (present vampires only, no spawns), blackmail and public rumours (SkyrimNet), OCum / ZaZ options, group scenes with fallback to one-on-one, drunk/skooma chance multiplier, named/essential NPC toggle (default off).

Defaults: everything off except the night-attack module inside the master switch, and the drunk/skooma modifier. Player-as-victim is off in most modules.

### 0.2 modules (all OFF by default; kinds 12-15 in `ODS_Main`)

| Module | Kind | Trigger / hook |
|---|---|---|
| Morning after | `K_MORNING` 12 | Own drink counter: player alias `OnObjectEquipped` for potions. Alcohol = `iActions_AlcoholList` (iActions.esp 0x000006; iActions also adds its `extra_alcohol.json` entries to it), the JSON read directly via JContainers, DLC drinks, `ODS_AlcoholVanilla`, then a narrow name check. N drinks in the window arms it; `OnSleepStart` rolls (bypasses the hourly rolls for that sleep); `OnSleepStop` stages. Partner preference by `iActions_DrunkFaction` (0x000002) rank tier (plastered / blackout first), then `IsDrunk`, then any eligible adult; then an optional stranger. Player and partner are moved to a random nearby bed (`OFurniture.FindFurniture`) and a furniture scene is used when one exists. |
| Bathing | `K_BATH` 13 | Dirt and Blood: `Dirty_BathingQuest` (0x000DC3) → `Dirty_BathingActors` form list and the effects of `Dirty_SoapEffectSpell`, which `PlayBatheAnimation`/`Lather` applies at the start of every real wash (not swimming, not rain). Bathing in Skyrim (ESL): mod event `BiS_BatheEvent_<player FormID>` and the effects `mzinPlayBathingAnimationEffect` (0x02C) / `mzinPlayBathingAnimationFollowerEffect` (0x02F) mark a start; `BiS_WashActorFinish(Form actor, Form washProp, Bool soap)` marks the end. One roll per wash even with both mods (short game-time dedupe). Stages after the wash ends (bounded wait). Partner order: co-bather, companions, strangers who would (`WouldAct`), optional spawned stranger. |
| Inns full: shared room | `K_INNSHARE` 14 | Hourly sleep roll in an inn with at least one adult follower within 1500 units. Player + follower or follower + follower, consensual, on a bed when free. Separate from `K_INN` / `K_SPIKED`. |
| Watched from a distance | — | `ostim_thread_start` (any thread) outdoors with the player or a follower in it. Real non-hostile adult 1000+ units away first (line of sight preferred), else an optional spawned hunter 2200-3200 units away (removed after 2 minutes). `SkyrimNetApi.DirectNarration` + a persistent memory with compass direction, distance, who, scene name and whether it looked willing; reaction is leave, call out, or come closer (`PathToReference`). |
| Dark Gift | `K_DARKGIFT` 15 | Hourly sleep roll. Vampire nearby first, else `ODS_PoolVampire`. Blood and OStim: one of its 2-actor feeding scenes (ordered by sex). Aftermath: `DiseaseResist >= 100` or already a vampire = nothing; Sacrosanct loaded = `PlayerVampireQuestScript.VampireChange` on vanilla `PlayerVampireQuest` (0x0EAFD5), which Sacrosanct overrides; otherwise vanilla Sanguinare Vampiris (0x0B8780). Own toggle for the infection. |
| Climax fauna (easter egg) | — | `ostim_actor_orgasm` with the player in the thread, 1 hour cooldown. Menu `iFaunaMode`: 0 Off, 1 vanilla, 2 Killer Rabbit of Caerbannog (`KillerBunnyOK()` = `ModLoaded("mihailkillerbunny.esp")`). Hares (`ODS_PoolFauna`) are still `PlaceAtMe`'d disabled in a ring with Aggression 0; in mode 2 each copy is `SetRace` to `mihailkillerbunny_race` (0x00000800) then `QueueNiNodeUpdate` before Enable. The unique cave NPC (`mihailkillerbunny_NPC` 0x803, and its ghost 0x994) is never `PlaceAtMe`'d. If the race form is missing, mode 2 falls back to vanilla hares. Butterflies (`ODS_PoolButterfly`) moved with `TranslateTo` for ~20 s then deleted; after the thread ends the hares get Aggression 2 and `StartCombat`, all deleted 60 s later. Last option in the MCM (`GetVersion` 5). Old `bFauna` on becomes mode 1 via `MigrateFaunaMode`. |

### 0.4 Climax fauna: Killer Rabbit of Caerbannog (`iFaunaMode`, default 0)

Soft-detect only: `KillerBunnyOK()` / `KillerBunnyRace()`. No master, no shipped Mihail files, no `SetEssential` on his unique ActorBase. `SyncFaunaFlag()` keeps `bFauna` as `iFaunaMode > 0` so existing force-button / panic / delete paths still work. Debug "Climax fauna (next climax)" still requires fauna on. SkyrimNet `DirectNarration` names the Killer Rabbits of Caerbannog only when the race was actually applied. MCM: `faunaOpts` menu, option 2 labelled "(not installed)" and rejected with a message when the plugin is missing. Listed under Installed mods. SkyrimNet pack `0.4.0`.

### 0.3 Follower rescue (mid-battle; `bRescue`, OFF by default)

Side thread, not a staged encounter: it never sets `bBusy`, never calls `StageDefeat`, `Pacify`, `CalmFollowers` or `AddSecondVictim`, and never puts the player in the scene.

- Trigger: `ODS_FollowerAlias.OnEnterBleedout` → `OnActorBleedout` → `TryFollowerRescue` before the Defeat path. Conditions: `Ready()`, `bRescue`, no rescue running, not `bBusy`; follower (`IsFollowerActor`), adult, not on the protect list, guard rule, local gender filter `iRescueGender` (0 both, 1 female, 2 male; `iVictimGender` untouched); player alive, not in bleedout, not in OStim, not held by Kidnapped Redux / ODefeat Reforged; 1 game hour since the last rescue; `fRescueChance` (50). `FillFollowerAliases` also fills the follower aliases while `bRescue` is on.
- Attacker: first actor within 1500 units of the follower who is not a follower, not in bleedout, hostile to the player or follower, `BaseEligible` (adult, `NamedOK`), `CreatureAllowed`, guard rule, and has an aggressive scene with the follower (`SceneForSet`, forced).
- Calming only the pair: attacker Aggression 0 (old value saved), `StopCombat`, `StopCombatAlarm`, added to `PlayerFaction` if not already in it (so followers stop attacking it); not ghosted. Follower: `StopCombat`, health to 50%, `ActorBase.SetProtected(true)` for the scene only if it was neither essential nor protected. One bounded `Wait(1.0)`, then `OThreadBuilder` with `NoPlayerControl`, `NoFurniture`, `UndressActors`, the normal duration range and metadata `odangerous,aggressive,follower_rescue`.
- The attacker goes into `Extra3Alias` (`ODS_AttackerAlias`, only used by 4-attacker group encounters, which cannot start while a rescue runs). `ODS_AttackerAlias` asks `IsRescueAlias(self)`: player `OnHit` / `OnActivate` → `RescueOutcome(1)` (rescued), `OnDeath` → `RescueOutcome(2)`; otherwise the old `Intervene()`.
- `ostim_thread_end` for the rescue thread id → `RescueOutcome(0)` (not in time). The player going into bleedout during a rescue also counts as not in time, then the normal player path runs. `RescueRelease` stops the thread, clears the alias, restores faction and aggression, sends the attacker back into combat with the player, removes the temporary protected flag and gives the follower 50% health. Panic / master off (`AbortAll`) and game load release without SkyrimNet text.
- While it runs: `OtherBusy()` is true (O'Deadly encounters wait), another downed follower bleeds out normally, and `OnOStimThreadStart` skips the caught / watched checks.

### 0.3 SkyrimNet bridges (listeners only; `ODS_Main`, no new records)

Registered in `Register()` (init, game load, master on) only when the plugin is loaded (`ModLoaded`, regular or light). Text goes out with `SkyrimNetApi.DirectNarration` (gated by "Narration when it starts") and `RegisterPersistentEvent` (gated by "Memory afterwards"), only with the master on, the bridge toggle on, and SkyrimNet loaded. Neither mod is started, stopped or changed. While one of them has the player, `OtherBusy()` is true, so O'Deadly does not stage its own encounters (cleared by the end event; lapses after 1 game day / 6 game hours).

| Mod (plugin) | Toggle | Events listened to |
|---|---|---|
| OStim Kidnapped Redux (`OStim Kidnapped Redux.esp`) | `bOKRSkyrimNet` | `OKidnapped_Taken` (numArg 1 = requested via `OKidnapped_Take`, 0 = own ambush; place is read here, before the player is moved), `OKidnapped_Dodged`, `OKidnapped_End` (strArg `escaped` / `released` / `slavery`). `OKidnapped_Refused` is ignored (O'Deadly never sends `OKidnapped_Take`). No actors are passed. |
| ODefeat Reforged (`ODefeat.esp`) | `bODefSkyrimNet` | `ODefeatAnimStart_odefeat` (rebroadcast of `ostim_start`; player scene = OStim metadata contains `odefeat` and the player's FormID; winner = first other adult in `OJson.GetActors`), `ostim_thread_end` with metadata `odefeat_escaped` (escape), outcomes `oDefeat_robberyEvent`, `oDefeat_safeWakeupEvent`, `oDefeat_killEvent` (narration only), `oDefeat_arrestEvent`, and `SSLV Entry` only while a player defeat scene has just ended without an escape and Kidnapped Redux is not holding the player. |

With `ODefeat.esp` loaded, `OnActorBleedout` sends the player to `DefeatFailed` and `UpdateEssential` does not make the player essential; follower defeat is unchanged. Stored settings are not changed. Only OStim's `OJson` is used to read scene metadata: no ODefeat or Kidnapped Redux script types, no stubs.

Scene engine additions: a module can preselect a scene and furniture (`sPreScene`, `kFurn`); `StartThread` then uses `OThreadBuilder.SetFurniture` instead of `NoFurniture`. Spawned or hostile participants are calmed for non-forced scenes too and their aggression is restored afterwards.

## 6. Known limits

- No hook for vanilla arrest dialogue; the stand-in clears the bounty after a jail scene with the player.
- Pickpocket and brawl escalation are shown as locked in the MCM, not built.
- A jail or barracks that shares a location with its town is only caught by sleeping or waiting there.
- ZaZ only changes preferred scenes plus narration. No ZaZ functions are called.
- Defeat of the player needs the optional "keep the player alive" setting, or they die normally. With ODefeat Reforged installed, player defeat is left to it.
- OStim Kidnapped Redux's events carry no actors, so kidnappers and taken followers are not named. Its night-roll handoff only knows ODangerousNights, so O'Deadly night attacks and its kidnappings can both happen at night.
- ODefeat Reforged third-party outcomes other than `SSLV Entry` are not narrated.
- Follower rescue starts OStim while combat continues nearby; other enemies can still hit the follower (kept from dying only through the temporary protected flag).
- iActions drunk tiers assume its default 2 points per level.
- Bathing in Skyrim's start event exists only for the player; followers are caught through its bathing effect.
- With Sacrosanct the Dark Gift turns the player at once (via `VampireChange`) rather than through the disease stage.
- Butterflies are vanilla critter activators driven by `TranslateTo`; the vanilla critter script may clean some up early.

## 7. Rebuild

From this repo, with Caprica (`-g skyrim`) and import folders for vanilla/SKSE, SkyUI SDK (`SKI_ConfigBase` must include `SetInputOptionValue`), OStim Standalone, powerofthree's Papyrus Extender and the SkyrimNet API. `compile.sh` adds `tools/stubs/` (compile-only stand-ins for `Dirty_BathingQuest`, `JValue`, `JArray`, `PlayerVampireQuestScript`; never ship them):

```
CAPRICA=/path/to/caprica IMPORTS=/path/to/import1:/path/to/import2 ./tools/compile.sh
python3 tools/scrub.py build/Scripts/*.pex
python3 tools/mkesp.py build/ODeadlySkyrim.esp
python3 tools/verify.py build/ODeadlySkyrim.esp
```

`scrub.py` strips compile paths and machine names from `.pex` headers (source basename, user `coronerra`, machine `-`).

## 8. Credit and publishing

Public credit is "That Guy (Coronerra)". Do not add personal names, home paths or machine names to shipped files or docs. This repo is the public source, including full notes, Papyrus source and the installable zip on [Releases](https://github.com/Coronerra/ODeadly-Skyrim/releases). The latest published release is [v0.4](https://github.com/Coronerra/ODeadly-Skyrim/releases/tag/v0.4). Do not treat a Nexus listing as authorized unless the author says so.
