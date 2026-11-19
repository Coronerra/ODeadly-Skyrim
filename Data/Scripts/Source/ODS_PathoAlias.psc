Scriptname ODS_PathoAlias extends ReferenceAlias
{O'Deadly Skyrim 1.0 Blood Born Pathogen: one infected NPC. Event-only (no polling): combat start,
a Cure Disease potion handed over, death, and one single-update after a fight it changed for.}

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

; 1.1: only registered after a fight the actor changed for has ended (no timed revert otherwise)
Event OnUpdate()
	Main.PathoAliasUpdate(GetID())
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

; 1.1.4: a race change by any path (O'Deadly, Growl's beastblood, a vanilla change) and 3D loads:
; beast skin on for NPCs with their own skin, own skin back in their normal race. One call each, no polling.
Event OnRaceSwitchComplete()
	Main.PathoSkinCheck(GetID(), GetActorReference(), "race switch")
EndEvent

Event OnLoad()
	Main.PathoSkinCheck(GetID(), GetActorReference(), "3D load")
EndEvent
