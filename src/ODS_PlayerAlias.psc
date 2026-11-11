Scriptname ODS_PlayerAlias extends ReferenceAlias
{O'Deadly Skyrim: game load, location change and bleedout events for the player. No polling.}

Event OnPlayerLoadGame()
	(GetOwningQuest() as ODS_Main).OnGameLoaded()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as ODS_Main).OnLocChange(akOldLoc, akNewLoc)
EndEvent

Event OnEnterBleedout()
	(GetOwningQuest() as ODS_Main).OnActorBleedout(GetActorReference())
EndEvent
