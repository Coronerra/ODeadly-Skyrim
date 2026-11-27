Scriptname ODS_Heat extends Quest
{O'Deadly Skyrim 1.2.0 module: Bitch in Heat (beasts answer and join a scene with the player), moved out of ODS_Main. Attached to ODS_MainQuest next to ODS_Main. It keeps NO saved state of its own: every variable it uses still lives in ODS_Main and is reached through the mv_ accessor properties; settings are ODS_Main's own properties. A long wait here no longer holds the ODS_Main script lock. By That Guy (Coronerra).}

; Behaviour is unchanged from 1.1.8 plus the 1.2.0 part A "Joining beasts" choice (iHeatJoinKind) and
; the final SceneHasMinor sweep in HeatStartScene. Every IsMinor() call of the old code is kept.

bool bWarned = false            ; new in 1.2.0 (module only logs a missing ODS_Main once per load)

ODS_Main Property M
	ODS_Main Function Get()
		return (Self as Quest) as ODS_Main
	EndFunction
EndProperty

bool Function Ok()
	If M
		return true
	EndIf
	If !bWarned
		bWarned = true
		Debug.Trace("[ODeadlySkyrim] ODS_Heat: ODS_Main is not on this quest (mismatched ESP?); Bitch in Heat does nothing")
	EndIf
	return false
EndFunction

ODS_HeatWolfAlias Function HeatAlias(int i)
	If !Ok()
		return None
	EndIf
	If i == 0
		return M.HeatWolf1Alias as ODS_HeatWolfAlias
	ElseIf i == 1
		return M.HeatWolf2Alias as ODS_HeatWolfAlias
	EndIf
	return M.HeatWolf3Alias as ODS_HeatWolfAlias
EndFunction

