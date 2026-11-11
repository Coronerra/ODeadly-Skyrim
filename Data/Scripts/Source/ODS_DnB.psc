Scriptname ODS_DnB Hidden
{O'Deadly Skyrim: soft interface to Dirt and Blood. Only called when "Dirt and Blood - Dynamic Visuals.esp" is loaded; never a master.}

Quest Function BathQuest() Global
	return Game.GetFormFromFile(0x00000DC3, "Dirt and Blood - Dynamic Visuals.esp") as Quest
EndFunction

; Dirty_BathingActors: every actor inside PlayBatheAnimation (real washes only; not swimming or rain)
FormList Function BathingActors() Global
	Dirty_BathingQuest q = BathQuest() as Dirty_BathingQuest
	If q
		return q.Dirty_BathingActors
	EndIf
	return None
EndFunction

; the effects of Dirty_SoapEffectSpell, applied by Lather at the start of every real wash
MagicEffect[] Function WashEffects() Global
	MagicEffect[] r = new MagicEffect[4]
	Dirty_BathingQuest q = BathQuest() as Dirty_BathingQuest
	If q == None || q.Dirty_SoapEffectSpell == None
		return r
	EndIf
	Spell s = q.Dirty_SoapEffectSpell
	int n = s.GetNumEffects()
	int i = 0
	While i < n && i < 4
		r[i] = s.GetNthEffectMagicEffect(i)
		i += 1
	EndWhile
	return r
EndFunction
