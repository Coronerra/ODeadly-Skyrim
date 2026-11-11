Scriptname ODS_Vamp Hidden
{O'Deadly Skyrim: vampirism hand-off. Only called when Sacrosanct is loaded; Sacrosanct overrides the vanilla
PlayerVampireQuest, so its own turning (VampireChange) is used instead of ours. Never a master.}

Function TurnPlayer(Actor player) Global
	PlayerVampireQuestScript q = Game.GetFormFromFile(0x000EAFD5, "Skyrim.esm") as PlayerVampireQuestScript
	If q
		q.VampireChange(player)
	EndIf
EndFunction