; ---------- 1.1.5: which beast, and how they join ----------
; 1.1.5: any male beast in FULL beast form counts (werewolf, werebear, vampire lord); human-form
; werewolves and vampires never do. Werewolves (and werebears with OStim Beast Form's "werebears
; use werewolf scenes" toggle) join one group scene; vampire lords (no group scenes exist) and
; werebears without the toggle take turns, one pair scene after another.

; 1 werewolf, 2 vampire lord, 3 werebear, 0 not in full beast form
int Function HeatKindOf(Actor a)
	If !Ok()
		return 0
	EndIf
	If a == None
		return 0
	ElseIf M.IsWerewolfForm(a)
		return 1
	ElseIf M.IsVampireLordForm(a)
		return 2
	ElseIf M.IsWerebearForm(a)
		return 3
	EndIf
	return 0
EndFunction

; OStim Beast Form (Core C) toggle "werebears use werewolf scenes" (GLOB OBL_WerebearAsWerewolf)
bool Function HeatBearAsWolf()
	If !Ok()
		return false
	EndIf
	If !M.ModLoaded("OStim_Beast_Form_Merged.esp")
		return false
	EndIf
	GlobalVariable g = Game.GetFormFromFile(0x00000839, "OStim_Beast_Form_Merged.esp") as GlobalVariable
	return g && g.GetValue() >= 1.0
EndFunction

string Function HeatCallWord(int kind)
	If kind == 2
		return "the shrieks"
	ElseIf kind == 3
		return "the roars"
	EndIf
	return "the howls"
EndFunction

string Function HeatKindCount(int kind, int n)
	If n == 1
		return "a " + M.FormWord(kind)
	EndIf
	If kind == 2
		return HeatNumber(n) + " vampire lords"
	ElseIf kind == 3
		return HeatNumber(n) + " werebears"
	EndIf
	return HeatNumber(n) + " werewolves"
EndFunction

; "two werewolves and a werebear"
string Function HeatPackWords()
	If !Ok()
		return ""
	EndIf
	string s = ""
	int parts = 0
	If M.mv_iHeatWW > 0
		s = HeatKindCount(1, M.mv_iHeatWW)
		parts += 1
	EndIf
	If M.mv_iHeatBear > 0
		If parts > 0
			s += " and "
		EndIf
		s += HeatKindCount(3, M.mv_iHeatBear)
		parts += 1
	EndIf
	If M.mv_iHeatVL > 0
		If parts > 0
			s += " and "
		EndIf
		s += HeatKindCount(2, M.mv_iHeatVL)
		parts += 1
	EndIf
	If parts == 0
		return "other beasts"
	EndIf
	return s
EndFunction

; ---------- group scenes (actor order: beasts first, the human last = the centre) ----------
; Werewolf and Vampire Lord OStim 0.3.1 first (hubs, then the Billyy scenes), OStim Beast Form,
; Billyy, OCreatures last. Male-centre IDs only exist with WVL's male partner scenes installed.
string Function HeatCandidate(bool female, int n, int i)
	If female
		If n == 1
			If i == 0
				return "WVLWWWerewolfHubFMMC2"
			ElseIf i == 1
				return "OBFWerewolfIdleFMM"
			ElseIf i == 2
				return "WVLAnubswwf-1"
			ElseIf i == 3
				return "WVLBWWB3pCG-1"
			ElseIf i == 4
				return "WVLBWWB3pDP2-1"
			ElseIf i == 5
				return "WVLBWWB3pHoldDP-1"
			ElseIf i == 6
				return "WVLBWWB3pDogSpit-1"
			ElseIf i == 7
				return "WVLBWWB3pHang2-1"
			ElseIf i == 8
				return "WVLBWWB3pStandSpit-1"
			ElseIf i == 9
				return "BillyyWerewolfHubFMM"
			ElseIf i == 10
				return "OCrWerewolfIdleFMM"
			EndIf
		ElseIf n == 2
			If i == 0
				return "WVLWWWerewolfHubFMMMC3"
			ElseIf i == 1
				return "OBFWerewolfIdleFMMM"
			ElseIf i == 2
				return "WVLBWWB4pGB1-1"
			ElseIf i == 3
				return "BillyyWerewolfHubFMMM"
			ElseIf i == 4
				return "OCrWerewolfIdleFMMM"
			EndIf
		ElseIf n == 3
			If i == 0
				return "WVLWWWerewolfHubFMMMMC4"
			ElseIf i == 1
				return "OBFWerewolfIdleFMMMM"
			ElseIf i == 2
				return "WVLBWWB5pGB1-1"
			ElseIf i == 3
				return "BillyyWerewolfHubFMMMM"
			ElseIf i == 4
				return "OCrWerewolfIdleFMMMM"
			EndIf
		EndIf
	Else
		If n == 1
			If i == 0
				return "WVLWWMWerewolfHubMMMC2"
			ElseIf i == 1
				return "WVLIdleWWMWerewolfMMMC2"
			ElseIf i == 2
				return "WVLAnubswwfM-1"
			ElseIf i == 3
				return "WVLBWWB3pCGM-1"
			ElseIf i == 4
				return "WVLBWWB3pDP2M-1"
			ElseIf i == 5
				return "WVLBWWB3pHoldDPM-1"
			ElseIf i == 6
				return "WVLBWWB3pDogSpitM-1"
			ElseIf i == 7
				return "WVLBWWB3pHang2M-1"
			ElseIf i == 8
				return "WVLBWWB3pStandSpitM-1"
			EndIf
		ElseIf n == 2
			If i == 0
				return "WVLWWMWerewolfHubMMMMC3"
			ElseIf i == 1
				return "WVLIdleWWMWerewolfMMMMC3"
			ElseIf i == 2
				return "WVLBWWB4pGB1M-1"
			EndIf
		ElseIf n == 3
			If i == 0
				return "WVLWWMWerewolfHubMMMMMC4"
			ElseIf i == 1
				return "WVLIdleWWMWerewolfMMMMMC4"
			ElseIf i == 2
				return "WVLBWWB5pGB1M-1"
			EndIf
		EndIf
	EndIf
	return ""
EndFunction

; installed for this many summoned beasts (n+1 beasts + 1 human)?
bool Function HeatCountOK(bool female, int n)
	int i = 0
	While i < 11
		string id = HeatCandidate(female, n, i)
		If id != "" && OMetaData.GetActorCount(id) == n + 2
			return true
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

; the real cast: first listed scene OStim accepts for these actors, else any scene for them
string Function HeatPickScene(Actor[] acts, bool female, int n)
	int i = 0
	While i < 11
		string id = HeatCandidate(female, n, i)
		If id != "" && OMetaData.GetActorCount(id) == acts.Length
			string[] ok = OLibrary.GetScenesInRange(id, acts, 1)
			If ok && ok.Length > 0
				return id
			EndIf
		EndIf
		i += 1
	EndWhile
	string r = OLibrary.GetRandomSceneWithAnySceneTagCSV(acts, "werewolf,beast,creature")
	If r == ""
		r = OLibrary.GetRandomScene(acts)
	EndIf
	return r
EndFunction

; ---------- 1.1.5: pair scenes for taking turns (beast first, the human last) ----------
string Function HeatPairCandidate(int kind, bool female, int i)
	If kind == 2
		If female
			If i == 0
				return "WVLVLVampireLordHubFMC1"
			ElseIf i == 1
				return "OBFVampireLordIdleMF"
			EndIf
		ElseIf i == 0
			return "WVLVLMVampireLordHubMMC1"
		ElseIf i == 1
			return "WVLIdleVLMVampireLordMMC1"
		EndIf
		return ""
	EndIf
	If kind == 3 && !HeatBearAsWolf()
		return ""          ; werebears fit the werewolf scenes only with Beast Form's toggle on
	EndIf
	If female
		If i == 0
			return "WVLWWWerewolfHubFMC1"
		ElseIf i == 1
			return "OBFWerewolfIdleMF"
		EndIf
	ElseIf i == 0
		return "WVLWWMWerewolfHubMMC1"
	ElseIf i == 1
		return "WVLIdleWWMWerewolfMMC1"
	EndIf
	return ""
EndFunction

; a pair scene for this kind is installed (OCreatures as the last resort, female centre only)
bool Function HeatTurnsOK(int kind, bool female)
	int i = 0
	While i < 2
		string id = HeatPairCandidate(kind, female, i)
		If id != "" && OMetaData.GetActorCount(id) == 2
			return true
		EndIf
		i += 1
	EndWhile
	return female && M.OCreaturesInstalled()
EndFunction

string Function HeatPairScene(Actor[] acts, int kind, bool female)
	int i = 0
	While i < 2
		string id = HeatPairCandidate(kind, female, i)
		If id != "" && OMetaData.GetActorCount(id) == 2
			string[] ok = OLibrary.GetScenesInRange(id, acts, 1)
			If ok && ok.Length > 0
				return id
			EndIf
		EndIf
		i += 1
	EndWhile
	string tags = "werewolf,beast,creature"
	If kind == 2
		tags = "vampirelord,vampire lord,beast,creature"
	ElseIf kind == 3
		tags = "werebear,beast,creature"
	EndIf
	string r = OLibrary.GetRandomSceneWithAnySceneTagCSV(acts, tags)
	If r == ""
		r = OLibrary.GetRandomScene(acts)
	EndIf
	return r
EndFunction

; ---------- the guard: non-hostile, never an ally, never a teammate ----------
Function HeatPacify(Actor w)
	If !Ok()
		return
	EndIf
	If w == None
		return
	EndIf
	w.RemoveFromAllFactions()                  ; drops WerewolfFaction / CreatureFaction
	If M.ODS_HeatPackFaction
		w.AddToFaction(M.ODS_HeatPackFaction)
	EndIf
	w.SetActorValue("Aggression", 0.0)         ; unaggressive: never starts a fight
	w.SetActorValue("Confidence", 0.0)         ; cowardly: walks away from one instead
	w.SetActorValue("Assistance", 0.0)         ; helps nobody, so never joins your fights
	w.IgnoreFriendlyHits(true)
	w.SetPlayerTeammate(false)
	w.StopCombat()
	w.StopCombatAlarm()
EndFunction

Function HeatFactionSetup()
	If !Ok()
		return
	EndIf
	If M.ODS_HeatPackFaction == None
		return
	EndIf
	; mutual "friend" (not ally): nobody fights, and the werewolves never assist in combat
	M.ODS_HeatPackFaction.SetAlly(M.PlayerFaction, true, true)
	If M.CurrentFollowerFaction
		M.ODS_HeatPackFaction.SetAlly(M.CurrentFollowerFaction, true, true)
	EndIf
	If M.PlayerFollowerFaction
		M.ODS_HeatPackFaction.SetAlly(M.PlayerFollowerFaction, true, true)
	EndIf
	If M.PlayerWerewolfFaction
		M.ODS_HeatPackFaction.SetAlly(M.PlayerWerewolfFaction, true, true)
	EndIf
EndFunction

; alias events: combat start or a hit -> calm again at once
Function HeatCalmWolf(Actor w)
	If !Ok()
		return
	EndIf
	If w == None || !M.mv_kHeatWolves || M.mv_kHeatWolves.Find(w) < 0
		return
	EndIf
	HeatPacify(w)
	M.PlayerRef.StopCombatAlarm()
	Actor[] near = OActorUtil.GetActorsInRangeV2(w, 3000.0, false, false, false)
	int i = 0
	While i < near.Length
		If near[i] && (near[i] == M.PlayerRef || M.IsFollowerActor(near[i])) && near[i].GetCombatTarget() == w
			near[i].StopCombat()
		EndIf
		i += 1
	EndWhile
EndFunction

; a summoned beast that is not in full beast form any more is never used: drop it
Function HeatRaceChanged(Actor w)
	If !Ok()
		return
	EndIf
	If w == None || !M.mv_kHeatWolves || M.mv_kHeatWolves.Find(w) < 0
		return
	EndIf
	If HeatKindOf(w) == 0
		M.Log("heat: a summoned beast left beast form - removed")
		int i = M.mv_kHeatWolves.Find(w)
		M.mv_kHeatWolves[i] = None
		w.Disable(false)
		w.Delete()
		ODS_HeatWolfAlias al = HeatAlias(i)
		If al
			al.Clear()
		EndIf
		If M.mv_iHeatLeft > 0
			M.mv_iHeatLeft = M.mv_iHeatLeft - 1
			If M.mv_iHeatLeft == 0 && M.mv_iHeatThread < 0
				HeatFinish()
			EndIf
		EndIf
	EndIf
EndFunction

; 1.1.5: the kind for one summoned slot. Werewolf and werebear packs can mix when Beast Form lets
; werebears use the werewolf scenes (about one answer in three is the other kind). Never for turns.
int Function HeatSlotKind(int bk, bool turns)
	int jk = M.iHeatJoinKind
	If jk >= 1 && jk <= 3 && !turns && bk != 2
		return HeatChosenKind(bk, jk)
	EndIf
	If turns || bk == 2 || !HeatBearAsWolf() || M.WerebearRace() == None
		return bk
	EndIf
	If Utility.RandomInt(0, 2) == 0
		If bk == 1
			return 3
		EndIf
		return 1
	EndIf
	return bk
EndFunction

; 1.2.0: the MCM "Joining beasts" choice (jk 1 werewolves only, 2 werebears only, 3 mixed pack) for
; one summoned slot in a group scene whose first beast is a werewolf (bk 1) or werebear (bk 3).
; Falls back to werewolves when no werebear race exists, and to the first beast's own kind (the
; 1.1.8 behaviour) when the other kind could not share the scene; every fallback is logged.
int Function HeatChosenKind(int bk, int jk)
	int want = 1
	If jk == 2
		want = 3
	ElseIf jk == 3
		want = 0          ; mixed: decided per slot below
	EndIf
	If jk >= 2 && M.WerebearRace() == None
		M.Log("heat: joining beasts '" + HeatJoinKindText() + "' needs werebears (Dragonborn) - werewolves join instead")
		want = 1
		jk = 1
	EndIf
	If jk == 3
		; a mixed pack: about half werewolves, half werebears, per slot
		want = 1
		If Utility.RandomInt(0, 1) == 1
			want = 3
		EndIf
	EndIf
	If want != bk && !HeatBearAsWolf()
		M.Log("heat: joining beasts '" + HeatJoinKindText() + "': a " + M.FormWord(want) + " cannot share a group scene with a " + M.FormWord(bk) + " (OStim Beast Form 'werebears use werewolf scenes' is off) - matching the first beast")
		return bk
	EndIf
	return want
