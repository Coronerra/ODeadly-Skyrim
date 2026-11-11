Scriptname ODS_PlayerAlias extends ReferenceAlias
{O'Deadly Skyrim: game load, location change and bleedout events for the player. No polling.
0.5: one single update a few seconds after a load for the both-defeat-mods notice.
0.2: while Morning after or Bathing is on, the "Watching" state also listens for drinks and wash effects.}

MagicEffect[] kFx
bool bFx = false
bool bDrinks = false

Event OnPlayerLoadGame()
	(GetOwningQuest() as ODS_Main).OnGameLoaded()
	RegisterForSingleUpdate(8.0)      ; 0.5: one late check once the HUD is up
EndEvent

; 0.5: single update after a load only (never re-registered): both defeat mods installed?
Event OnUpdate()
	(GetOwningQuest() as ODS_Main).BothDefeatsWarn()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	(GetOwningQuest() as ODS_Main).OnLocChange(akOldLoc, akNewLoc)
EndEvent

Event OnEnterBleedout()
	(GetOwningQuest() as ODS_Main).OnActorBleedout(GetActorReference())
EndEvent

; called by ODS_Main; the extra events only exist in the Watching state, so they cost nothing when off
Function SetWatch(bool on, bool fx, bool drinks, MagicEffect[] effects)
	kFx = effects
	bFx = fx
	bDrinks = drinks
	If on
		GoToState("Watching")
	Else
		GoToState("")
	EndIf
EndFunction

State Watching
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If bDrinks && (akBaseObject as Potion)
			(GetOwningQuest() as ODS_Main).OnPlayerConsumed(akBaseObject)
		EndIf
	EndEvent

	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If bFx && kFx && akEffect && kFx.Find(akEffect) >= 0
			(GetOwningQuest() as ODS_Main).OnFxApplied(GetActorReference(), akEffect)
		EndIf
	EndEvent
EndState
