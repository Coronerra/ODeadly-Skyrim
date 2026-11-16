# O'Deadly Skyrim changelog

By That Guy (Coronerra).

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