EndFunction

string Function HeatJoinKindText()
	If !Ok()
		return ""
	EndIf
	If M.iHeatJoinKind == 1
		return "Werewolves only"
	ElseIf M.iHeatJoinKind == 2
		return "Werebears only"
	ElseIf M.iHeatJoinKind == 3
		return "Mixed pack"
	EndIf
	return "Match the first beast"
EndFunction

; 1.1.5 pools: werewolves EncWerewolf01-06 (ODS_PoolHeatWolf), werebears Dragonborn DLC2EncWerebear,
; vampire lords: male vampire boss bases (Skyrim.esm) changed to the Dawnguard vampire lord race
; while still disabled (the game has no generic vampire lord NPCs)
Form Function HeatPoolPick(int kind)
	If !Ok()
		return None
	EndIf
	If kind == 3
		return Game.GetFormFromFile(0x000322B1, "Dragonborn.esm")
	ElseIf kind == 2
		int r = Utility.RandomInt(0, 9)
		int fid = 0x0002E1E2
		If r == 1
			fid = 0x0002E1FC
		ElseIf r == 2
			fid = 0x0002E519
		ElseIf r == 3
			fid = 0x0002EA9E
		ElseIf r == 4
			fid = 0x0002EAC1
		ElseIf r == 5
			fid = 0x0003377B
		ElseIf r == 6
			fid = 0x0003377C
		ElseIf r == 7
			fid = 0x00033828
		ElseIf r == 8
			fid = 0x0002E1DC
		ElseIf r == 9
			fid = 0x0002E1F1
		EndIf
		return Game.GetFormFromFile(fid, "Skyrim.esm")
	EndIf
	If M.ODS_PoolHeatWolf == None || M.ODS_PoolHeatWolf.GetSize() == 0
		return None
	EndIf
	return M.ODS_PoolHeatWolf.GetAt(Utility.RandomInt(0, M.ODS_PoolHeatWolf.GetSize() - 1))
