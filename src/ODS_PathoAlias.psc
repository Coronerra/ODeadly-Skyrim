Scriptname ODS_PathoAlias extends ReferenceAlias
{O'Deadly Skyrim 1.0 Blood Born Pathogen: one infected NPC. Event-only (no polling): combat start,
a Cure Disease potion handed over, death, and one single-update for the forced change back.}

ODS_Main Property Main Auto

Function Watch(Form cure)
	RemoveAllInventoryEventFilters()
	If cure
		AddInventoryEventFilter(cure)
	EndIf
EndFunction

Function Halt()
	UnregisterForUpdate()
	RemoveAllInventoryEventFilters()
EndFunction

Function RevertIn(float secs)
	RegisterForSingleUpdate(secs)
EndFunction

Event OnUpdate()
	Main.PathoRevert(GetID())
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	Main.PathoCombat(GetID(), GetActorReference(), aeCombatState)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Main.PathoItem(GetID(), GetActorReference(), akBaseItem)
EndEvent

Event OnDeath(Actor akKiller)
	Main.PathoDied(GetID(), GetActorReference())
EndEvent
