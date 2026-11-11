Scriptname ODS_FollowerAlias extends ReferenceAlias
{O'Deadly Skyrim: bleedout event for a nearby follower (filled on location change, only while Defeat is on).}

Event OnEnterBleedout()
	(GetOwningQuest() as ODS_Main).OnActorBleedout(GetActorReference())
EndEvent
