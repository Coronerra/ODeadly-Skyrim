# O'Deadly Skyrim changelog

By That Guy (Coronerra).

## 1.1.7

There are no O'Deadly popups at OStim scene start. Scripts only (`ODS_Main`, `ODS_MCM`). The plugin and SkyrimNet pack are unchanged, and every record and FormID is kept.

- **Caught** ("X has seen you…") and **Watched from a distance** ("You feel eyes on you…") both fire as an OStim scene starts. They are now always corner notifications, or nothing when messages are off. They are never a message box, even with MCM message style "Message box". This is the same treatment the Bitch in Heat line got in 1.1.6.
- The MCM "Message style" help explains this.
- Log: new `caught:` and `watched:` lines when those messages show.
- Build check: every compiled script was scanned for a `None` cast or assigned to an array. None found.

Updating from 1.1.6: overwrite the old files. In-place and save-safe.

## 1.1.6

There's no in-game popup for Bitch in Heat any more. Scripts only (`ODS_Main`, `ODS_MCM`). The plugin and SkyrimNet pack are unchanged from 1.1.5, and every record and FormID is kept.

- **Removed the "how many?" message box.** It opened at the same time as OStim's own menu at the start of the scene. The count is now set in the MCM ahead of time: **"How many join"** = 1, 2, 3 or 0 = random 1-3 (default). It applies to werewolves, werebears and vampire lords. It replaces the old "Ask how many" toggle and the "Most beasts that come" slider. The message record stays in the plugin, unused.
- If the chosen count has no installed scene for that cast, the nearest count that has one is used without any prompt (a tie goes to the smaller count). Taking turns works with any count.
- The "Howls / Roars / Wings answer..." line is now always a corner notification (or nothing when messages are off). It is never a message box, even with message style "message box".
- Log: the startup line shows the "How many join" setting. Each event logs the count it used and, when it fell back, the count that was asked for and which counts are installed.
- Build check: every compiled script was scanned for a `None` cast or assigned to an array. None found.

Updating from 1.1.5: overwrite the old files. In-place and save-safe. The old ask and max settings are ignored.

## 1.1.5

Bitch in Heat for werewolves, werebears and vampire lords. Growl and Sacrosanct are soft-detected. Existing vampire followers can become vampire lords. Changed: scripts (`ODS_Main`, `ODS_MCM`), the SkyrimNet pack (new `BecomeVampireLord` action, bio section, manifest 1.1.5) and one text in the plugin (the Bitch in Heat message now reads "Others of their kind are answering"). All records and FormIDs are unchanged and nothing was added. Only OStim Beast Form is required.

- **Bitch in Heat trigger:** one of the two scene actors is a male in full beast form: werewolf, werebear or vampire lord. Human-form werewolves and vampires do not count. Wilderness, adults, you in the scene. The centre is a female human, or a male human only with Werewolf and Vampire Lord OStim's male partner scenes.
- **Werewolves:** packs of 1-3 in one group scene. New Werewolf and Vampire Lord OStim 0.3.1 three-actor scenes: `WVLBWWB3pDogSpit-1`, `WVLBWWB3pHang2-1`, `WVLBWWB3pStandSpit-1`, their `M` versions and `WVLBWWB3pHoldDPM-1`. Old scene IDs and fallbacks are kept, OCreatures last.
- **Werebears:** spawned from Dragonborn's werebear. With OStim Beast Form's "werebears use werewolf scenes" (`OBL_WerebearAsWerewolf`) on, they join the werewolf group scenes and packs can mix werewolves and werebears. With it off they take turns in pair scenes.
- **Vampire lords:** spawned as male vampires and changed to Dawnguard's vampire lord race before they appear. They take turns in `WVLVLVampireLordHubFMC1` / `WVLVLMVampireLordHubMMC1`. They never share a scene with werewolves.
- **Taking turns:** after the walk-in, the first scene ends and one pair scene per newcomer runs, one after another. Your own encounter carries on through the turns, and the aftermath runs after the last one. If a mixed pack has no group scene, they take turns instead.
- Summoned beasts arrive already changed, stay friendly, run no timers and leave politely. The narration and the SkyrimNet memory name the beast type plainly.
- **Growl:** O'Deadly reads Growl's werebear totem (`HRI_Lycan_Global_WerebearTotem`). Growl's beastblood followers change in fights the way Growl decides. O'Deadly still handles SkyrimNet changes (in the correct beast for what they caught) and the body swap for everyone. Without Growl, O'Deadly owns the werebear and werewolf fight changes. The totem and every ownership decision are logged.
- **Sacrosanct:** a newly turned NPC vampire always gets VampireVampirism. With Sacrosanct it also gets Sacrosanct's NPC resistances, poison resistance and a level-based drain, with no Foster Childe message. New MCM toggle **"Sacrosanct: turned vampires get its vampire race"** (OFF): this is skipped if the NPC's own skin has no body for that race. "Cure everyone" undoes all of it.
- **New MCM toggle "Existing vampire followers can become Vampire Lords"** (OFF): SkyrimNet `BecomeVampireLord` and `TransformBack` for vampire followers such as Serana, with the beast skin swap. Back on the panic key or master off. The skin is reapplied on load.
- Log: startup lists Growl (and its totem), Sacrosanct, the Beast Form werebear toggle, the werebear and vampire lord pools and the new toggles. New `heat:` lines (kind, mode, every summon, every turn, skips with reasons), `pathogen:` ownership and Sacrosanct lines, and `vampire followers:` lines.
- Build check: every compiled script was scanned for a `None` cast or assigned to an array. None found.

