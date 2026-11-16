Scriptname ODS_HeatWolfAlias extends ReferenceAlias
{O'Deadly Skyrim 1.0 "Bitch in Heat": one summoned werewolf. Event-only guard (no polling): any
combat start, hit or race change is handed straight back to ODS_Main, which calms the werewolf
again (or drops it). Arrival and departure each use one latent PathToReference on this alias's
own thread, plus one game-time safety timer while leaving.}

ODS_Main Property Main Auto

Actor kGoal
ObjectReference kDest
int iMode = 0          ; 1 walk in, 2 walk away

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	If aeCombatState != 0
		Main.HeatCalmWolf(GetActorReference())
	EndIf
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Main.HeatCalmWolf(GetActorReference())
EndEvent

Event OnRaceSwitchComplete()
	Main.HeatRaceChanged(GetActorReference())
EndEvent

Event OnDeath(Actor akKiller)
	Main.HeatWolfGone(self, true)
EndEvent

Function Approach(Actor goal)
	kGoal = goal
	iMode = 1
	RegisterForSingleUpdate(0.1)
EndFunction

Function Leave(ObjectReference dest)
	kDest = dest
	iMode = 2
	RegisterForSingleUpdate(0.5)
	RegisterForSingleUpdateGameTime(0.5)     ; safety: gone within half a game hour no matter what
EndFunction

Event OnUpdate()
	Actor a = GetActorReference()
	int m = iMode
	iMode = 0
	If a == None
		return
	EndIf
	If m == 1 && kGoal
		a.PathToReference(kGoal, 1.0)
	ElseIf m == 2 && kDest
		a.PathToReference(kDest, 0.6)
		Main.HeatWolfGone(self, false)
	EndIf
EndEvent

Event OnUpdateGameTime()
	If GetActorReference()
		Main.HeatWolfGone(self, true)
	EndIf
EndEvent
