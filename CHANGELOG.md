# O'Deadly Skyrim changelog

By That Guy (Coronerra).

## 0.3

SkyrimNet listeners for two of Lirael's mods. Both are soft-detected: no new masters (the plugin still needs only `Skyrim.esm`), no new records, and none of their files are included. O'Deadly does not run, start or stop anything in them.

- **OStim Kidnapped Redux** (Lirael's OStim conversion of vinfamy's SexLab Kidnapped Redux): SkyrimNet narration and memories when you are taken (its own ambush or handed over by another mod), slip an ambush, escape, are let go exhausted, or are sold into slavery. O'Deadly holds its own encounters while you are held.
- **ODefeat Reforged** (Lirael): SkyrimNet narration when you are defeated (naming the winner when the scene shows who), and narration plus a memory when you escape, are robbed, are left where you fell, are arrested by a guard or are sold into slavery; a short line if you are executed.
- With ODefeat Reforged installed, O'Deadly's Defeat module leaves a downed player to it (your settings are kept) and still handles followers.
- MCM > General: both mods listed under "Installed mods"; two new SkyrimNet toggles, "Kidnapped Redux events" and "ODefeat Reforged events" (ON, locked when the mod is missing). Both also follow the narration / memory toggles, the master switch and the panic key. The MCM rebuilds its pages on update.
- SkyrimNet pack version 0.3.0.
- Docs updated.

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

## 0.1

First public build.
