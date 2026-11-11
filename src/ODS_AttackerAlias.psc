Scriptname ODS_AttackerAlias extends ReferenceAlias
{O'Deadly Skyrim: hitting or activating an attacker / partner stops the scene.}

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If akAggressor == Game.GetPlayer()
		(GetOwningQuest() as ODS_Main).Intervene()
	EndIf
EndEvent

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == Game.GetPlayer()
		(GetOwningQuest() as ODS_Main).Intervene()
	EndIf
EndEvent
