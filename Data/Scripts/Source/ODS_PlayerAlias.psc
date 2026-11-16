Scriptname ODS_PlayerAlias extends ReferenceAlias
{O'Deadly Skyrim: game load, location change and bleedout events for the player. No polling.
0.5: one single update a few seconds after a load for the both-defeat-mods notice.
0.2: while Morning after or Bathing is on, the "Watching" state also listens for drinks and wash effects.
1.0: OnRaceSwitchComplete (an event, not polling) starts a short, bounded single-update chain only while
the player is in werewolf / vampire lord form and the Beast Form offers are on.}

MagicEffect[] kFx
bool bFx = false
bool bDrinks = false

Event OnPlayerLoadGame()
	bBeastTick = false                ; 1.0: a beast-form chain never survives a load
	(GetOwningQuest() as ODS_Main).OnGameLoaded()
	RegisterForSingleUpdate(8.0)      ; 0.5: one late check once the HUD is up
EndEvent

; 0.5: single update after a load only (never re-registered): both defeat mods installed?
; 1.0: or, while bBeastTick, the next beast-form offer check (ODS_Main returns the next delay, 0 = stop)
Event OnUpdate()
	If bBeastTick
		float d = (GetOwningQuest() as ODS_Main).BeastOfferTick()
		If d > 0.0
			RegisterForSingleUpdate(d)
		Else
			bBeastTick = false
		EndIf
		return
	EndIf
	(GetOwningQuest() as ODS_Main).BothDefeatsWarn()
EndEvent

; 1.0: transformed into / out of werewolf or vampire lord form
Event OnRaceSwitchComplete()
	float d = (GetOwningQuest() as ODS_Main).OnPlayerRaceSwitch()
	If d > 0.0
		StartBeastTick(d)
	Else
		bBeastTick = false
	EndIf
EndEvent

Function StartBeastTick(float delay)
	bBeastTick = true
	RegisterForSingleUpdate(delay)
EndFunction

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

; 1.0 (appended)
bool bBeastTick = false