EndFunction

; spawn one beast, disabled, just out of sight behind the player; verified and calmed before Enable
Actor Function HeatSpawnBeast(Actor anchor, int ep, int kind)
	If !Ok()
		return None
	EndIf
	Race vl = None
	If kind == 2
		vl = M.VampireLordRace()
		If vl == None
			return None
		EndIf
	ElseIf kind == 3 && M.WerebearRace() == None
		return None
	EndIf
	int t = 0
	While t < 4 && M.Alive(ep)
		Form base = HeatPoolPick(kind)
		Actor a = None
		If base
			a = anchor.PlaceAtMe(base, 1, false, true) as Actor
		EndIf
		If a
			bool male = a.GetLeveledActorBase().GetSex() == 0
			If kind == 2 && male && !M.IsMinor(a)
				a.UnequipAll()
				a.SetRace(vl)          ; still disabled: it is first drawn as a vampire lord
			EndIf
			If HeatKindOf(a) == kind && male && !M.IsMinor(a)
				float ang = M.PlayerRef.GetAngleZ() + 180.0 + Utility.RandomFloat(-50.0, 50.0)
				float dist = Utility.RandomFloat(1500.0, 2200.0)
				a.SetPosition(M.PlayerRef.GetPositionX() + Math.sin(ang) * dist, M.PlayerRef.GetPositionY() + Math.cos(ang) * dist, M.PlayerRef.GetPositionZ())
				PO3_SKSEFunctions.MoveToNearestNavmeshLocation(a)
				HeatPacify(a)          ; before it ever gets an AI tick
				return a
			EndIf
			M.Log("heat: spawn was not a male " + M.FormWord(kind) + " in beast form (" + M.FormText(base) + ", race " + M.FormText(a.GetRace()) + ") - discarded")
			a.Delete()
		ElseIf base == None
			M.Log("heat: no " + M.FormWord(kind) + " base form found")
			return None
		EndIf
		t += 1
	EndWhile
	return None
EndFunction

bool Function HeatPlaceOK()
	If !Ok()
		return false
	EndIf
	If !M.IsOutdoors()
		return false
	EndIf
	Location loc = M.PlayerRef.GetCurrentLocation()
	return !(M.TreeHasKW(loc, "LocTypeCity") || M.TreeHasKW(loc, "LocTypeTown"))
EndFunction