Updating from 1.1.4: overwrite the old files. In-place and save-safe.

## 1.1.4

O'Deadly now handles beast forms for followers with Growl's beastblood too. Scripts (`ODS_Main`, `ODS_MCM`, `ODS_PathoAlias`) and the SkyrimNet `TransformToBeast` action; plugin, records and FormIDs are unchanged. Growl's files are not touched.

- **SkyrimNet `TransformToBeast` works for Growl followers again** (the 1.1.3 block is gone: no script check, no `ODS_GrowlOwned` condition, and their bio says again that they can change at will). O'Deadly changes them and swaps in the beast body, so they get the beast race's body (OStim Beast Form's female body if installed) instead of an invisible one.
- **Beast form from any path gets the body fix.** When an NPC this mod infected ends up in werewolf, werebear or vampire lord race by any route (Growl's own fight change, a vanilla change, O'Deadly) and has their own skin, the beast race's skin is swapped in; when they are back in their normal race their own skin is given back. Checked on the race change itself, when their 3D loads, once a few seconds after their combat state changes, and on game load. Event-only, no polling.
- **`TransformBack` also undoes a change made by another mod** (e.g. Growl's fight change) when the normal race is known.
- Growl still makes its own fight changes for its followers; O'Deadly's night-fight auto change still stays out of those.
- Log: `skin:` lines also say when a beast form came from another mod (tagged "Growl beastblood" for Growl followers) and when another mod changed them back.
- Build check: every compiled script scanned for a `None` cast or assigned to an array. None found.

Updating from 1.1.3: overwrite the old files. In-place and save-safe.

## 1.1.3

Beast form body fix for NPCs with their own skin. Scripts (`ODS_Main`, `ODS_MCM`) and the SkyrimNet `TransformToBeast` action; plugin, records and FormIDs are unchanged.

- **Fix: invisible body in beast form.** Many custom followers and NPC replacers give the NPC its own skin (the NPC's "worn armor") for their body and textures. The game keeps that skin when the race changes, and it has no werewolf, werebear or vampire lord body, so a turned NPC changed into beast form showed only the head. Now, while O'Deadly has an NPC in beast form, the beast race's own skin is swapped in (`ActorBase.SetSkin`, the leveled base for generic NPCs), and the NPC's own skin is given back when they change back, are cured, cleared or reverted by the panic key / "cure all". NPCs without their own skin and the player are not touched.
- **Save-safe:** skin changes are not stored in the save, so on every game load the swap is put back for anyone still changed. NPCs already stuck invisible from 1.1.2 get their body back on the next load.
- **Growl followers:** a follower who got Growl's companion beastblood is Growl's to change. SkyrimNet `TransformToBeast` no longer also changes them (O'Deadly and Growl used to both claim the same follower), the action is no longer offered to them (new StorageUtil key `ODS_GrowlOwned`), and their bio no longer says they can change at will. `TransformBack` still works for anyone O'Deadly changed.
- New `ODeadlySkyrim.log` lines: `skin:` when an NPC's own skin is saved and the beast skin swapped in, given back, or put back after a load; and when `TransformToBeast` is ignored because Growl owns that follower.
- Build check: every compiled script scanned for a `None` cast or assigned to an array. None found.

Updating from 1.1.2: overwrite the old files. In-place and save-safe.

## 1.1.2

Log file for troubleshooting. Scripts only (`ODS_Main`, `ODS_MCM`, `ODS_PlayerAlias`); plugin, records, FormIDs and the SkyrimNet pack are unchanged.

- **`ODeadlySkyrim.log` is now a full troubleshooting log** (`Data/SKSE/Plugins/`, MO2: `overwrite/SKSE/Plugins/`). Each game load starts a new section with the version and game time (each line carries the real date and time). A few seconds after loading it lists what was found (SKSE, PapyrusUtil, OStim, powerofthree's Papyrus Extender, JContainers, SkyrimNet, OCreatures, OCum, OStim Beast Form and its scenes, Growl, Dirt and Blood, Bathing in Skyrim, the defeat mods and the other optional mods) and which modules and key settings are on.
- **New event lines:** each event staged, started or skipped (with the reason from the line before), defeat rolls, Bitch in Heat rolls and wrong places, join in / step in choices, the wild-creature choice, ODangerous Nights attacks, SkyrimNet memories, the panic key, and every SkyrimNet beast-blood action (`TransformToBeast`, `TransformBack`, `AcceptBloodGift`, `GiveBloodGift`) with the reason when one is ignored.
- **Light and bounded:** no polling, one line per event. The file starts over after 10 game loads (counter in `StorageUtilData/ODeadlySkyrim_log.json`); at most 3000 lines per game load.
- **PapyrusUtil is checked first** (`SKSE.GetPluginVersion("papyrusutil plugin")`): without it nothing is written and nothing errors. Lines still go to `Papyrus.0.log`.
- MCM > Debug: the toggle is now **Write log file** (ON by default) and shows where the file is. Turning it on writes a header and the startup block at once.
- Build check: every compiled script is scanned for a `None` cast or assigned to an array (the 1.1 bug). None found.

Updating from 1.1.1: overwrite the old files. In-place and save-safe.

## 1.1.1

Blood Born Pathogen fix + instant turning. Scripts only (`ODS_Main`, `ODS_MCM`, `ODS_SatAlias`, `ODS_Vamp`); plugin and SkyrimNet pack unchanged.

- **Fix: the pathogen never ran in game.** Every `array == None` check (and `array = None`) compiled to a cast of None to an array type, which the Papyrus VM rejects (`Cannot cast from None to Actor[]`, then `Cannot create an array into a non-array variable`). The pathogen's arrays were never created, so scenes were "tracked" but nothing happened when they ended: no roll, no reason, no infection. Same bug in the Bitch in Heat wolf list and the Saturalia target list. The checks now use `!array`, and arrays are cleared from an unset local. Existing saves recover on the next load.
- **No incubation from a werewolf, werebear or vampire lord.** When the chance hits at the end of the scene, the partner turns at once: werewolf faction / Growl companion beastblood (followers and spouse too) for lycanthropy, vampire faction + sun damage for vampirism. They can use the SkyrimNet beast-form actions right away. SkyrimNet gets a plain-words event and memory: they feel the hot power in the carrier's cum burning through their body as it turns them, and know who gave it to them through sex.
- **You, too:** from a werewolf or werebear you turn at once (vanilla Beast Form power); from a vampire lord you become a vampire at once (`PlayerVampireQuest.VampireChange`, Sacrosanct-aware) and get the Dawnguard Vampire Lord power.
- **New MCM option "Always infect (no chance roll)"** (Blood Born Pathogen, OFF by default): every eligible partner of a werewolf, werebear or vampire lord is turned at the end of the scene without a roll. Immunity, children, the followers / spouse filter, "You can catch it" and the world cap still apply. A vampire in human form still rolls.
- A vampire in human form still passes the slow disease (NPCs: about 3 game days, Cure Disease stops it; you: vanilla Sanguinare Vampiris).

Updating from 1.1: overwrite the old files. In-place and save-safe.

## 1.1

Blood Born Pathogen for everyone, beast forms through SkyrimNet, blood gift. Scripts (`ODS_Main`, `ODS_MCM`, `ODS_PathoAlias`), one new message record, SkyrimNet pack 1.1.0.

- **Anyone in an OStim scene with a werewolf, vampire lord or werebear may catch it** (or with a werewolf / vampire in human form): your partners, you, and NPCs in scenes of their own (new toggle "NPC scenes without you spread it too", ON). One roll per person against the strongest carrier. Up to 4 scenes tracked at once.
- **Chances per form** (new sliders): werewolf, vampire lord, werebear (35% each); human-form carrier 10% (the old "chance per partner"). The 1.0 beast-form slider is retired.
- **World cap** default 10 (was 5 for new installs), checked first when a scene starts.
- **Immunity** unchanged and applied to everyone: werewolves, vampires and vampire lords (Serana, Harkon, the Circle, Volkihar, Dawnguard, werewolf / vampire factions, Growl beastblood), beast form, already infected. Children always refused.
- **You can catch it** (new toggle, ON): vampirism = vanilla Sanguinare Vampiris; lycanthropy / werebear blood incubates ~3 game days (Cure Disease potion stops it), then the vanilla Beast Form power and `PlayerIsWerewolf`.
- **Werebear blood** (kind 3, Dragonborn `DLC2WerebearBeastRace`); werebears count as beast form everywhere.
- **SkyrimNet actions** `TransformToBeast` / `TransformBack` for NPCs this mod turned (werewolf, vampire lord, werebear) and a character bio section (what they are, from whom, beast form now or not). New toggle "SkyrimNet: turned NPCs change at will", ON. No timer: changed on request = stays until changed back; changed for a fight = back after the fight (the old 30-second change is gone). On load only fight changes whose fight is over are undone.
- **Blood gift** (no roll, turns at once): SkyrimNet actions `AcceptBloodGift` / `GiveBloodGift`, and a new Blood gift key with a yes / no box (`ODS_BloodGiftChoice`, 0x82D). With Growl, a werewolf gift uses Growl's companion beastblood (0xAA06).
- **OStim Beast Form 1.0 scenes first:** `OBFWerewolfIdleFM`, `OBFWerewolfIdleFF`, `OBFVampireLordIdleFM` before `OCr*Idle*`.
- SkyrimNet sees state through StorageUtil (`papyrus_util`), so no Papyrus runs while prompts render.
- MCM `GetVersion` 14. New settings at the end of `ODS_Main`; 1.0.x infections are migrated on load.

Updating from 1.0.2: overwrite the old files. In-place and save-safe.

## 1.0.2

Blood Born Pathogen diagnostics. Scripts (`ODS_Main`, `ODS_MCM`) plus the plugin description (records and FormIDs unchanged); SkyrimNet pack unchanged.

- **Debug force shows the reason:** while "Blood Born Pathogen (next scene)" is armed, each pathogen result (scene tracked or not, why a partner can't be infected, the roll, the infection) is shown on screen even without Debug notifications. A rejected partner leaves the force armed. The force only skips the chance roll; the MCM text now says so.
- **MCM > Debug:** force armed yes/no, the last pathogen result, and who is infected.
- **`ODeadlySkyrim.log`:** every O'Deadly log line is also written (timestamped) to `Data/SKSE/Plugins/ODeadlySkyrim.log` through PapyrusUtil's `MiscUtil.WriteToFile`; toggle "Write ODeadlySkyrim.log" (ON by default).
- **New log lines:** untracked scenes and why (pathogen or master off while the force is armed, player not in the scene, no lycanthropy / vampirism found), an untracked scene ending while the force is armed, and the former silent returns in `PathoInfect` (no free slot, `ODS_PathoQuest` missing, alias missing).
- **Timer fix:** `OnUpdateGameTime` no longer drops the game-time timer when OStim is not ready: pathogen stages still advance and it retries in one game hour.
- **MCM text:** infected or turned NPCs look normal until a fight at night.
- MCM `GetVersion` 13. New settings at the end of `ODS_Main` (`bLogFile`, `sPathoLast`).

Updating from 1.0.1: overwrite the old files. In-place and save-safe.

## 1.0.1

Blood Born Pathogen fix. Scripts only (`ODS_Main`, `ODS_MCM`); plugin, records, FormIDs and the SkyrimNet pack are unchanged.

- **Infection reasons:** the Papyrus log now records why a partner could not be infected (child, not a humanoid, in beast form, not detected as a follower or spouse, essential, on the Protected followers list, already infected, already a vampire, Companions' Circle / Volkihar / Dawnguard / werewolf or vampire faction, Growl beastblood, limit reached), each chance roll, scenes that are tracked, and when no lycanthropy or vampirism is found on you (with the `PlayerIsWerewolf` / `PlayerIsVampire` values). With Debug notifications on, they also show on screen.
- **"Tell me when someone is infected"** (MCM > More encounters, **ON by default**): a short on-screen note, for example "Lydia caught lycanthropy from you."
- **Essential no longer blocks your own followers or spouse.** Other essential NPCs are still never infected.
- **"Protected followers / spouse can still catch it"** (**OFF by default**): your own followers and spouse on the Protected followers page can catch it from you; they stay protected from everything else.
- MCM `GetVersion` 12 (pages rebuild). New settings are added at the end of `ODS_Main`.

Updating from 1.0: overwrite the old files. In-place and save-safe; settings carry over.

## 1.0

Five new modules. Each is **OFF by default**, with its own MCM toggles and chance slider; master switch, panic key and the no-children rule apply. OCreatures, OStim Beast Form, Growl and the Saturalia Holiday Pack are soft-detected (never masters, no files included).

- **Join in** (MCM > Relationships). When one of this mod's consensual scenes involves your spouse or a companion and someone else (cheating spouse, shared inn room, bathing) and you are not in it, a box offers Watch, Join in, or Stop them (100% when possible). Joining ends the two-person scene and starts a three-person scene with the three of you. If OStim has no three-person scene for that group, you take over instead (the other partner steps aside; toggle, ON by default), otherwise you keep watching. Never for forced scenes or creature scenes. SkyrimNet is told plainly that you walked in and joined.
- **Wild creatures** (MCM > Creatures, needs OCreatures). Rare wilderness-road event (2% per game hour / wait hour): a creature is forcefully taking a spawned traveler, your spouse / a companion, or you (player OFF by default). Watch or Rescue when it is not you. Only creature types with installed scenes, no draugr or falmer outdoors; werewolves are left to the Beast Form page when OStim Beast Form is installed.
- **OStim Beast Form** (new MCM page "Beast Form", tested against Beast Form 0.8, Growl or TWO edition).
  - Werewolves at night (3% per night hour / wait hour on a wilderness road, 20:00-05:00): a werewolf in full beast form is aggressively taking a spawned traveler, your spouse / a companion, or you (player OFF by default). Watch or Rescue. Not while you are in beast form.
  - When you transform into a werewolf or vampire lord (50%, once per transformation): take a beaten bandit (a hostile adult who is down or badly hurt; in the wilderness, a bandit who ambushed you if nobody is around), or claim your spouse or a willing companion (consensual; a companion's willingness comes from SkyrimNet's decision model and their bio when available, otherwise from their relationship with you).
  - Scenes start through OStim on Beast Form's own start scenes. Without the plugin or its start scenes, these options do not appear.
  - **Bitch in Heat** (25% per eligible scene): when an OStim scene with you starts between a male werewolf in beast form and a human, outdoors away from towns, the howls and scent draw 1-3 other werewolves to join. You choose how many (or automatic, with a maximum); only counts with an installed scene for that cast are offered (Beast Form and Werewolf and Vampire Lord OStim multi-werewolf scenes, female and male human versions). The human stays the centre; nothing is offered if the partner is not human. The newcomers are always in werewolf beast form (checked twice, otherwise the event is skipped), are never hostile, walk in from out of sight, the scene grows to include them, and afterwards they walk away and vanish out of sight. SkyrimNet is told plainly.
- **Blood Born Pathogen** (MCM > More encounters, 10% per partner, 35% in werewolf / vampire lord form). If you are a werewolf or vampire (vanilla, Growl or Sacrosanct) and finish an OStim scene with an adult human partner, you can pass it on. Followers and your spouse only by default; an option allows any eligible NPC, capped (5 by default, at most 10). Never children, essential or protected NPCs, the Companions' Circle, Volkihar, Dawnguard, or anyone already infected. About 3 game days of incubation with symptom updates; a potion of Cure Disease stops it in that time. Lycanthropy: they become a werewolf and, in a night fight, change into beast form for about 30 seconds (90 second cooldown, never on furniture or a mount, always changed back on load and by the panic key); followers with Growl installed get Growl's own beastblood instead. Vampirism: no race change; vampire faction and sun damage. SkyrimNet is told plainly at every step that you, by name, passed it to them through sex, and their memories and bio keep it. MCM lists who is infected and can cure everyone this mod infected.
- **Saturalia** (MCM > More encounters, needs the Creation Club Saturalia Holiday Pack, locked without it). 22-24 Evening Star: once a day SkyrimNet hears that Saturalia is 3, 2, 1 day(s) away. 25 Evening Star: a few times (3 by default) when you are out of combat in a town, settlement, inn or shop, Agrane Peryval comes from just out of sight and hands 1-3 adults nearby a sweetroll, mead, a gem or a Saturalia hat, and SkyrimNet is told. At midnight (or on the next load after the 25th) he goes back to his camp. Every year. Uses the existing timer, no polling.
- Debug tools: force a wild creature or werewolf event now on a wilderness road, the next beast-form choice, the next Bitch in Heat, the next Blood Born Pathogen infection, or a Saturalia gift visit (date ignored).
- New plugin records (appended): `ODS_JoinChoice` 0x820, `ODS_WildChoice` 0x821, `ODS_BeastPreyChoice` 0x822, `ODS_BeastClaimChoice` 0x823, and for Bitch in Heat `ODS_HeatPackFaction` 0x824, `ODS_PoolHeatWolf` 0x825, `ODS_HeatAllow1-3` 0x826-0x828, `ODS_HeatChoice` 0x829, `ODS_HeatQuest` 0x82A (new script `ODS_HeatWolfAlias`), `ODS_SatQuest` 0x82B (Saturalia, script `ODS_SatAlias`) and `ODS_PathoQuest` 0x82C (Blood Born Pathogen, ten `ODS_PathoAlias` aliases). ESL, `Skyrim.esm` only. New script settings are added at the end of the scripts and start at default (off). MCM rebuilds its pages (`GetVersion` 11). SkyrimNet pack 1.0.0 with a second decision template, `would_consent`.

Updating from 0.9: overwrite the old files; settings carry over. Existing plugin records and FormIDs are unchanged. The new options stay off until you turn them on.

## 0.9

Two new wilderness-road events, each with its own MCM toggle (OFF by default) and chance slider (2% per game hour / wait hour). 0.8's furniture fix is included.

- **Savior Complex** (MCM > Danger). A rare roadside encounter: a spawned bandit is forcefully taking a spawned traveling merchant or traveler (vanilla templates only; never a world or quest NPC). Adults only. SkyrimNet is told plainly at the start what the bandit is doing to the traveler, so the AI is not left to guess. A message box then offers Watch (the scene continues; you are not involved), Join in (you are added to the scene when OStim has a three-person animation; otherwise you stay and watch), or Rescue (the scene stops, the bandit turns hostile). SkyrimNet is told what you chose. On a successful rescue the traveler thanks you through SkyrimNet. Activating or hitting the bandit while you were watching also counts as a rescue. Spawned actors are cleaned up afterwards.
- **Killer Rabbit vs Vigilants of Stendarr** (MCM > Danger). Needs Mihail's [The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) (`mihailkillerbunny.esp`); locked without it, and none of his files are included. Two spawned generic Vigilants of Stendarr (vanilla templates, never Keeper Carcette or other unique Vigilants) are fighting a Killer Rabbit and losing. The rabbit is a vanilla hare reskinned to Mihail's race, the same method as the climax-fauna option; his unique cave rabbit is never copied. You can kill the rabbit. SkyrimNet is told who won. Surviving Vigilants thank you and are embarrassed that a rabbit was beating them. Vigilants who are about to die are knocked unconscious instead of being flagged essential, and no essential flags are left on anyone. The panic key and master switch clear the fight and wake anyone who was unconscious.
- Both events use the existing travel timer (one roll per game hour outdoors, plus waiting). They only fire outdoors in the wilderness, not in interiors, cities or towns, and not when a unique essential or protected NPC is nearby. Master switch, panic key and the no-children rule apply. They are independent of the Travel & roads robbery option.
- Debug tools can force either event now (if you are already on a wilderness road) or queue it for the next travel hour / wait.
- New plugin records: `ODS_PoolTraveler`, `ODS_PoolVigilant`, and the Savior Complex choice message `ODS_SaviorChoice`. ESL, `Skyrim.esm` only. New script settings start at default (off) on an existing save. MCM rebuilds its pages (`GetVersion` 8). SkyrimNet pack version 0.9.0.

Updating from 0.8 or 0.7: overwrite the old files; settings carry over. Existing plugin records and FormIDs are unchanged (0.9 only adds `ODS_PoolTraveler`, `ODS_PoolVigilant`, and `ODS_SaviorChoice`). The two new options stay off until you turn them on.

## 0.8

Scene actors leave furniture and sleep first.

- **Fixed: an NPC could stay in their sleeping or sitting pose during a scene.** Reported for a sleep attack: the partner lying in the bed next to the player stayed in her bed pose while the attackers' OStim animations played. `StageWithFade` only got the player out of bed.
- New `LeaveFurniture(acts)`, called in `StartThread` before `OThreadBuilder.Create` (every module, both threads when a scene is split in two, the morning after and other bed scenes) and before the follower-rescue thread. Every scene actor except the player with `GetSitState() != 0` or `GetSleepState() != 0` gets `MoveTo(self)` and `EvaluatePackage()`. Then a bounded wait (up to 4 s) for `GetSitState() == 0`, and one more nudge for anyone still stuck. With a bed scene (`kFurn`), the actors leave their current furniture first and OStim then places them on the bed.
- Unchanged on purpose: activating (E) a victim during a scene is still an intervention that ends the scene. README (new "Playing the hero" section, plus a note at the top) and release notes now say so, and point to SkyrimNet's talk / voice input for talking to someone without interrupting.
- Same records and FormIDs (plugin description now v0.8), no new script variables, MCM unchanged (`GetVersion` 7). SkyrimNet pack version 0.8.0.

Updating from 0.7: overwrite the old files; settings carry over.

## 0.7

Sleep-event timing (NPC AI Position Fix compatibility) and bath-timing fix.

- **Fixed: crash on save with NPC AI Position Fix after a sleep event.** NPC AI Position Fix records every actor moved or attached between sleep/wait start and the Sleep/Wait Menu closing, then repositions them on sleep/wait stop. 0.6 staged sleep events inside that window: `HandleRest` waited with `Utility.WaitMenuMode`, then `StageWithFade` called `PlayerRef.MoveTo(PlayerRef)` to interrupt the sleep and `PlaceAtMe`-spawned actors that were later disabled and deleted.
- **Sleep events now begin as you wake.** `OnSleepStart` only rolls (same chances and priority order, morning-after check unchanged) and records the pending kind and run. `OnSleepStop` stages it (`RunPendingRest`), with `OnMenuClose` as a fallback. Before staging, `RestSettle` waits for the Sleep/Wait Menu to close (bounded, 10 s) and then 1 s more. The sleep is no longer interrupted.
- The morning after (`OnSleepStop`) uses the same path, so it also waits for the menu to close. Wait events (`OnMenuClose`, already after the menu closed) pause 1 s too.
- `StageWithFade` (from a rest) lets the player get out of bed on their own first (up to 5 s) and only uses `MoveTo` to stand them up if they are still in the bed. By then the rest is over.
- If the sleep was interrupted by something else, the pending event is dropped and the module is freed. A load, the panic key, master off, or a stale pending event at the next sleep clears it too, so it can never block later events.
- **Fixed: a Bathing scene could start before a long bath had finished.** Vanilla Dirt and Blood ends its wash about 25 seconds after the lather. With the [Malignis Animations - BiSR DnB Patch](https://www.nexusmods.com/skyrimspecialedition/mods/166293) a woman's bath runs about 65 seconds after the soap effect (58 s wash, about 6.4 s drying, then the redress). 0.6 gave up waiting after 60 seconds, so the scene could start while Dirt and Blood was still drying and re-dressing her; clothes could be re-equipped and player controls re-enabled in the middle of the scene.
- One wait-until-done path covers both (no setting, no "Malignis" switch): `OnBathStart` waits while the actor is still bathing (Dirt and Blood's `Dirty_BathingActors`, or Bathing in Skyrim's bathing effect / `BiS_WashActorFinish`) for up to 150 seconds, then waits 2.5 seconds more so clothes and controls are restored, then stages. If the actor is still bathing at 150 seconds, no scene is started and the module is freed for the next wash.
- `BathPartnerOK`: someone still inside a running bath is never picked as the partner.
- Nothing else changes: same records and FormIDs (only the plugin description now reads v0.7), same defaults, master switch still OFF, MCM unchanged (`GetVersion` 7). SkyrimNet pack version 0.7.0. Three new script variables (`bRestPending`, `iRestKind`, `iRestEpoch`) start empty on an existing save.

Updating from 0.6: overwrite the old files; settings carry over.

## 0.6

Bug fix: scenes never started.

- **Fixed: no scenes at all.** On first load the main script stopped at its very first startup step (`InitArrays`, the check of the protected-NPC list), with "Cannot cast from None to Form[]" and "Cannot create an array into a non-array variable" in the Papyrus log. The lists that hold attackers and victims were never created, so every encounter failed after that ("Cannot access an element of a None array" in `ClearStage` / `AddVictim`, "Mismatched types assigning to variable named acts" in `SceneForSet`), and trespass logged "no resident with a scene".
- The protected-NPC list (MCM > Protected followers) is stored under a new name, `ProtectedForms`. The old list is no longer read at all.
- Startup now creates the lists scenes need first (attackers, victims, spawns, calming), then the MCM lists, so a problem with a settings list can no longer stop scenes. Lists are no longer compared to or cleared with a bare `None` anywhere in the scripts or the MCM; that compiled check is what the game refused.
- Scene actor lists are now plain Papyrus arrays of exactly the right size instead of OStim's `OActorUtil.CreateArray`, so OStim always gets one entry per actor with no empty slots. How scenes are chosen is unchanged.
- Nothing else changes: same plugin, same records and FormIDs (only its description now reads v0.6), still only `Skyrim.esm` as master. The MCM rebuilds its pages (`GetVersion` 7). SkyrimNet pack version 0.6.0.
- Thanks to the player who sent the Papyrus log. Feedback welcome: please report issues on [GitHub Issues](https://github.com/Coronerra/ODeadly-Skyrim/issues) with your Papyrus log (`[ODeadlySkyrim]` lines).

Updating from 0.5: overwrite the old files; settings carry over, except the protected-NPC list, which must be set again (MCM > Protected followers). A save where scenes never started picks up the fix on the next load.

## 0.5

- **[Baka Defeat – OStim Edition](https://www.patreon.com/posts/173783288)** support (plugin `SexLabDefeat.esp`; OStim conversion by Lauffey, released on [Lirael Atelier's Patreon](https://www.patreon.com/LiraelAtelier); original SexLab Defeat by Goubo, Baka Edition by BakaFactory). Soft-detected: no new masters (the plugin still needs only `Skyrim.esm`), no new records, and none of its files are included. O'Deadly does not run, start or stop anything in it.
- With Baka Defeat installed, O'Deadly's Defeat module leaves a downed player to it (your settings are kept) and still handles followers. While Baka Defeat has the player, O'Deadly does not start its own encounters.
- SkyrimNet narration and memories from Baka Defeat's own mod events: beaten and taken (names who took you when the scene shows it, a shorter line for later turns), waking up at an inn, left for dead, robbed, getting away, a companion taken after a lost fight, an NPC beaten and taken by another NPC, and your own victims when you use Baka's actions. Consensual, paid and corpse scenes are not narrated. Adults only: a scene with a child in it is never narrated.
- **Both defeat mods installed** (ODefeat Reforged and Baka Defeat): a notification once per game load and a one-time message box per save: "O'Deadly Skyrim: Both ODefeat Reforged and Baka Defeat (OStim Edition) were detected. For stability use only one, preferably Baka Defeat since it does more." The same advice shows on MCM > General > Installed mods. O'Deadly still stands aside for a downed player and does not narrate the same defeat twice.
- MCM > General: Baka Defeat listed under "Installed mods"; new SkyrimNet toggle "Baka Defeat events" (ON, locked when the mod is missing). It follows the narration / memory toggles, the master switch and the panic key. MCM rebuilds its pages (`GetVersion` 6). SkyrimNet pack version 0.5.0.
- Docs: the "one defeat mod only, preferably Baka Defeat" advice, and neutral wording throughout. Feedback welcome: please report issues on [GitHub Issues](https://github.com/Coronerra/ODeadly-Skyrim/issues).

Updating from 0.4: overwrite the old files; settings carry over.

## 0.4

- **Climax fauna** is now a three-way menu: Off (default), Vanilla rabbits, or Killer Rabbit of Caerbannog. The third option needs [Mihail's The Killer Rabbit of Caerbannog](https://www.nexusmods.com/skyrimspecialedition/mods/88905) (`mihailkillerbunny.esp`); without it the choice is locked and labelled "not installed". None of his files are included, and his plugin is not a master.
- When that option is on, the usual ring of hares is reskinned to his killer-rabbit race (his unique cave rabbit is never spawned or moved). If the race cannot be found, it falls back to vanilla rabbits. Butterflies are unchanged. SkyrimNet narration names the Killer Rabbits of Caerbannog when that option is used.
- Old saves that already had the easter egg on become Vanilla rabbits. MCM rebuilds its pages (`GetVersion` 5). Listed under Installed mods. SkyrimNet pack version 0.4.0.

Updating from 0.3: overwrite the old files; settings carry over.

## 0.3

- **Follower rescue (mid-battle)**, new option on the Danger page, **OFF by default**, behind the master switch and the panic key, adults only. When a follower goes down in a fight while you are still standing, one nearby enemy may start taking them (50% by default) while the rest of the fight goes on. Hit or kill that enemy to pull your follower away. "Downed follower": Both / Female / Male (only for this option). One at a time, at most one per game hour. SkyrimNet narration when it starts and a memory of how it ended. With this option off, the Defeat module works exactly as before; with both on, a downed follower goes to the rescue first and Defeat takes over when the rescue does not start.

SkyrimNet listeners for two of Lirael's mods. Both are soft-detected: no new masters (the plugin still needs only `Skyrim.esm`), no new records, and none of their files are included. O'Deadly does not run, start or stop anything in them.

- **[OStim Kidnapped Redux](https://www.patreon.com/posts/175042213)** (Lirael's OStim conversion of vinfamy's SexLab Kidnapped Redux): SkyrimNet narration and memories when you are taken (its own ambush or handed over by another mod), slip an ambush, escape, are let go exhausted, or are sold into slavery. O'Deadly holds its own encounters while you are held.
- **[ODefeat Reforged](https://www.patreon.com/LiraelAtelier/posts/odefeat-reforged-164815196)** (Lirael): SkyrimNet narration when you are defeated (naming the winner when the scene shows who), and narration plus a memory when you escape, are robbed, are left where you fell, are arrested by a guard or are sold into slavery; a short line if you are executed.
- With ODefeat Reforged installed, O'Deadly's Defeat module leaves a downed player to it (your settings are kept) and still handles followers.
- MCM > Danger: "Follower rescue (mid-battle)" section. MCM > General: both mods listed under "Installed mods"; two new SkyrimNet toggles, "Kidnapped Redux events" and "ODefeat Reforged events" (ON, locked when the mod is missing). Both also follow the narration / memory toggles, the master switch and the panic key. The MCM rebuilds its pages on update.
- SkyrimNet pack version 0.3.0.
- Docs updated: original cover at the top of the repository README, and Patreon links for the two optional Lirael mods. The README now states that this was based on the idea of [ODangerous Nights](https://www.patreon.com/posts/166577223), that ODangerous Nights was never downloaded so compatibility is unknown, and that it is not needed because this already does the same thing and more.

Updating from 0.2: overwrite the old files; settings carry over.

## 0.2

New optional modules. Every one is **OFF by default**, sits behind the master switch, is stopped by the panic key, and never involves children.

- **Morning after**: drink more than 3 in a short time (4 within 2 game hours by default), then sleep: you may wake up in a random bed nearby with someone. Uses iActions' alcohol list and prefers NPCs iActions marks as plastered or blacked out, when iActions is installed.
- **Bathing**: works with Dirt and Blood and/or Bathing in Skyrim. One roll per real wash (not swimming or rain), for you or a follower. Someone bathing with you is preferred, then companions, then strangers who would.
- **Inns full: shared room**: sleeping in an inn with your party can lead to an encounter between you and a follower, or two followers. Found on the "Jail & inns" page; the existing inn options are unchanged.
- **Watched from a distance**: during an outdoor scene, a hunter or traveller may see it from afar. SkyrimNet gets where, who and what; they leave, call out or come closer.
- **Dark Gift**: a vampire wakes you with a love scene (a feeding scene with Blood and OStim). Afterwards you contract vampirism (through Sacrosanct if installed), unless you are immune to disease.
- **Climax fauna (easter egg)**: after your climax, a small chance that twenty rabbits surround you and charge while butterflies swirl. Bottom of the MCM.

Other changes:

- New MCM page "More encounters" (between Creatures and This location). Debug page: force buttons for each new module.
- Scenes can now use a nearby bed (furniture scenes) when a module picks one.
- Light-plugin (ESL) mods are now detected correctly.
- New integrations are soft-detected only: no new masters (the plugin still needs only Skyrim.esm), and none of those mods' files are included.
- SkyrimNet pack version 0.2.0.
- Docs updated.

Updating from 0.1: overwrite the old files; settings carry over.

## 0.1 (first preview)

First public build.
