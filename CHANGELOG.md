# O'Deadly Skyrim changelog

By That Guy (Coronerra).

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
