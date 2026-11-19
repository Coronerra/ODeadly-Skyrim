Scriptname ODS_SatAlias extends ReferenceAlias
{O'Deadly Skyrim 1.0 Saturalia: Agrane Peryval's gift walk. The latent PathToReference calls run on
this alias's own thread; ODS_Main decides when and sends him home. No polling.}

ODS_Main Property Main Auto

Actor[] kTargets
bool bGo = false

Function Visit(Actor[] targets)
	kTargets = targets
	bGo = true
	RegisterForSingleUpdate(0.5)
EndFunction

Function Halt()
	bGo = false
	Actor[] noTargets          ; 1.1.1: assigning None to an array fails at run time
	kTargets = noTargets
	UnregisterForUpdate()
EndFunction

Event OnUpdate()
	Actor ag = GetActorReference()
	Actor[] ts = kTargets
	If !bGo || ag == None || !ts
		return
	EndIf
	int i = 0
	While i < ts.Length && bGo
		Actor t = ts[i]
		If t && Main.SatStillOK(ag, t)
			ag.PathToReference(t, 0.5)
			If bGo && Main.SatStillOK(ag, t) && ag.GetDistance(t) < 400.0
				Main.SatGive(ag, t)
				Utility.Wait(2.0)
			EndIf
		EndIf
		i += 1
	EndWhile
	If bGo
		bGo = false
		Main.SatVisitDone()
	EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	If aeCombatState != 0 && bGo
		bGo = false
		Main.SatVisitDone()
	EndIf
EndEvent
