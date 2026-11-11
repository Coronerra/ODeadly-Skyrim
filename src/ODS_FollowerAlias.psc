Scriptname ODS_FollowerAlias extends ReferenceAlias
{O'Deadly Skyrim: events for a nearby follower (filled on location change, only while Defeat or Bathing is on).
0.2: the "Watching" state listens for Dirt and Blood / Bathing in Skyrim wash effects.}

MagicEffect[] kFx

Event OnEnterBleedout()
	(GetOwningQuest() as ODS_Main).OnActorBleedout(GetActorReference())
EndEvent

Function SetWatch(bool on, MagicEffect[] effects)
	kFx = effects
	If on
		GoToState("Watching")
	Else
		GoToState("")
	EndIf
EndFunction

State Watching
	Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
		If kFx && akEffect && kFx.Find(akEffect) >= 0
			(GetOwningQuest() as ODS_Main).OnFxApplied(GetActorReference(), akEffect)
		EndIf
	EndEvent
EndState
