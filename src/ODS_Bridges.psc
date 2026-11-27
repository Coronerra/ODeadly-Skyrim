Scriptname ODS_Bridges extends Quest
{O'Deadly Skyrim 1.2.0 module: the SkyrimNet listener bridges for OStim Kidnapped Redux, ODefeat Reforged and Baka Defeat (OStim Edition), moved out of ODS_Main. Attached to ODS_MainQuest next to ODS_Main. It keeps NO saved state of its own: every variable it uses still lives in ODS_Main and is reached through the mv_ accessor properties. The mod-event listeners stay registered on ODS_Main, which forwards them here. By That Guy (Coronerra).}

; 0.3 SKYRIMNET BRIDGES (listeners only). Lirael's OStim Kidnapped Redux and ODefeat Reforged, and
; 0.5 Baka Defeat - OStim Edition (plugin SexLabDefeat.esp). O'Deadly never starts, stops or changes
; their kidnappings or defeats: it listens to their public mod events, tells SkyrimNet what
; happened, and holds its own encounters while one of them has the player. Nothing here runs
; unless the plugin is loaded (ODS_Main only registers the events then). Master switch off /
; panic: no SkyrimNet text. Adults only: a scene with a child in it is never narrated.
; Behaviour is unchanged from 1.1.8.

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
		Debug.Trace("[ODeadlySkyrim] ODS_Bridges: ODS_Main is not on this quest (mismatched ESP?); the bridges do nothing")
	EndIf
	return false
EndFunction

; ---------- OStim Kidnapped Redux ----------
; The events carry no actors, so the text names the player and the place only.
; OKidnapped_Refused only answers OKidnapped_Take, which O'Deadly never sends: not listened to.
bool Function OKRTalk()
	If !Ok()
		return false
	EndIf
	return M.bMaster && M.bOKRSkyrimNet && M.SNetOK()
EndFunction

; strArg "" / numArg 1 = another mod handed the player over (OKidnapped_Take), 0 = its own ambush
Function OnOKRTaken(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.mv_sOKRWhere = M.WhereName()                              ; still at the ambush spot: the player is moved afterwards
	M.mv_fOKRHeldUntil = Utility.GetCurrentGameTime() + 1.0   ; cleared by OKidnapped_End, lapses after a game day
	bool requested = numArg >= 1.0
	M.Log("Kidnapped Redux: taken near " + M.mv_sOKRWhere + " (requested " + requested + ")")
	If !OKRTalk()
		return
	EndIf
	string pn = M.PlayerRef.GetDisplayName()
	If M.bSkyrimNetStart
		If requested
			SkyrimNetApi.DirectNarration("Already beaten and helpless near " + M.mv_sOKRWhere + ", " + pn + " is handed over to a gang of kidnappers, who drag them off to their hideout.", None, None)
		Else
			SkyrimNetApi.DirectNarration("Kidnappers jump " + pn + " near " + M.mv_sOKRWhere + ", knock them down and drag them off to their hideout.", None, None)
		EndIf
	EndIf
	If M.bSkyrimNetLog
		If requested
			SkyrimNetApi.RegisterPersistentEvent(pn + " was handed over to kidnappers near " + M.mv_sOKRWhere + " and dragged off to their hideout.", None, M.PlayerRef)
		Else
			SkyrimNetApi.RegisterPersistentEvent("Kidnappers ambushed " + pn + " near " + M.mv_sOKRWhere + " and dragged them off to their hideout.", None, M.PlayerRef)
		EndIf
	EndIf
EndFunction

Function OnOKRDodged(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	string w = M.WhereName()
	M.Log("Kidnapped Redux: dodged near " + w)
	If OKRTalk() && M.bSkyrimNetStart
		string pn = M.PlayerRef.GetDisplayName()
		SkyrimNetApi.DirectNarration("Kidnappers try to jump " + pn + " near " + w + ", but " + pn + " slips the ambush.", None, None)
	EndIf
EndFunction

; strArg "escaped", "released" or "slavery"
Function OnOKREnd(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.mv_fOKRHeldUntil = 0.0
	string w = M.mv_sOKRWhere
	M.mv_sOKRWhere = ""
	M.Log("Kidnapped Redux: end (" + strArg + ")")
	If !OKRTalk() || (strArg != "escaped" && strArg != "released" && strArg != "slavery")
		return
	EndIf
	string pn = M.PlayerRef.GetDisplayName()
	string who = "The kidnappers who took " + pn
	If w != ""
		who += " near " + w
	EndIf
	string n
	string mt
	If strArg == "escaped"
		n = ODS_Text.T("kidnap.escaped_n", "{pn} escaped the kidnappers.", pn, "", "", w, who)
		mt = ODS_Text.T("kidnap.escaped_m", "{x1}; {pn} escaped.", pn, "", "", w, who)
	ElseIf strArg == "released"
		n = ODS_Text.T("kidnap.released_n", "{pn} was let go by the kidnappers.", pn, "", "", w, who)
		mt = ODS_Text.T("kidnap.released_m", "{x1}; {pn} was let go.", pn, "", "", w, who)
	Else
		n = ODS_Text.T("kidnap.slavery_n", "{pn} was sold into slavery by the kidnappers.", pn, "", "", w, who)
		mt = ODS_Text.T("kidnap.slavery_m", "{x1}; {pn} was sold into slavery.", pn, "", "", w, who)
	EndIf
	If M.bSkyrimNetStart
		SkyrimNetApi.DirectNarration(n, None, None)
	EndIf
	If M.bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(mt, None, M.PlayerRef)
	EndIf
EndFunction

; ---------- ODefeat Reforged ----------
; Its defeat scenes carry the OStim metadata "odefeat" + the victim's FormID, and it rebroadcasts
; ostim_start as "ODefeatAnimStart_" + each token. An escape tags the scene "odefeat_escaped"
; before stopping it; otherwise one outcome event follows the scene (robbery, safe wakeup, kill,
; arrest, or a third-party one such as "SSLV Entry"). Only OStim's own OJson is used to read the
; scene: no ODefeat script types.
bool Function ODefTalk()
	If !Ok()
		return false
	EndIf
	return M.bMaster && M.bODefSkyrimNet && M.SNetOK()
EndFunction

bool Function ODefPlayerScene(string json)
	If !Ok()
		return false
	EndIf
	string[] meta = OJson.GetMetadata(json)
	return meta && meta.Find("odefeat") >= 0 && meta.Find(M.PlayerRef.GetFormID() as string) >= 0
EndFunction

; "<winner> beat <player> near <place>" opener; falls back to "Someone"
string Function ODefWho()
	If !Ok()
		return ""
	EndIf
	string w = M.mv_sODefWhere
	If w == ""
		w = M.WhereName()
	EndIf
	string by = M.mv_sODefBy
	If by == ""
		by = "Someone"
	EndIf
	return by + " beat " + M.PlayerRef.GetDisplayName() + " near " + w
EndFunction

Function OnODefStart(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	If !ODefPlayerScene(strArg)
		return      ; an NPC's defeat scene
	EndIf
	If Utility.GetCurrentGameTime() < M.mv_fBakaUntil
		M.Log("ODefeat: player scene while Baka Defeat has the player, not narrated twice")
		return
	EndIf
	M.mv_fODefUntil = Utility.GetCurrentGameTime() + 0.25     ; cleared by the outcome, lapses after 6 game hours
	M.mv_bODefAwait = false
	M.mv_sODefWhere = M.WhereName()
	M.mv_sODefBy = ""
	Actor[] acts = OJson.GetActors(strArg)
	int i = 0
	While acts && i < acts.Length && M.mv_sODefBy == ""
		If acts[i] && acts[i] != M.PlayerRef && !M.IsMinor(acts[i])
			M.mv_sODefBy = acts[i].GetDisplayName()
		EndIf
		i += 1
	EndWhile
	M.Log("ODefeat: player defeated near " + M.mv_sODefWhere + " by " + M.mv_sODefBy)
	If ODefTalk() && M.bSkyrimNetStart
		string pn = M.PlayerRef.GetDisplayName()
		If M.mv_sODefBy != ""
			SkyrimNetApi.DirectNarration(ODS_Text.T("odef.start_by", "{x1} beat {pn} near {where}.", pn, "", "", M.mv_sODefWhere, M.mv_sODefBy), None, None)
		Else
			SkyrimNetApi.DirectNarration(ODS_Text.T("odef.start", "{pn} was beaten near {where}.", pn, "", "", M.mv_sODefWhere), None, None)
		EndIf
	EndIf
EndFunction

; from OnOStimThreadEnd while a player defeat is in progress
Function ODefSceneEnded(string json)
	If !Ok()
		return
	EndIf
	If !ODefPlayerScene(json)
		return
	EndIf
	string[] meta = OJson.GetMetadata(json)
	If meta.Find("odefeat_escaped") < 0
		M.mv_bODefAwait = true       ; an outcome event follows
		return
	EndIf
	M.Log("ODefeat: player escaped")
	string pn = M.PlayerRef.GetDisplayName()
	string mt = ODS_Text.T("odef.escape_m", "{x1}; {pn} escaped.", pn, "", "", "", ODefWho())
	ODefClear()
	If ODefTalk()
		If M.bSkyrimNetStart
			SkyrimNetApi.DirectNarration(ODS_Text.T("odef.escape_n", "{pn} escaped.", pn), None, None)
		EndIf
		If M.bSkyrimNetLog
			SkyrimNetApi.RegisterPersistentEvent(mt, None, M.PlayerRef)
		EndIf
	EndIf
EndFunction

Function ODefClear()
	If !Ok()
		return
	EndIf
	M.mv_fODefUntil = 0.0
	M.mv_bODefAwait = false
	M.mv_sODefWhere = ""
	M.mv_sODefBy = ""
EndFunction

Function ODefSay(string n, string mt)
	If !Ok()
		return
	EndIf
	ODefClear()
	If !ODefTalk()
		return
	EndIf
	If M.bSkyrimNetStart && n != ""
		SkyrimNetApi.DirectNarration(n, None, None)
	EndIf
	If M.bSkyrimNetLog && mt != ""
		SkyrimNetApi.RegisterPersistentEvent(mt, None, M.PlayerRef)
	EndIf
EndFunction

Function OnODefRobbery(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.Log("ODefeat: robbery")
	string pn = M.PlayerRef.GetDisplayName()
	string keeper = "Whoever beat them"
	If M.mv_sODefBy != ""
		keeper = M.mv_sODefBy
	EndIf
	ODefSay(ODS_Text.T("odef.robbery_n", "{pn} was robbed; {x1} may have the valuables.", pn, "", "", "", keeper), ODS_Text.T("odef.robbery_m", "{x1}; {pn} was robbed.", pn, "", "", "", ODefWho()))
EndFunction

Function OnODefSafeWakeup(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.Log("ODefeat: safe wakeup")
	string pn = M.PlayerRef.GetDisplayName()
	ODefSay(ODS_Text.T("odef.safe_n", "{pn} was left behind.", pn), ODS_Text.T("odef.safe_m", "{x1}; {pn} was left behind.", pn, "", "", "", ODefWho()))
EndFunction

Function OnODefArrest(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.Log("ODefeat: arrest")
	string pn = M.PlayerRef.GetDisplayName()
	string by = "a guard"
	If M.mv_sODefBy != ""
		by = M.mv_sODefBy
	EndIf
	string w = M.mv_sODefWhere
	If w == ""
		w = M.WhereName()
	EndIf
	string mt = ODS_Text.T("odef.arrest_m", "{x1} beat {pn} near {where}; {pn} was jailed.", pn, "", "", w, by)
	ODefSay(ODS_Text.T("odef.arrest_n", "{pn} was jailed after {x1} beat them near {where}.", pn, "", "", w, by), mt)
EndFunction

; the last save is reloaded right after, so a short narration only
Function OnODefKill(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.Log("ODefeat: kill")
	string pn = M.PlayerRef.GetDisplayName()
	string by = "The winner"
	If M.mv_sODefBy != ""
		by = M.mv_sODefBy
	EndIf
	ODefSay(ODS_Text.T("odef.kill_n", "{x1} killed {pn}.", pn, "", "", "", by), "")
EndFunction

; "SSLV Entry" is shared by several mods: only ours if a player defeat scene just ended without
; an escape, and Kidnapped Redux is not the one holding the player (it sends its own end event)
Function OnODefSlavery(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	float now = Utility.GetCurrentGameTime()
	If !M.mv_bODefAwait || now >= M.mv_fODefUntil || now < M.mv_fOKRHeldUntil
		return
	EndIf
	M.Log("ODefeat: sold into slavery")
	string pn = M.PlayerRef.GetDisplayName()
	ODefSay(ODS_Text.T("odef.slavery_n", "{pn} was sold into slavery.", pn), ODS_Text.T("odef.slavery_m", "{x1}; {pn} was sold into slavery.", pn, "", "", "", ODefWho()))
EndFunction

; ======================= 0.5: BAKA DEFEAT (OStim Edition) BRIDGE (listener only) =======================
; Baka Defeat - OStim Edition (an OStim conversion of BakaFactory's SexLab Defeat, plugin
; SexLabDefeat.esp). O'Deadly never starts, stops or changes its defeats. It listens to Baka's
; own public mod events and tells SkyrimNet what happened:
;   DefeatOStimStart / DefeatOStimEnd  numArg = OStim thread id, sender = Baka's scene thread quest.
;     Its VictimRef / Hook properties are read through a compile-only stub (never shipped);
;     the actors come from OStim's OThread. VictimRef None = a consensual or paid scene: ignored.
;     Hook "DefeatNecro" / "DefeatCons" are ignored.
;   DefeatPostAssault  strArg "DefeatedBegin" (wakes up at an inn), "LFDBegin" (left for dead),
;     "RobEnd" (robbed), "EscapeEnd" (got away), "EscapeBegin" / "BlackOutBegin" (logged only).
; Baka does not broadcast the knockdown, surrender or the struggle itself, so the defeat is told
; when the first scene with the player as victim starts. Master switch off / panic: no text.
; Adults only: a scene with a child in it is never narrated or remembered.
bool Function BakaTalk()
	If !Ok()
		return false
	EndIf
	return M.bMaster && M.bBakaSkyrimNet && M.SNetOK()
EndFunction

Function BakaSay(string n, string mt, Actor a1, Actor a2)
	If !BakaTalk()
		return
	EndIf
	If M.bSkyrimNetStart && n != ""
		SkyrimNetApi.DirectNarration(n, a1, a2)
	EndIf
	If M.bSkyrimNetLog && mt != ""
		Actor who = a1
		If who == None
			who = M.PlayerRef
		EndIf
		SkyrimNetApi.RegisterPersistentEvent(mt, who, a2)
	EndIf
EndFunction

int Function BakaSlot(int tid)
	If !Ok()
		return -1
	EndIf
	If !M.mv_iBakaTid || !M.mv_iBakaKind
		M.InitArrays()
	EndIf
	int i = 0
	While i < 8
		If M.mv_iBakaKind[i] > 0 && M.mv_iBakaTid[i] == tid
			return i
		EndIf
		i += 1
	EndWhile
	return -1
EndFunction

int Function BakaFreeSlot()
	If !Ok()
		return 0
	EndIf
	int i = 0
	While i < 8
		If M.mv_iBakaKind[i] == 0
			return i
		EndIf
		i += 1
	EndWhile
	return 0     ; all busy (stale): reuse the first
EndFunction

; "<who> beat <player> near <place>"
string Function BakaWho()
	If !Ok()
		return ""
	EndIf
	string w = M.mv_sBakaWhere
	If w == ""
		w = M.WhereName()
	EndIf
	string by = M.mv_sBakaBy
	If by == ""
		by = "Someone"
	EndIf
	return by + " beat " + M.PlayerRef.GetDisplayName() + " near " + w
EndFunction

Function BakaClear()
	If !Ok()
		return
	EndIf
	M.mv_sBakaWhere = ""
	M.mv_sBakaBy = ""
	M.mv_bBakaMemDone = false
EndFunction

Function OnBakaSceneStart(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	int tid = numArg as int
	DefeatOStimThread t = sender as DefeatOStimThread
	If t == None || tid < 0
		return
	EndIf
	string hook = t.Hook
	Actor vic = t.VictimRef
	If vic == None || hook == "DefeatNecro" || hook == "DefeatCons"
		return       ; consensual, paid or a corpse: not told
	EndIf
	Actor[] acts = OThread.GetActors(tid)
	If !acts || acts.Length < 2 || acts.Find(vic) < 0
		return
	EndIf
	Actor agg = None
	int i = 0
	While i < acts.Length
		If acts[i] == None || M.IsMinor(acts[i])
			M.Log("Baka Defeat: scene " + tid + " has a child or an empty slot, not narrated")
			return
		EndIf
		If agg == None && acts[i] != vic
			agg = acts[i]
		EndIf
		i += 1
	EndWhile
	bool playerIn = acts.Find(M.PlayerRef) >= 0
	int kind = 4
	If vic == M.PlayerRef
		kind = 1
	ElseIf playerIn
		kind = 3
		agg = M.PlayerRef
	ElseIf M.IsFollowerActor(vic)
		kind = 2
	EndIf
	int s = BakaSlot(tid)
	If s < 0
		s = BakaFreeSlot()
	EndIf
	M.mv_iBakaTid[s] = tid
	M.mv_iBakaKind[s] = kind
	M.mv_kBakaVic[s] = vic
	M.mv_kBakaAgg[s] = agg
	string pn = M.PlayerRef.GetDisplayName()
	string w = M.WhereName()
	string an = agg.GetDisplayName()
	string vn = vic.GetDisplayName()
	M.Log("Baka Defeat: scene " + tid + " hook " + hook + " kind " + kind + " victim " + vn + " by " + an)
	If kind == 1
		float now = Utility.GetCurrentGameTime()
		bool fresh = now >= M.mv_fBakaUntil
		M.mv_fBakaUntil = now + 0.25        ; cleared by the outcome, lapses after 6 game hours
		If now < M.mv_fODefUntil
			ODefClear()                ; both installed: Baka is the one telling this defeat
		EndIf
		If fresh
			BakaClear()
			M.mv_sBakaWhere = w
			M.mv_sBakaBy = an
			BakaSay(ODS_Text.T("baka.start_first", "{an} beat {pn} near {where}.", pn, an, vn, w), "", agg, M.PlayerRef)
		Else
			BakaSay(ODS_Text.T("baka.start_turn", "{an} and {pn}.", pn, an, vn, w), "", agg, M.PlayerRef)
		EndIf
	ElseIf kind == 2
		BakaSay(ODS_Text.T("baka.start_follower", "{an} and {vn} near {where}.", pn, an, vn, w), "", agg, vic)
	ElseIf kind == 3
		BakaSay(ODS_Text.T("baka.start_player", "{pn} and {vn} near {where}.", pn, an, vn, w), "", M.PlayerRef, vic)
	Else
		BakaSay(ODS_Text.T("baka.start_npc", "{an} and {vn} near {where}.", pn, an, vn, w), "", agg, vic)
	EndIf
EndFunction

Function OnBakaSceneEnd(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	int s = BakaSlot(numArg as int)
	If s < 0
		return
	EndIf
	int kind = M.mv_iBakaKind[s]
	Actor vic = M.mv_kBakaVic[s]
	Actor agg = M.mv_kBakaAgg[s]
	M.mv_iBakaKind[s] = 0
	M.mv_iBakaTid[s] = -1
	M.mv_kBakaVic[s] = None
	M.mv_kBakaAgg[s] = None
	If vic == None || agg == None
		return
	EndIf
	string pn = M.PlayerRef.GetDisplayName()
	string w = M.WhereName()
	If kind == 1
		If !M.mv_bBakaMemDone
			M.mv_bBakaMemDone = true
			BakaSay("", ODS_Text.T("baka.end_player_m", "{x1}; {pn} was beaten.", pn, "", "", w, BakaWho()), agg, M.PlayerRef)
		EndIf
	ElseIf kind == 2
		BakaSay("", ODS_Text.T("baka.end_follower_m", "{an} and {vn} near {where}.", pn, agg.GetDisplayName(), vic.GetDisplayName(), w), agg, vic)
	ElseIf kind == 3
		BakaSay("", ODS_Text.T("baka.end_player_beat_m", "{pn} and {vn} near {where}.", pn, agg.GetDisplayName(), vic.GetDisplayName(), w), M.PlayerRef, vic)
	Else
		BakaSay("", ODS_Text.T("baka.end_npc_m", "{an} and {vn} near {where}.", pn, agg.GetDisplayName(), vic.GetDisplayName(), w), agg, vic)
	EndIf
EndFunction

; the player's post-assault events (Baka sends them only for the player)
Function OnBakaPostAssault(string eventName, string strArg, float numArg, Form sender)
	If !Ok()
		return
	EndIf
	M.Log("Baka Defeat: post assault " + strArg)
	string pn = M.PlayerRef.GetDisplayName()
	float now = Utility.GetCurrentGameTime()
	If strArg == "DefeatedBegin"
		M.mv_fBakaUntil = now + 0.04
		BakaSay(ODS_Text.T("baka.post_inn_n", "{pn} woke at an inn.", pn), ODS_Text.T("baka.post_inn_m", "{x1}; {pn} woke at an inn.", pn, "", "", "", BakaWho()), None, M.PlayerRef)
	ElseIf strArg == "LFDBegin"
		M.mv_fBakaUntil = now + 0.04
		BakaSay(ODS_Text.T("baka.post_lfd_n", "{pn} woke where they were left.", pn), ODS_Text.T("baka.post_lfd_m", "{x1}; {pn} was left behind.", pn, "", "", "", BakaWho()), None, M.PlayerRef)
	ElseIf strArg == "RobEnd"
		M.mv_fBakaUntil = now + 0.04
		string by = "The ones who beat them"
		If M.mv_sBakaBy != ""
			by = M.mv_sBakaBy
		EndIf
		BakaSay(ODS_Text.T("baka.post_rob_n", "{x1} robs {pn}.", pn, "", "", "", by), ODS_Text.T("baka.post_rob_m", "{x1}; {pn} was robbed.", pn, "", "", "", BakaWho()), None, M.PlayerRef)
	ElseIf strArg == "EscapeEnd"
		M.mv_fBakaUntil = 0.0
		BakaSay(ODS_Text.T("baka.post_escape_n", "{pn} got away.", pn), ODS_Text.T("baka.post_escape_m", "{x1}; {pn} got away.", pn, "", "", "", BakaWho()), None, M.PlayerRef)
		BakaClear()
	EndIf
EndFunction
