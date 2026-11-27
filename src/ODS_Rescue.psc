Scriptname ODS_Rescue extends Quest
{O'Deadly Skyrim 1.2.0 module: the mid-battle follower rescue side scene (moved out of ODS_Main). Attached to ODS_MainQuest next to ODS_Main. It keeps NO saved state of its own: every variable it uses still lives in ODS_Main and is reached through the mv_ accessor properties. By That Guy (Coronerra).}

; 0.3 FOLLOWER RESCUE (mid-battle). Behaviour is unchanged from 1.1.8 / 1.2.0 part A: a follower who
; goes down in a fight may be taken by one nearby hostile while the fight goes on; the player can
; stop it. Only the pair is calmed. It never sets bBusy and never pulls the player in.

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
		Debug.Trace("[ODeadlySkyrim] ODS_Rescue: ODS_Main is not on this quest (mismatched ESP?); rescue does nothing")
	EndIf
	return false
EndFunction

bool Function RescueGenderOK(Actor a)
	If !Ok()
		return false
	EndIf
	If M.iRescueGender == 0
		return true
	EndIf
	int sex = a.GetLeveledActorBase().GetSex()
	If M.iRescueGender == 1
		return sex == 1
	EndIf
	return sex == 0
EndFunction

bool Function IsRescueAlias(ReferenceAlias r)
	If !Ok()
		return false
	EndIf
	return M.mv_bRescueOn && r == M.Extra3Alias
EndFunction

; from OnActorBleedout for a downed follower. true = handled here (the full Defeat path is skipped)
bool Function TryFollowerRescue(Actor vic)
	If !Ok()
		return false
	EndIf
	If !M.Ready() || !M.bRescue || M.mv_bRescueOn || M.bBusy || vic == None || vic == M.PlayerRef
		return false
	EndIf
	If !M.IsFollowerActor(vic) || M.IsMinor(vic) || M.IsProtected(vic) || vic.IsDead() || OActor.IsInOStim(vic)
		return false
	EndIf
	If (!M.bGuardVictims && M.IsGuardActor(vic)) || !RescueGenderOK(vic)
		return false
	EndIf
	If M.PlayerRef.IsDead() || M.PlayerRef.IsBleedingOut() || OActor.IsInOStim(M.PlayerRef)
		return false
	EndIf
	float now = Utility.GetCurrentGameTime()
	If now < M.mv_fOKRHeldUntil || now < M.mv_fODefUntil || now < M.mv_fBakaUntil || (now - M.mv_fLastRescue) * 24.0 < 1.0
		return false
	EndIf
	If Utility.RandomFloat(0.0, 100.0) >= M.fRescueChance
		return false
	EndIf
	; one nearby hostile with an aggressive scene for the pair
	Actor att = None
	string scene = ""
	Actor[] acts = new Actor[2]
	Actor[] near = OActorUtil.GetActorsInRangeV2(vic, 1500.0, false, false, false)
	int i = 0
	While i < near.Length && att == None
		Actor x = near[i]
		If x && !M.IsFollowerActor(x) && !x.IsBleedingOut() && (x.IsHostileToActor(M.PlayerRef) || x.IsHostileToActor(vic)) && M.BaseEligible(x, true) && M.CreatureAllowed(x) && (M.bGuardAttackers || !M.IsGuardActor(x))
			Actor[] a1 = new Actor[1]
			a1[0] = x
			Actor[] v1 = new Actor[1]
			v1[0] = vic
			string s = M.SceneForSet(a1, 1, v1, 1, true, acts)
			If s != ""
				att = x
				scene = s
			EndIf
		EndIf
		i += 1
	EndWhile
	If att == None
		M.Log("rescue: no hostile with a scene near " + vic.GetDisplayName())
		return false
	EndIf
	int ep = M.mv_iEpoch
	M.mv_bRescueOn = true
	M.mv_bRescueDone = false
	M.mv_iRescueThread = -1
	M.mv_kRescueVic = vic
	M.mv_kRescueAtt = att
	M.mv_sRescueWhere = M.WhereName()
	M.mv_fLastRescue = now
	; calm only this pair
	M.mv_fRescueAgg = att.GetActorValue("Aggression")
	att.StopCombat()
	att.StopCombatAlarm()
	M.mv_bRescueFac = !att.IsInFaction(M.PlayerFaction)
	If M.mv_bRescueFac
		att.AddToFaction(M.PlayerFaction)
	EndIf
	att.SetActorValue("Aggression", 0.0)
	vic.StopCombat()
	vic.RestoreActorValue("Health", vic.GetBaseActorValue("Health") * 0.5)
	M.mv_bRescueProt = false
	ActorBase vb = vic.GetActorBase()
	If vb && !vb.IsEssential() && !vb.IsProtected() && !vic.IsEssential()
		vb.SetProtected(true)
		M.mv_bRescueProt = true
	EndIf
	M.Extra3Alias.ForceRefTo(att)
	Utility.Wait(1.0)      ; one bounded wait: let the follower come out of bleedout
	If !M.Alive(ep) || !M.mv_bRescueOn || att.IsDead() || vic.IsDead()
		RescueRelease(true)
		return true
	EndIf
	Actor[] dom = new Actor[1]
	dom[0] = att
	M.LeaveFurniture(acts)      ; 0.8
	int b = OThreadBuilder.Create(acts)
	If b < 0
		M.Log("rescue: OThreadBuilder.Create failed")
		RescueRelease(true)
		return false
	EndIf
	OThreadBuilder.SetDominantActors(b, dom)
	OThreadBuilder.SetStartingAnimation(b, scene)
	float mn = M.fMinDuration
	float mx = M.fMaxDuration
	If mx < mn
		mx = mn
	EndIf
	OThreadBuilder.SetDuration(b, Utility.RandomFloat(mn, mx))
	OThreadBuilder.UndressActors(b)
	OThreadBuilder.NoPostDialogue(b)
	OThreadBuilder.NoFurniture(b)
	OThreadBuilder.NoPlayerControl(b)
	OThreadBuilder.SetMetadataCSV(b, "odangerous,aggressive,follower_rescue")
	If !M.Alive(ep) || !M.mv_bRescueOn
		OThreadBuilder.Cancel(b)
		RescueRelease(true)
		return true
	EndIf
	If M.SceneHasMinor(acts, dom, "rescue")
		OThreadBuilder.Cancel(b)
		RescueRelease(true)      ; calm / aggression / protected flag restored, iRescueThread = -1
		return false
	EndIf
	int t = OThreadBuilder.Start(b)
	If t < 0
		M.Log("rescue: thread did not start")
		RescueRelease(true)
		return false
	EndIf
	M.mv_iRescueThread = t
	If !M.Alive(ep) || !M.mv_bRescueOn
		RescueRelease(true)
		return true
	EndIf
	M.Log("rescue: " + att.GetDisplayName() + " takes " + vic.GetDisplayName() + " at " + M.mv_sRescueWhere + ", thread " + t + ", scene " + scene)
	If M.bSkyrimNetStart && M.SNetOK()
		SkyrimNetApi.DirectNarration(ODS_Text.T("rescue.fallen", "{an} and {vn} near {where}.", "", att.GetDisplayName(), vic.GetDisplayName(), M.mv_sRescueWhere), att, vic)
	EndIf
	return true
EndFunction

; how: 1 = player hit / pulled the attacker away, 2 = attacker died, 0 = the scene ended on its own
Function RescueOutcome(int how)
	If !Ok()
		return
	EndIf
	If !M.mv_bRescueOn || M.mv_bRescueDone
		return
	EndIf
	M.mv_bRescueDone = true
	Actor att = M.mv_kRescueAtt
	Actor vic = M.mv_kRescueVic
	string w = M.mv_sRescueWhere
	RescueRelease(true)
	If !M.bMaster || !M.SNetOK() || att == None || vic == None
		return
	EndIf
	string pn = M.PlayerRef.GetDisplayName()
	string vn = vic.GetDisplayName()
	string an = att.GetDisplayName()
	string n
	string mm
	If how == 1
		n = ODS_Text.T("rescue.rescued_n", "{pn} pulls {vn} away from {an}.", pn, an, vn, w)
		mm = ODS_Text.T("rescue.rescued_m", "{pn} pulled {vn} away from {an} near {where}.", pn, an, vn, w)
	ElseIf how == 2
		n = ODS_Text.T("rescue.killed_n", "{an} falls; {vn} is free.", pn, an, vn, w)
		mm = ODS_Text.T("rescue.killed_m", "{an} was killed near {where}; {vn} got away.", pn, an, vn, w)
	Else
		n = ODS_Text.T("rescue.late_n", "{an} leaves {vn} and returns to the fight.", pn, an, vn, w)
		mm = ODS_Text.T("rescue.late_m", "{an} and {vn} near {where}; {pn} was too late.", pn, an, vn, w)
	EndIf
	If M.bSkyrimNetStart
		SkyrimNetApi.DirectNarration(n, att, vic)
	EndIf
	If M.bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(mm, att, vic)
	EndIf
EndFunction

; stop the side scene and give both actors back (also used by panic, master off and game load)
Function RescueRelease(bool fight)
	If !Ok()
		return
	EndIf
	int t = M.mv_iRescueThread
	M.mv_iRescueThread = -1
	Actor att = M.mv_kRescueAtt
	Actor vic = M.mv_kRescueVic
	M.mv_kRescueAtt = None
	M.mv_kRescueVic = None
	M.mv_bRescueOn = false
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)       ; OStim redresses the actors it undressed
	EndIf
	If att && M.Extra3Alias.GetReference() == att
		M.Extra3Alias.Clear()
	EndIf
	If att
		If M.mv_bRescueFac
			att.RemoveFromFaction(M.PlayerFaction)
		EndIf
		If !att.IsDead()
			att.SetActorValue("Aggression", M.mv_fRescueAgg)
			att.EvaluatePackage()
			If fight && M.bMaster && att.IsHostileToActor(M.PlayerRef)
				att.StartCombat(M.PlayerRef)
			EndIf
		EndIf
	EndIf
	M.mv_bRescueFac = false
	If vic
		If M.mv_bRescueProt && vic.GetActorBase()
			vic.GetActorBase().SetProtected(false)
		EndIf
		If !vic.IsDead()
			vic.RestoreActorValue("Health", vic.GetBaseActorValue("Health") * 0.5)
			vic.EvaluatePackage()
		EndIf
	EndIf
	M.mv_bRescueProt = false
EndFunction
