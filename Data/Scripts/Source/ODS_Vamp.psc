Scriptname ODS_Vamp Hidden
{O'Deadly Skyrim: vampirism hand-off. Only called when Sacrosanct is loaded; Sacrosanct overrides the vanilla
PlayerVampireQuest, so its own turning (VampireChange) is used instead of ours. Never a master.}

Function TurnPlayer(Actor player) Global
	PlayerVampireQuestScript q = Game.GetFormFromFile(0x000EAFD5, "Skyrim.esm") as PlayerVampireQuestScript
	If q
		q.VampireChange(player)
	EndIf
EndFunction

; 1.1.1: caught from a vampire lord through sex: a full vampire at once (vanilla or Sacrosanct VampireChange),
; plus the Dawnguard Vampire Lord power the way Harkon's gift gives it
Function TurnPlayerLord(Actor player) Global
	Utility.Wait(1.0)
	PlayerVampireQuestScript q = Game.GetFormFromFile(0x000EAFD5, "Skyrim.esm") as PlayerVampireQuestScript
	If q
		q.VampireChange(player)
	EndIf
	If Game.GetModByName("Dawnguard.esm") != 255
		Spell lord = Game.GetFormFromFile(0x0000283B, "Dawnguard.esm") as Spell      ; DLC1VampireChange (Vampire Lord power)
		If lord && !player.HasSpell(lord)
			player.AddSpell(lord, false)
		EndIf
	EndIf
EndFunction
