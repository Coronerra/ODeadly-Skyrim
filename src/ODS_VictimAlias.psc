Scriptname ODS_VictimAlias extends ReferenceAlias
{O'Deadly Skyrim: activating a victim stops the scene.}

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == Game.GetPlayer()
		(GetOwningQuest() as ODS_Main).Intervene()
	EndIf
EndEvent
