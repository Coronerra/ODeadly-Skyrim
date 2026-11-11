Scriptname ODS_AttackerAlias extends ReferenceAlias
{O'Deadly Skyrim: hitting or activating an attacker / partner stops the scene.
0.3: on the follower-rescue alias the same hit, activation or the attacker's death is the rescue.}

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If akAggressor == Game.GetPlayer()
		ODS_Main m = GetOwningQuest() as ODS_Main
		If m.IsRescueAlias(self)
			m.RescueOutcome(1)
		Else
			m.Intervene()
		EndIf
	EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == Game.GetPlayer()
		ODS_Main m = GetOwningQuest() as ODS_Main
		If m.IsRescueAlias(self)
			m.RescueOutcome(1)
		Else
			m.Intervene()
		EndIf
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	ODS_Main m = GetOwningQuest() as ODS_Main
	If m.IsRescueAlias(self)
		m.RescueOutcome(2)
	EndIf
EndEvent