; ---------- trigger: OnOStimThreadStart ----------
Function HeatCheck(int id)
	If !Ok()
		return
	EndIf
	If !M.bHeat || !M.Ready() || M.mv_bHeatOn || M.mv_bRescueOn || id < 0 || !M.OStimOK()
		return
	EndIf
	If M.ODS_HeatQuest == None || M.ODS_HeatQuest.IsRunning()
		return
	EndIf
	If M.bBusy && id != M.mv_iThread
		return
	EndIf
	Actor[] acts = OThread.GetActors(id)
	If !acts || acts.Length != 2 || acts.Find(M.PlayerRef) < 0
		return
	EndIf
	Actor beast = None
	Actor human = None
	int k0 = HeatKindOf(acts[0])
	int k1 = HeatKindOf(acts[1])
	If k0 > 0 && k1 == 0
		beast = acts[0]
		human = acts[1]
	ElseIf k1 > 0 && k0 == 0
		beast = acts[1]
		human = acts[0]
	EndIf
	If beast == None || human == None || M.IsMinor(beast) || M.IsMinor(human) || !M.IsHumanoid(human)
		return       ; nobody in full beast form (human-form werewolves / vampires do not count)
	EndIf
	int bk = HeatKindOf(beast)
	string bw = M.FormWord(bk)
	If beast.GetLeveledActorBase().GetSex() != 0
		M.Log("heat: " + bw + " scene, but the " + bw + " is female - skipped")
		return      ; the beast places in these scenes are male
	EndIf
	If !HeatPlaceOK()
		M.Log("heat: " + bw + " scene, but not a wilderness place - skipped")
		return
	EndIf
	If !M.bForceHeat && Utility.RandomFloat(0.0, 100.0) >= M.fHeatChance
		M.Log("heat: " + bw + " scene, chance roll missed (" + M.fHeatChance + "%)")
		return
	EndIf
	bool female = human.GetLeveledActorBase().GetSex() == 1
	; 1.1.6: no in-game box (it clashed with OStim's own menu at scene start). The count comes
	; from the MCM ("How many join": 1, 2, 3 or 0 = random 1-3); a count without an installed
	; scene for this cast falls back silently to the nearest one that has one.
	bool turns = false
	bool ok1 = false
	bool ok2 = false
	bool ok3 = false
	bool bearWolf = HeatBearAsWolf()
	If bk == 1 || (bk == 3 && bearWolf)
		ok1 = HeatCountOK(female, 1)
		ok2 = HeatCountOK(female, 2)
		ok3 = HeatCountOK(female, 3)
	EndIf
	If !ok1 && !ok2 && !ok3
		If bk == 1
			M.Log("heat: werewolf scene, no installed multi-werewolf scene for a " + HeatSexWord(female) + " centre - skipped")
			return
		EndIf
		If !HeatTurnsOK(bk, female)
			M.Log("heat: " + bw + " scene, no installed pair scene for a " + bw + " with a " + HeatSexWord(female) + " centre (werebears use werewolf scenes " + M.YesNo(bearWolf) + ", OCreatures " + M.YesNo(M.OCreaturesInstalled()) + ") - skipped")
			return
		EndIf
		turns = true
		ok1 = true
		ok2 = true
		ok3 = true
	EndIf
	M.bForceHeat = false
	int want = M.iHeatJoin
	If want < 0 || want > 3
		want = 0
	EndIf
	int n = 0
	If want == 0
		int[] pick = new int[3]
		int k = 0
		If ok1
			pick[k] = 1
			k += 1
		EndIf
		If ok2
			pick[k] = 2
			k += 1
		EndIf
		If ok3
			pick[k] = 3
			k += 1
		EndIf
		n = pick[Utility.RandomInt(0, k - 1)]
		M.Log("heat: how many join: random 1-3 -> " + n + " (installed counts: 1 " + M.YesNo(ok1) + ", 2 " + M.YesNo(ok2) + ", 3 " + M.YesNo(ok3) + ")")
	Else
		n = HeatNearestCount(want, ok1, ok2, ok3)
		If n != want
			M.Log("heat: how many join: MCM says " + want + ", no installed scene for that cast - using " + n + " (installed counts: 1 " + M.YesNo(ok1) + ", 2 " + M.YesNo(ok2) + ", 3 " + M.YesNo(ok3) + ")")
		Else
			M.Log("heat: how many join: " + n + " (MCM)")
		EndIf
	EndIf
	If n <= 0 || !M.Ready() || !OThread.IsRunning(id)
		M.Log("heat: " + bw + " scene, nobody called (choice " + n + ")")
		return
	EndIf
	string mode = "one group scene"
	If turns
		mode = "taking turns in pair scenes"
	EndIf
	M.Log("heat: " + bw + " scene " + id + " (" + M.NameOf(beast) + " with " + M.NameOf(human) + "), " + n + " answer, " + mode + " (werebears use werewolf scenes " + M.YesNo(bearWolf) + ")")
	HeatRun(id, beast, human, n, female, bk, turns)
EndFunction

string Function HeatJoinText()
	If !Ok()
		return ""
	EndIf
	If M.iHeatJoin >= 1 && M.iHeatJoin <= 3
		return "" + M.iHeatJoin
	EndIf
	return "random 1-3"
EndFunction

; 1.1.6: Bitch in Heat text (1.1.7: also Caught and Watched, all at OStim scene start): a corner
; notification (unless messages are off), never a message box
Function HeatNote(string t)
	If !Ok()
		return
	EndIf
	If M.bMaster && M.iMsgStyle != 2
		Debug.Notification(t)
	EndIf
EndFunction

; 1.1.6: the installed count nearest to the wanted one (a tie goes to the smaller count)
int Function HeatNearestCount(int want, bool ok1, bool ok2, bool ok3)
	int d = 0
	While d < 3
		int lo = want - d
		int hi = want + d
		If (lo == 1 && ok1) || (lo == 2 && ok2) || (lo == 3 && ok3)
			return lo
		EndIf
		If (hi == 1 && ok1) || (hi == 2 && ok2) || (hi == 3 && ok3)
			return hi
		EndIf
		d += 1
	EndWhile
	return 0
EndFunction

string Function HeatSexWord(bool female)
	If female
		return "female"
	EndIf
	return "male"
EndFunction

; 1.1.5: start one heat scene; our own encounter carries on in it
int Function HeatStartScene(Actor[] acts, string sc, bool own)
	If !Ok()
		return -1
	EndIf
	int b = OThreadBuilder.Create(acts)
	int t = -1
	If b >= 0
		OThreadBuilder.SetStartingAnimation(b, sc)
		If own
			float mn = M.fMinDuration
			float mx = M.fMaxDuration
			If mx < mn
				mx = mn
			EndIf
			OThreadBuilder.SetDuration(b, Utility.RandomFloat(mn, mx))
		EndIf
		OThreadBuilder.UndressActors(b)
		OThreadBuilder.NoFurniture(b)
		OThreadBuilder.SetMetadataCSV(b, "odangerous,beastform,heat")
		If M.SceneHasMinor(acts, None, "HeatStartScene")
			OThreadBuilder.Cancel(b)      ; t stays -1: the callers' failure paths run (they leave)
		Else
			M.mv_iHeatThread = -2           ; the start event of our own scene is ignored
			t = OThreadBuilder.Start(b)
		EndIf
	EndIf
	M.mv_iHeatThread = t
	If t >= 0 && own
		M.mv_iThread = t
		M.mv_kSceneActs = acts
		M.mv_sScene1 = sc
	EndIf
	return t
EndFunction

; 1.1.5: first summoned slot from k on that can still take a turn
int Function HeatNextTurn(int k)
	While k < 3
		Actor w = M.mv_kHeatWolves[k]
		If w && !w.IsDead() && HeatKindOf(w) > 0
			return k
		EndIf
		k += 1
	EndWhile
	return -1
EndFunction

; 1.1.5: one summoned beast takes his turn with the human
int Function HeatStartTurn(int k, bool own)
	Actor w = M.mv_kHeatWolves[k]
	Actor[] acts = M.NewActorArray(2)
	acts[0] = w
	acts[1] = M.mv_kHeatHuman
	int kind = HeatKindOf(w)
	string sc = HeatPairScene(acts, kind, M.mv_bHeatFemale)
	If sc == ""
		M.Log("heat: turn " + (k + 1) + ": OStim has no pair scene for this " + M.FormWord(kind))
		return -1
	EndIf
	HeatPacify(w)
	int t = HeatStartScene(acts, sc, own)
	If t < 0
		M.Log("heat: turn " + (k + 1) + ": the scene did not start (" + sc + ")")
		return -1
	EndIf
	bool first = M.mv_iHeatTurn < 0
	M.mv_iHeatTurn = k
	If !first
		M.TalkNet(ODS_Text.T("heat.turn_next", "The next {x1} takes a turn with {x2}.", "", "", "", "", M.FormWord(kind), M.mv_kHeatHuman.GetDisplayName()), w, M.mv_kHeatHuman, true, false)
	EndIf
	M.Log("heat: turn " + (k + 1) + ": a " + M.FormWord(kind) + " with " + M.NameOf(M.mv_kHeatHuman) + ", scene " + sc + " thread " + t + ", own encounter " + M.YesNo(own))
	return t
EndFunction

; 1.1.5: OnOStimThreadEnd of a turn: true = the next turn started (the event stops there)
bool Function HeatTurnNext(int id)
	If !Ok()
		return false
	EndIf
	If !M.mv_bHeatOn || !M.mv_bHeatTurns || M.mv_kHeatHuman == None || M.mv_kHeatHuman.IsDead() || !M.Alive(M.mv_iHeatEp)
		return false
	EndIf
	int k = HeatNextTurn(M.mv_iHeatTurn + 1)
	If k < 0
		M.Log("heat: all turns done")
		return false
	EndIf
	bool own = id >= 0 && id == M.mv_iThread
	M.mv_iHeatThread = -2
	Utility.Wait(1.0)
	If !M.Alive(M.mv_iHeatEp) || !M.mv_bHeatOn
		M.mv_iHeatThread = -1
		return false
	EndIf
	int t = HeatStartTurn(k, own)
	If t < 0
		M.mv_iHeatThread = -1
		return false
	EndIf
	return true
EndFunction

Function HeatRun(int id, Actor beast, Actor human, int n, bool female, int bk, bool turns)
	If !Ok()
		return
	EndIf
	M.mv_bHeatOn = true
	M.mv_iHeatEp = M.mv_iEpoch
	int ep = M.mv_iHeatEp
	M.mv_bHeatOwnsBusy = !M.bBusy
	M.bBusy = true
	M.mv_kHeatBeast = beast
	M.mv_kHeatHuman = human
	M.mv_kHeatWolves = new Actor[3]
	M.mv_iHeatCount = 0
	M.mv_iHeatKind = bk
	M.mv_bHeatTurns = turns
	M.mv_bHeatFemale = female
	M.mv_iHeatTurn = -1
	M.mv_iHeatWW = 0
	M.mv_iHeatVL = 0
	M.mv_iHeatBear = 0
	HeatFactionSetup()
	M.ODS_HeatQuest.Start()
	int w8 = 0
	While !M.ODS_HeatQuest.IsRunning() && w8 < 10
		Utility.Wait(0.2)
		w8 += 1
	EndWhile
	If !M.ODS_HeatQuest.IsRunning()
		M.Log("heat: helper quest did not start")
		HeatFinish()
		return
	EndIf
	int i = 0
	While i < n && M.Alive(ep)
		int sk = HeatSlotKind(bk, turns)
		Actor w = HeatSpawnBeast(human, ep, sk)
		If w == None && sk != bk
			sk = bk
			w = HeatSpawnBeast(human, ep, sk)
		EndIf
		If w == None
			M.Log("heat: could not get a " + M.FormWord(sk) + " in beast form - event skipped")
			HeatDeleteAll()
			HeatFinish()
			return
		EndIf
		M.mv_kHeatWolves[i] = w
		M.mv_iHeatCount = M.mv_iHeatCount + 1
		If sk == 2
			M.mv_iHeatVL = M.mv_iHeatVL + 1
		ElseIf sk == 3
			M.mv_iHeatBear = M.mv_iHeatBear + 1
		Else
			M.mv_iHeatWW = M.mv_iHeatWW + 1
		EndIf
		HeatAlias(i).ForceRefTo(w)
		w.Enable(false)
		HeatPacify(w)
		M.Log("heat: summoned a " + M.FormWord(sk) + " (slot " + (i + 1) + ", " + M.FormText(w.GetLeveledActorBase()) + ")")
		i += 1
	EndWhile
	If !M.Alive(ep)
		HeatDeleteAll()
		HeatFinish()
		return
	EndIf
	string where = M.WhereName()
	string bn = beast.GetDisplayName()
	string hn = human.GetDisplayName()
	bn = ODS_Text.T("heat.beast_ref", "{x1}, a {x2},", "", "", "", "", bn, M.FormWord(bk))
	string pack = HeatPackWords()
	If turns
		M.TalkNet(ODS_Text.T("heat.run_turns", "Near {where}, {x1} and {x2} with {vn}: {x3} come.", "", "", hn, where, HeatCallWord(bk), bn, pack), beast, human, true, false)
	Else
		M.TalkNet(ODS_Text.T("heat.run_pack", "Near {where}, {x1} and {x2} with {vn}: {x3} join, {an} in all.", "", HeatNumber(n + 1), hn, where, HeatCallWord(bk), bn, pack), beast, human, true, false)
	EndIf
	; 1.1.6: never a message box here (it would sit on top of OStim's menu): corner notification only
	If bk == 2
		HeatNote(ODS_Text.T("heat.note_vl", "Wings beat in the dark."))
	ElseIf bk == 3
		HeatNote(ODS_Text.T("heat.note_bear", "Roars answer from the wilds."))
	Else
		HeatNote(ODS_Text.T("heat.note_wolf", "Howls answer from the wilds."))
	EndIf
	i = 0
	While i < n
		HeatAlias(i).Approach(human)
		i += 1
	EndWhile
	; bounded walk-in: up to 25 s, then OStim places everyone anyway
	int waited = 0
	bool near = false
	While waited < 25 && !near && M.Alive(ep) && OThread.IsRunning(id)
		Utility.Wait(1.0)
		waited += 1
		near = true
		i = 0
		While i < n
			If M.mv_kHeatWolves[i] == None || M.mv_kHeatWolves[i].GetDistance(human) > 450.0
				near = false
			EndIf
			i += 1
		EndWhile
	EndWhile
	If !M.Alive(ep)
		HeatDeleteAll()
		HeatFinish()
		return
	EndIf
	; final guarantee before the scene: every summoned beast still alive, in beast form, calm
	Actor[] acts = M.NewActorArray(n + 2)
	acts[0] = beast
	i = 0
	While i < n
		Actor w = M.mv_kHeatWolves[i]
		If w == None || w.IsDead() || HeatKindOf(w) == 0
			M.Log("heat: a summoned beast is not usable - they leave")
			HeatLeave()
			return
		EndIf
		HeatPacify(w)
		acts[i + 1] = w
		i += 1
	EndWhile
	acts[n + 1] = human
	If !OThread.IsRunning(id)
		M.Log("heat: the first scene already ended - they leave")
		HeatLeave()
		return
	EndIf
	string sc = ""
	If !turns
		sc = HeatPickScene(acts, female, n)
		If sc == ""
			If HeatTurnsOK(1, female) || HeatTurnsOK(bk, female)
				turns = true
				M.mv_bHeatTurns = true
				M.Log("heat: OStim has no group scene for this cast - they take turns instead")
			Else
				M.Log("heat: OStim has no scene for this cast - they leave")
				HeatLeave()
				return
			EndIf
		EndIf
	EndIf
	bool own = id == M.mv_iThread
	If own
		M.mv_bSaviorJoining = true      ; our own encounter continues in the heat scene(s)
		M.mv_iThread = -1
	EndIf
	OThread.Stop(id)
	Utility.Wait(0.8)
	If own
		M.mv_bSaviorJoining = false
	EndIf
	If !M.Alive(ep)
		HeatDeleteAll()
		HeatFinish()
		return
	EndIf
	int t = -1
	If turns
		int k = HeatNextTurn(0)
		If k >= 0
			t = HeatStartTurn(k, own)
		EndIf
	Else
		t = HeatStartScene(acts, sc, own)
	EndIf
	M.mv_iHeatThread = t
	If t < 0
		M.Log("heat: the heat scene did not start - they leave")
		If own
			M.mv_bAftermathDone = false
			M.RegisterForSingleUpdate(2.0)     ; ODS_Main's OnUpdate (not this module's)
		EndIf
		HeatLeave()
		return
	EndIf
	If turns
		M.Log("heat: " + n + " beasts (" + pack + ") take turns, first thread " + t)
	Else
		M.Log("heat: " + n + " beasts (" + pack + ") joined, scene " + sc + " thread " + t)
	EndIf
EndFunction

string Function HeatNumber(int n)
	If n == 1
		return "one"
	ElseIf n == 2
		return "two"
	ElseIf n == 3
		return "three"
	ElseIf n == 4
		return "four"
	EndIf
	return "several"
EndFunction

; OnOStimThreadEnd for the heat scene (the last turn when they take turns)
Function HeatSceneEnded()
	If !Ok()
		return
	EndIf
	M.mv_iHeatThread = -1
	If M.bSkyrimNetLog && M.SNetOK() && M.mv_kHeatHuman && M.mv_iHeatCount > 0
		string bn = "a " + M.FormWord(M.mv_iHeatKind)
		If M.mv_kHeatBeast
			bn = ODS_Text.T("heat.end_beast_ref", "{x1}, a {x2},", "", "", "", "", M.mv_kHeatBeast.GetDisplayName(), M.FormWord(M.mv_iHeatKind))
		EndIf
		string hn = M.mv_kHeatHuman.GetDisplayName()
		string t = ODS_Text.T("heat.end_memory", "Near {where}, {x1} and {x2} with {vn}: {x3}.", "", "", hn, M.WhereName(), HeatCallWord(M.mv_iHeatKind), bn, HeatPackWords())
		If M.mv_bHeatTurns
			t += " " + ODS_Text.T("heat.end_turns", "They took turns with {vn}.", "", "", hn)
		Else
			t += " " + ODS_Text.T("heat.end_joined", "{an} beasts in all joined {vn}.", "", HeatNumber(M.mv_iHeatCount + 1), hn)
		EndIf
		t += " " + ODS_Text.T("heat.end_leave", "Afterwards they left.")
		SkyrimNetApi.RegisterPersistentEvent(t, M.mv_kHeatBeast, M.mv_kHeatHuman)
	EndIf
	M.Log("heat: done (" + HeatPackWords() + ", turns " + M.YesNo(M.mv_bHeatTurns) + ")")
	HeatLeave()
EndFunction

; after the scene (or a failed start): calm again, walk away, deleted once out of sight
Function HeatLeave()
	If !Ok()
		return
	EndIf
	If M.mv_bHeatOwnsBusy
		M.mv_bHeatOwnsBusy = false
		If M.mv_iThread < 0
			M.bBusy = false
		EndIf
	EndIf
	If !M.mv_kHeatWolves
		HeatFinish()
		return
	EndIf
	Form xm = Game.GetFormFromFile(0x0000003B, "Skyrim.esm")
	If xm && M.mv_kHeatMarker == None
		float ang = M.PlayerRef.GetAngleZ() + 180.0
		M.mv_kHeatMarker = M.PlayerRef.PlaceAtMe(xm, 1, false, false)
		M.mv_kHeatMarker.SetPosition(M.PlayerRef.GetPositionX() + Math.sin(ang) * 4000.0, M.PlayerRef.GetPositionY() + Math.cos(ang) * 4000.0, M.PlayerRef.GetPositionZ())
	EndIf
	M.mv_iHeatLeft = 0
	int i = 0
	While i < 3
		Actor w = M.mv_kHeatWolves[i]
		If w && !w.IsDeleted()
			HeatPacify(w)
			M.mv_iHeatLeft = M.mv_iHeatLeft + 1
			If M.mv_kHeatMarker
				HeatAlias(i).Leave(M.mv_kHeatMarker)
			Else
				HeatAlias(i).Leave(w)
			EndIf
		EndIf
		i += 1
	EndWhile
	If M.mv_iHeatLeft == 0
		HeatFinish()
	EndIf
EndFunction

; alias: walked away (or the safety timer / death). Deleted only out of sight unless forced.
Function HeatWolfGone(ODS_HeatWolfAlias al, bool force)
	If !Ok()
		return
	EndIf
	Actor w = al.GetActorReference()
	If w
		If !force && !w.IsDead()
			int n = 0
			While n < 10 && w.GetDistance(M.PlayerRef) < 2500.0 && M.PlayerRef.HasLOS(w)
				Utility.Wait(2.0)
				n += 1
			EndWhile
		EndIf
		If M.mv_kHeatWolves
			int i = M.mv_kHeatWolves.Find(w)
			If i >= 0
				M.mv_kHeatWolves[i] = None
			EndIf
		EndIf
		w.Disable(true)
		w.Delete()
	EndIf
	al.Clear()
	If M.mv_iHeatLeft > 0
		M.mv_iHeatLeft = M.mv_iHeatLeft - 1
	EndIf
	If M.mv_iHeatLeft <= 0 && M.mv_iHeatThread < 0
		HeatFinish()
	EndIf
EndFunction

Function HeatDeleteAll()
	If !Ok()
		return
	EndIf
	If M.mv_kHeatWolves
		int i = 0
		While i < 3
			Actor w = M.mv_kHeatWolves[i]
			M.mv_kHeatWolves[i] = None
			If w
				w.Disable(false)
				w.Delete()
			EndIf
			HeatAlias(i).Clear()
			i += 1
		EndWhile
	EndIf
	M.mv_iHeatLeft = 0
EndFunction

Function HeatFinish()
	If !Ok()
		return
	EndIf
	If M.mv_bHeatOwnsBusy
		M.mv_bHeatOwnsBusy = false
		If M.mv_iThread < 0
			M.bBusy = false
		EndIf
	EndIf
	If M.mv_kHeatMarker
		M.mv_kHeatMarker.Delete()
		M.mv_kHeatMarker = None
	EndIf
	If M.ODS_HeatQuest && M.ODS_HeatQuest.IsRunning()
		M.ODS_HeatQuest.Stop()
	EndIf
	Actor[] noWolves          ; 1.1.1: a never-set local (assigning None to an array fails at run time)
	M.mv_kHeatWolves = noWolves
	M.mv_kHeatHuman = None
	M.mv_kHeatBeast = None
	M.mv_iHeatThread = -1
	M.mv_iHeatCount = 0
	M.mv_bHeatOn = false
EndFunction

; panic / master off: stop the scene, remove the werewolves at once
Function HeatAbort()
	If !Ok()
		return
	EndIf
	If !M.mv_bHeatOn && M.mv_iHeatThread < 0
		return
	EndIf
	int t = M.mv_iHeatThread
	M.mv_iHeatThread = -1
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)
	EndIf
	HeatDeleteAll()
	HeatFinish()
EndFunction

; game loaded: a heat event that is not in its scene any more is cleaned up at once
Function HeatOnLoad()
	If !Ok()
		return
	EndIf
	If !M.mv_bHeatOn
		return
	EndIf
	If M.mv_iHeatThread >= 0 && OThread.IsRunning(M.mv_iHeatThread)
		return
	EndIf
	M.mv_iHeatThread = -1
	HeatDeleteAll()
	HeatFinish()
EndFunction
