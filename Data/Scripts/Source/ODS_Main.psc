Scriptname ODS_Main extends Quest
{O'Deadly Skyrim (A SkyrimNet environmental mod) v0.1 UNTESTED - by That Guy (Coronerra). One dangerous-world engine for OStim + SkyrimNet. Inspired by ODangerousNights (no ODN files used). Adults only: children are refused for every role.}

; ======================= properties (filled in ODeadlySkyrim.esp) =======================
Actor Property PlayerRef Auto
ReferenceAlias Property AttackerAlias Auto
ReferenceAlias Property VictimAlias Auto
ReferenceAlias Property Victim2Alias Auto
ReferenceAlias Property Extra1Alias Auto
ReferenceAlias Property Extra2Alias Auto
ReferenceAlias Property Extra3Alias Auto
ReferenceAlias Property EssentialAlias Auto
ReferenceAlias Property Follower1Alias Auto
ReferenceAlias Property Follower2Alias Auto
ReferenceAlias Property Follower3Alias Auto
ReferenceAlias Property Follower4Alias Auto
Faction Property PlayerFaction Auto
Faction Property CurrentFollowerFaction Auto
ImageSpaceModifier Property FadeToBlackHoldIMod Auto
ImageSpaceModifier Property FadeToBlackBackIMod Auto
FormList Property ODS_PoolBandit Auto
FormList Property ODS_PoolWerewolf Auto
FormList Property ODS_PoolDraugr Auto
FormList Property ODS_PoolTroll Auto
FormList Property ODS_PoolFalmer Auto
FormList Property ODS_PoolSpriggan Auto
FormList Property ODS_PoolGiant Auto
FormList Property ODS_PoolHagraven Auto
MiscObject Property Gold001 Auto

; ======================= event kinds =======================
int Property K_ATTACK = 1 AutoReadOnly     ; night attack (Sleep Ambush port)
int Property K_CHEAT = 2 AutoReadOnly      ; cheating spouse (Sleep Ambush port)
int Property K_JAIL = 3 AutoReadOnly       ; imprisonment & barracks
int Property K_INN = 4 AutoReadOnly        ; drunk patrons take the player
int Property K_SPIKED = 5 AutoReadOnly     ; spiked drink at an inn
int Property K_DEFEAT = 6 AutoReadOnly     ; defeat / bleedout
int Property K_TRESPASS = 7 AutoReadOnly   ; owner finds you in their home
int Property K_ROAD = 8 AutoReadOnly       ; road robbery / toll
int Property K_CREATURE = 9 AutoReadOnly   ; OCreatures encounter
int Property K_BETRAYAL = 10 AutoReadOnly  ; follower takes advantage
int Property K_VAMPIRE = 11 AutoReadOnly   ; vampire seduction
int Property K_COUNT = 12 AutoReadOnly
int Property CR_COUNT = 7 AutoReadOnly     ; werewolf, draugr, troll, falmer, spriggan, giant, hagraven

; ======================= settings: general =======================
bool Property bMaster = false Auto Hidden          ; MASTER KILL SWITCH - default OFF
int Property iPanicKey = -1 Auto Hidden             ; unbound by default
bool Property bPanicNotice = true Auto Hidden       ; bland "O'Deadly Skyrim is off." after panic
bool Property bNoKeyWarned = false Auto Hidden
int Property iMsgStyle = 1 Auto Hidden              ; 0 message box, 1 notification (default), 2 none
float Property fCooldownHours = 4.0 Auto Hidden     ; game hours between events
float Property fMinDuration = 60.0 Auto Hidden
float Property fMaxDuration = 120.0 Auto Hidden
bool Property bFallbackAnyScene = true Auto Hidden
bool Property bAllowNamed = false Auto Hidden       ; essential/protected unique NPCs can take part
bool Property bGroupScenes = false Auto Hidden
int Property iGroupMax = 2 Auto Hidden              ; extra attackers (1-3)
bool Property bGroupBoth = false Auto Hidden        ; group: two victims together (player + follower or two followers)
bool Property bMoralityFilter = true Auto Hidden
bool Property bSkyrimNetStart = true Auto Hidden
bool Property bSkyrimNetLog = true Auto Hidden
bool Property bRumors = true Auto Hidden
bool Property bBioCheck = true Auto Hidden
float Property fBioTimeout = 8.0 Auto Hidden
bool Property bDrunkMod = true Auto Hidden
float Property fDrunkMult = 2.0 Auto Hidden
int Property iVictimGender = 0 Auto Hidden          ; 0 any, 1 female, 2 male
float Property fVictimRange = 2000.0 Auto Hidden
bool Property bProtectSerana = true Auto Hidden
bool Property bDebug = false Auto Hidden
bool Property bDebugTools = false Auto Hidden
int Property iForceMode = 0 Auto Hidden             ; debug: a K_* kind for the next rest of 1h+ (K_DEFEAT = next bleedout)

; ======================= settings: night attacks (Sleep Ambush port) =======================
bool Property bSleepEnabled = true Auto Hidden
bool Property bPlayerVictim = false Auto Hidden     ; player can be a victim of night attacks
bool Property bWaitAsSleep = false Auto Hidden
float Property fAtkWalledHome = 0.0 Auto Hidden
float Property fAtkOtherHome = 1.0 Auto Hidden
float Property fAtkInn = 1.5 Auto Hidden
float Property fAtkCity = 1.0 Auto Hidden
float Property fAtkSettlement = 3.0 Auto Hidden
float Property fAtkWilderness = 6.0 Auto Hidden
float Property fAtkCamp = 7.0 Auto Hidden
float Property fAtkDungeon = 7.0 Auto Hidden
int Property iBeastChance = 40 Auto Hidden
bool Property bAllowBandit = true Auto Hidden
bool Property bAllowNearby = true Auto Hidden
bool Property bGuardsBlock = true Auto Hidden
float Property fGuardRange = 3000.0 Auto Hidden
bool Property bGuardAttackers = false Auto Hidden
bool Property bGuardVictims = false Auto Hidden

; cheating spouse
bool Property bCheatEnabled = false Auto Hidden
float Property fCheatWalledHome = 1.0 Auto Hidden
float Property fCheatOtherHome = 1.0 Auto Hidden
float Property fCheatInn = 8.0 Auto Hidden
float Property fCheatCity = 3.0 Auto Hidden
float Property fCheatSettlement = 3.0 Auto Hidden
float Property fCheatWilderness = 1.0 Auto Hidden
float Property fCheatCamp = 0.5 Auto Hidden
float Property fCheatDungeon = 0.5 Auto Hidden
bool Property bPartnerPatronsOnly = false Auto Hidden
bool Property bPartnerFollowers = true Auto Hidden
bool Property bPartnerGuards = true Auto Hidden
bool Property bPartnerSameGender = false Auto Hidden
bool Property bLoverIsSpouse = false Auto Hidden
bool Property bDrunkEvent = true Auto Hidden

; SkyrimNet named places (beta29+)
bool Property bUsePlaces = true Auto Hidden
float Property fPlaceRadius = 0.0 Auto Hidden
string[] Property PlaceNames Auto Hidden
int[] Property PlaceCats Auto Hidden
int iPlaceAPI = -1
int iDecisionAPI = -1

Form[] Property Protected Auto Hidden
Form[] Property OvrLoc Auto Hidden
float[] Property OvrAtk Auto Hidden
float[] Property OvrCheat Auto Hidden
int[] Property OvrJail Auto Hidden                  ; 0 auto, 1 treat as jail/barracks, 2 never jail/barracks

; ======================= settings: modules =======================
bool Property bJailEnabled = false Auto Hidden
float Property fJailChance = 10.0 Auto Hidden       ; % per hour slept/waited in a jail or barracks
float Property fJailLingerChance = 15.0 Auto Hidden ; % per linger check
float Property fLingerHours = 0.5 Auto Hidden       ; game hours in a jail/barracks before a linger check
bool Property bJailPlayer = false Auto Hidden
bool Property bJailFollowers = true Auto Hidden
bool Property bJailSpawnExtras = false Auto Hidden
bool Property bArrestAlt = false Auto Hidden
bool Property bZaZ = false Auto Hidden

bool Property bInnPlayer = false Auto Hidden
float Property fInnPlayerChance = 3.0 Auto Hidden
bool Property bSpiked = false Auto Hidden
float Property fSpikedChance = 3.0 Auto Hidden
bool Property bSpikedPlayer = false Auto Hidden
bool Property bSpikedFollowers = true Auto Hidden

bool Property bDefeatEnabled = false Auto Hidden
float Property fDefeatChance = 50.0 Auto Hidden
bool Property bDefeatPlayer = false Auto Hidden
bool Property bDefeatFollowers = true Auto Hidden
bool Property bDefeatEssential = false Auto Hidden

bool Property bTrespassEnabled = false Auto Hidden
float Property fTrespassChance = 8.0 Auto Hidden
bool Property bTrespassPlayer = false Auto Hidden
bool Property bTrespassFollowers = true Auto Hidden

bool Property bTravelEnabled = false Auto Hidden
float Property fRoadChance = 3.0 Auto Hidden        ; % per game hour outdoors (awake)
float Property fRoadWaitChance = 5.0 Auto Hidden    ; % per hour waited outdoors
int Property iRobberyPct = 25 Auto Hidden
float Property fRobberySceneChance = 50.0 Auto Hidden
bool Property bTravelPlayer = false Auto Hidden
bool Property bTravelFollowers = true Auto Hidden

bool Property bCrEnabled = false Auto Hidden
bool[] Property bCrType Auto Hidden
int[] Property iCrStatus Auto Hidden                ; 0 not installed, 1 no scenes, 2 available, 3 not checked
bool Property bCrPlayer = false Auto Hidden
bool Property bCrFollowers = true Auto Hidden
float Property fCrCampChance = 5.0 Auto Hidden
float Property fCrRoamChance = 1.0 Auto Hidden
bool Property bOCreatures = false Auto Hidden

bool Property bCaught = false Auto Hidden
float Property fCaughtChance = 50.0 Auto Hidden
bool Property bBetrayal = false Auto Hidden
float Property fBetrayalChance = 2.0 Auto Hidden

bool Property bVampire = false Auto Hidden
float Property fVampireChance = 5.0 Auto Hidden
bool Property bBlackmail = false Auto Hidden
float Property fBlackmailChance = 25.0 Auto Hidden
bool Property bLeftover = false Auto Hidden
bool Property bOCumMemory = false Auto Hidden

; ======================= runtime =======================
bool Property bBusy = false Auto Hidden
int iEpoch = 0
int iThread = -1
int iThread2 = -1
int iKind = 0
Actor kVictim
Actor kVictim2
Actor kAttacker
Actor[] kAtt            ; staged attackers [4], kAtt[0] = lead
int nAtt = 0
Actor[] kVic            ; staged victims [2]
int nVic = 0
Actor[] kSceneActs
Actor[] kSceneActs2
string sScene1 = ""
string sScene2 = ""
Actor[] kSpawned        ; [8]
float[] fOldAgg         ; per kAtt slot
float[] fOldConf
bool[] bAddedFac
Actor[] kPacified       ; [8] defeat: hostiles kept calm until the next location change
float[] fPacAgg
bool bIntervened = false
bool bAftermathDone = true
bool bForcedScene = true
int iCleanupTicks = 0
float fLastODNAttack = -10.0
float fLastEvent = -10.0
float fLastCaught = -10.0
int iHitHour = -1
Actor kPendingSpouse
Actor kDefeatVictim
Actor kThief
int iRobbedGold = 0
Actor kBlackmailer
float fBlackmailTime = 0.0
string sBlackmailWhere = ""
float fMenuOpenGT = 0.0
bool bSleptThisMenu = false
float fLingerDue = -1.0
float fTravelDue = -1.0
int iBioAnswer = -1
int iBioAsked = 0
bool bPaired = false

string Property MODNAME = "O'Deadly Skyrim" AutoReadOnly

; ======================= lifecycle =======================
Event OnInit()
	InitArrays()
	Register()
EndEvent

Function InitArrays()
	If Protected == None
		Protected = new Form[64]
	EndIf
	If OvrLoc == None
		OvrLoc = new Form[128]
		OvrAtk = new float[128]
		OvrCheat = new float[128]
	EndIf
	If OvrJail == None
		OvrJail = new int[128]
	EndIf
	If PlaceNames == None
		PlaceNames = new string[64]
		PlaceCats = new int[64]
	EndIf
	If bCrType == None
		bCrType = new bool[7]
		int i = 0
		While i < 7
			bCrType[i] = true
			i += 1
		EndWhile
	EndIf
	If iCrStatus == None
		iCrStatus = new int[7]
		int j = 0
		While j < 7
			iCrStatus[j] = 3
			j += 1
		EndWhile
	EndIf
	If kAtt == None
		kAtt = new Actor[4]
		kVic = new Actor[2]
		kSpawned = new Actor[8]
		fOldAgg = new float[4]
		fOldConf = new float[4]
		bAddedFac = new bool[4]
		kPacified = new Actor[8]
		fPacAgg = new float[8]
	EndIf
EndFunction

; registrations are cheap and event-only: no polling anywhere
Function Register()
	RegisterForSleep()
	RegisterForMenu("Sleep/Wait Menu")
	RegisterForModEvent("ostim_thread_end", "OnOStimThreadEnd")
	RegisterForModEvent("ostim_thread_start", "OnOStimThreadStart")
	RegisterForModEvent("ostim_thread_scenechanged", "OnOStimSceneChanged")
	RegisterForModEvent("ODN_NightAttack", "OnODNNightAttack")
	RegisterPanicKey()
EndFunction

Function RegisterPanicKey()
	UnregisterForAllKeys()
	If iPanicKey > 0
		RegisterForKey(iPanicKey)
	EndIf
EndFunction

; called by ODS_PlayerAlias.OnPlayerLoadGame
Function OnGameLoaded()
	InitArrays()
	Register()
	If bBusy && iThread < 0 && iThread2 < 0 && bAftermathDone
		bBusy = false
	EndIf
	iPlaceAPI = -1
	iDecisionAPI = -1
	bOCreatures = OCreaturesInstalled()
	If bOCreatures && bCrEnabled && bMaster
		DetectCreatures()
	ElseIf !bOCreatures
		int i = 0
		While i < 7
			iCrStatus[i] = 0
			i += 1
		EndWhile
	EndIf
	UpdateEssential()
	If bMaster
		FillFollowerAliases()
		RefreshTimers(PlayerRef.GetCurrentLocation())
	EndIf
EndFunction

Function Log(string s)
	Debug.Trace("[ODeadlySkyrim] " + s)
	If bDebug && bMaster
		Debug.Notification("[ODS] " + s)
	EndIf
EndFunction

Function ShowMsg(string s)
	If !bMaster
		return
	EndIf
	If iMsgStyle == 0
		Debug.MessageBox(s)
	ElseIf iMsgStyle == 1
		Debug.Notification(s)
	EndIf
EndFunction

; ======================= soft detection (no masters) =======================
bool Function ModLoaded(string n)
	return Game.GetModByName(n) != 255
EndFunction

bool Function OStimOK()
	return ModLoaded("OStim.esp")
EndFunction

bool Function SNetOK()
	return ModLoaded("SkyrimNet.esp")
EndFunction

bool Function OCreaturesInstalled()
	return ModLoaded("OCreatures.esp")
EndFunction

bool Function OCumOK()
	return ModLoaded("OCum.esp")
EndFunction

bool Function ZaZOK()
	return ModLoaded("ZaZAnimationPack.esm")
EndFunction

bool Function ODNLoaded()
	return ModLoaded("ODangerousNights.esp") || ModLoaded("ODangerousNights.esl")
EndFunction

bool Function PO3OK()
	return SKSE.GetPluginVersion("powerofthree's Papyrus Extender") > 0
EndFunction

; mod is on and able to run
bool Function Ready()
	return bMaster && OStimOK()
EndFunction

; still the same run (no panic / master off since staging began)
bool Function Alive(int ep)
	return bMaster && ep == iEpoch
EndFunction

; ======================= MASTER KILL SWITCH / PANIC =======================
Event OnKeyDown(int keyCode)
	If keyCode == iPanicKey && iPanicKey > 0
		Panic()
	EndIf
EndEvent

; master turned on from the MCM
Function EnableMaster()
	bMaster = true
	iEpoch += 1
	Register()
	UpdateEssential()
	FillFollowerAliases()
	bOCreatures = OCreaturesInstalled()
	If bOCreatures && bCrEnabled
		DetectCreatures()
	EndIf
	RefreshTimers(PlayerRef.GetCurrentLocation())
	Log("master ON")
EndFunction

; panic key or master OFF: everything stops now and stays off
Function Panic()
	bMaster = false
	iEpoch += 1
	AbortAll()
	If bPanicNotice
		Debug.Notification("O'Deadly Skyrim is off.")
	EndIf
	Debug.Trace("[ODeadlySkyrim] panic / master off")
EndFunction

Function AbortAll()
	bAftermathDone = true
	int t = iThread
	int t2 = iThread2
	iThread = -1
	iThread2 = -1
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)       ; OStim redresses the actors it undressed
	EndIf
	If t2 >= 0 && OThread.IsRunning(t2)
		OThread.Stop(t2)
	EndIf
	ClearFade()
	; give stolen gold back
	If kThief && iRobbedGold > 0 && !kThief.IsDead()
		kThief.RemoveItem(Gold001, iRobbedGold, true, PlayerRef)
	EndIf
	iRobbedGold = 0
	kThief = None
	RestoreAttackers(false)
	RestorePacified()
	DeleteAllSpawned()
	If EssentialAlias.GetReference()
		PlayerRef.RestoreActorValue("Health", 10000.0)
		EssentialAlias.Clear()
	EndIf
	If SNetOK()
		SkyrimNetApi.PurgeDialogue(false)
	EndIf
	fLingerDue = -1.0
	fTravelDue = -1.0
	UnregisterForUpdateGameTime()
	UnregisterForUpdate()
	iForceMode = 0
	kPendingSpouse = None
	kDefeatVictim = None
	ClearStage()
	bBusy = false
EndFunction

Function ClearStage()
	AttackerAlias.Clear()
	VictimAlias.Clear()
	Victim2Alias.Clear()
	Extra1Alias.Clear()
	Extra2Alias.Clear()
	Extra3Alias.Clear()
	int i = 0
	While i < 4
		kAtt[i] = None
		bAddedFac[i] = false
		i += 1
	EndWhile
	kVic[0] = None
	kVic[1] = None
	nAtt = 0
	nVic = 0
	kAttacker = None
	kVictim = None
	kVictim2 = None
	kSceneActs = None
	kSceneActs2 = None
	sScene2 = ""
	bPaired = false
	iKind = 0
EndFunction

Function ClearFade()
	FadeToBlackHoldIMod.PopTo(FadeToBlackBackIMod)
	FadeToBlackHoldIMod.Remove()
EndFunction

; ======================= spawned actor bookkeeping =======================
Function AddSpawn(Actor a)
	int i = kSpawned.Find(None)
	If i >= 0
		kSpawned[i] = a
	EndIf
EndFunction

bool Function IsSpawned(Actor a)
	return a && kSpawned.Find(a) >= 0
EndFunction

Function DeleteSpawn(Actor a)
	If a == None
		return
	EndIf
	int i = kSpawned.Find(a)
	If i >= 0
		kSpawned[i] = None
	EndIf
	a.Disable(false)
	a.Delete()
EndFunction

Function DeleteAllSpawned()
	int i = 0
	While i < 8
		Actor a = kSpawned[i]
		If a
			kSpawned[i] = None
			a.Disable(false)
			a.Delete()
		EndIf
		i += 1
	EndWhile
EndFunction

int Function SpawnCount()
	int c = 0
	int i = 0
	While i < 8
		If kSpawned[i]
			c += 1
		EndIf
		i += 1
	EndWhile
	return c
EndFunction

; ======================= creature detection (OCreatures, locked off when missing) =======================
FormList Function CrPool(int t)
	If t == 0
		return ODS_PoolWerewolf
	ElseIf t == 1
		return ODS_PoolDraugr
	ElseIf t == 2
		return ODS_PoolTroll
	ElseIf t == 3
		return ODS_PoolFalmer
	ElseIf t == 4
		return ODS_PoolSpriggan
	ElseIf t == 5
		return ODS_PoolGiant
	EndIf
	return ODS_PoolHagraven
EndFunction

string Function CrName(int t)
	If t == 0
		return "Werewolves"
	ElseIf t == 1
		return "Draugr"
	ElseIf t == 2
		return "Trolls"
	ElseIf t == 3
		return "Falmer"
	ElseIf t == 4
		return "Spriggans"
	ElseIf t == 5
		return "Giants"
	EndIf
	return "Hagravens"
EndFunction

; race-name key used to recognise a real nearby creature of that type
string Function CrKey(int t)
	If t == 0
		return "Werewolf"
	ElseIf t == 1
		return "Draugr"
	ElseIf t == 2
		return "Troll"
	ElseIf t == 3
		return "Falmer"
	ElseIf t == 4
		return "Spriggan"
	ElseIf t == 5
		return "Giant"
	EndIf
	return "Hagraven"
EndFunction

; spawn a disabled creature far below the player, ask OStim's library for any scene with it, delete it
int Function ProbePool(FormList pool)
	If !bOCreatures || pool == None || pool.GetSize() == 0
		return 0
	EndIf
	Actor c = PlayerRef.PlaceAtMe(pool.GetAt(0), 1, false, true) as Actor
	If c == None
		return 1
	EndIf
	c.SetPosition(PlayerRef.GetPositionX(), PlayerRef.GetPositionY(), PlayerRef.GetPositionZ() - 3000.0)
	int result = 1
	Actor[] acts = new Actor[2]
	acts[0] = c
	acts[1] = PlayerRef
	If OLibrary.GetRandomScene(acts) != ""
		result = 2
	Else
		Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, false)
		int i = 0
		While i < near.Length && result == 1
			Actor f = near[i]
			If f && IsFollowerActor(f) && !IsMinor(f)
				acts[1] = f
				If OLibrary.GetRandomScene(acts) != ""
					result = 2
				EndIf
			EndIf
			i += 1
		EndWhile
	EndIf
	c.Delete()
	return result
EndFunction

Function DetectCreatures()
	InitArrays()
	bOCreatures = OCreaturesInstalled()
	int t = 0
	While t < 7
		If bOCreatures
			iCrStatus[t] = ProbePool(CrPool(t))
		Else
			iCrStatus[t] = 0
		EndIf
		t += 1
	EndWhile
	Log("creatures: OCreatures " + bOCreatures + " status " + iCrStatus[0] + iCrStatus[1] + iCrStatus[2] + iCrStatus[3] + iCrStatus[4] + iCrStatus[5] + iCrStatus[6])
EndFunction

bool Function CrTypeOK(int t)
	return bCrEnabled && bOCreatures && iCrStatus[t] == 2 && bCrType[t]
EndFunction

bool Function AnyCreatureOK()
	If !bCrEnabled || !bOCreatures
		return false
	EndIf
	int t = 0
	While t < 7
		If CrTypeOK(t)
			return true
		EndIf
		t += 1
	EndWhile
	return false
EndFunction

; which creature type a real actor is (-1 none/not allowed)
int Function CreatureTypeOf(Actor a)
	Race r = a.GetRace()
	If r == None
		return -1
	EndIf
	string rn = r.GetName() + " " + PO3_SKSEFunctions.GetFormEditorID(r)
	int t = 0
	While t < 7
		If StringUtil.Find(rn, CrKey(t)) >= 0
			return t
		EndIf
		t += 1
	EndWhile
	return -1
EndFunction

bool Function IsHumanoid(Actor a)
	Race r = a.GetRace()
	Keyword npc = Keyword.GetKeyword("ActorTypeNPC")
	return r && npc && r.HasKeyword(npc)
EndFunction

; humanoids always OK; creatures only via the OCreatures module and an enabled, detected type
bool Function CreatureAllowed(Actor a)
	If IsHumanoid(a)
		return true
	EndIf
	int t = CreatureTypeOf(a)
	return t >= 0 && CrTypeOK(t)
EndFunction

; ======================= ODN / busy soft-compat =======================
Event OnODNNightAttack(Form akAttacker, bool abSpawned)
	fLastODNAttack = Utility.GetCurrentGameTime()
EndEvent

bool Function OtherBusy(bool allowCombat)
	If !allowCombat && PlayerRef.IsInCombat()
		return true
	EndIf
	If OActor.IsInOStim(PlayerRef)
		return true
	EndIf
	If (Utility.GetCurrentGameTime() - fLastODNAttack) < 0.5
		return true
	EndIf
	return false
EndFunction

bool Function CooldownActive()
	return (Utility.GetCurrentGameTime() - fLastEvent) * 24.0 < fCooldownHours
EndFunction

; ======================= locations (Sleep Ambush port) =======================
bool Function HasKW(Location loc, string kw)
	If loc == None
		return false
	EndIf
	Keyword k = Keyword.GetKeyword(kw)
	return k && loc.HasKeyword(k)
EndFunction

bool Function TreeHasKW(Location loc, string kw)
	int n = 0
	While loc && n < 6
		If HasKW(loc, kw)
			return true
		EndIf
		loc = PO3_SKSEFunctions.GetParentLocation(loc)
		n += 1
	EndWhile
	return false
EndFunction

; 0 walled-city player home, 1 other player home, 2 inn, 3 city/town, 4 settlement, 5 wilderness, 6 camp, 7 dungeon
int Function GetLocCategory()
	int pc = PlaceCategory()
	If pc >= 0 && pc < 8
		return pc
	EndIf
	Location loc = PlayerRef.GetCurrentLocation()
	Cell cl = PlayerRef.GetParentCell()
	bool interior = cl && cl.IsInterior()
	If loc
		If HasKW(loc, "LocTypePlayerHouse")
			If TreeHasKW(loc, "LocTypeCity")
				return 0
			EndIf
			return 1
		EndIf
		If HasKW(loc, "LocTypeInn")
			return 2
		EndIf
		If HasKW(loc, "LocTypeBanditCamp") || HasKW(loc, "LocTypeMilitaryCamp") || HasKW(loc, "LocTypeGiantCamp") || HasKW(loc, "LocTypeForswornCamp")
			return 6
		EndIf
		If HasKW(loc, "LocTypeDungeon") || HasKW(loc, "LocTypeDraugrCrypt") || HasKW(loc, "LocTypeWerewolfLair") || HasKW(loc, "LocTypeVampireLair") || HasKW(loc, "LocTypeFalmerHive") || HasKW(loc, "LocTypeAnimalDen") || HasKW(loc, "LocTypeHagravenNest") || HasKW(loc, "LocTypeWarlockLair") || HasKW(loc, "LocTypeDwarvenAutomatons")
			return 7
		EndIf
		If TreeHasKW(loc, "LocTypeCity") || TreeHasKW(loc, "LocTypeTown")
			return 3
		EndIf
		If TreeHasKW(loc, "LocTypeSettlement") || TreeHasKW(loc, "LocTypeHabitation") || HasKW(loc, "LocTypeDwelling") || HasKW(loc, "LocTypeFarm") || HasKW(loc, "LocTypeLumberMill") || HasKW(loc, "LocTypeOrcStronghold")
			return 4
		EndIf
	EndIf
	If !interior
		return 5
	EndIf
	return 7
EndFunction

string Function CategoryName(int cat)
	If cat == 0
		return "Walled-city player home"
	ElseIf cat == 1
		return "Other player home"
	ElseIf cat == 2
		return "Inn"
	ElseIf cat == 3
		return "City / town"
	ElseIf cat == 4
		return "Settlement"
	ElseIf cat == 5
		return "Wilderness"
	ElseIf cat == 6
		return "Camp"
	ElseIf cat == 8
		return "Jail / barracks"
	EndIf
	return "Dungeon"
EndFunction

float Function CatAttack(int cat)
	If cat == 0
		return fAtkWalledHome
	ElseIf cat == 1
		return fAtkOtherHome
	ElseIf cat == 2
		return fAtkInn
	ElseIf cat == 3
		return fAtkCity
	ElseIf cat == 4
		return fAtkSettlement
	ElseIf cat == 5
		return fAtkWilderness
	ElseIf cat == 6
		return fAtkCamp
	EndIf
	return fAtkDungeon
EndFunction

float Function CatCheat(int cat)
	If cat == 0
		return fCheatWalledHome
	ElseIf cat == 1
		return fCheatOtherHome
	ElseIf cat == 2
		return fCheatInn
	ElseIf cat == 3
		return fCheatCity
	ElseIf cat == 4
		return fCheatSettlement
	ElseIf cat == 5
		return fCheatWilderness
	ElseIf cat == 6
		return fCheatCamp
	EndIf
	return fCheatDungeon
EndFunction

Form Function CurrentLocKey()
	Location loc = PlayerRef.GetCurrentLocation()
	If loc
		return loc
	EndIf
	return PlayerRef.GetParentCell()
EndFunction

string Function CurrentLocName()
	Form f = CurrentLocKey()
	If f == None
		return "(unknown)"
	EndIf
	string n = f.GetName()
	If n == ""
		n = "(unnamed)"
	EndIf
	return n
EndFunction

bool Function IsOutdoors()
	Cell cl = PlayerRef.GetParentCell()
	return cl && !cl.IsInterior()
EndFunction

; ======================= SkyrimNet version gates =======================
int Function LeadNum(string v)
	int n = StringUtil.GetLength(v)
	int i = 0
	int r = -1
	While i < n
		string c = StringUtil.GetNthChar(v, i)
		If StringUtil.IsDigit(c)
			If r < 0
				r = 0
			EndIf
			r = r * 10 + (c as int)
		ElseIf r >= 0
			return r
		EndIf
		i += 1
	EndWhile
	return r
EndFunction

int Function SNetMajor()
	string v = SkyrimNetApi.GetBuildVersion()
	int major = LeadNum(v)
	If major == 0
		int d = StringUtil.Find(v, ".")
		If d >= 0
			major = LeadNum(StringUtil.Substring(v, d + 1))
		EndIf
	EndIf
	return major
EndFunction

bool Function PlacesAvailable()
	If iPlaceAPI < 0
		iPlaceAPI = 0
		If SNetOK() && SNetMajor() >= 29
			iPlaceAPI = 1
		EndIf
	EndIf
	return iPlaceAPI == 1
EndFunction

; SendCustomDecisionToLLM ships with SkyrimNet beta28+
bool Function DecisionsAvailable()
	If iDecisionAPI < 0
		iDecisionAPI = 0
		If SNetOK() && SNetMajor() >= 28
			iDecisionAPI = 1
		EndIf
	EndIf
	return iDecisionAPI == 1
EndFunction

bool Function PlacesOK()
	return bUsePlaces && PlacesAvailable()
EndFunction

string Function CurrentPlaceName()
	If !PlacesOK()
		return ""
	EndIf
	return SkyrimNetApi.GetPlaceName(PlayerRef)
EndFunction

int Function PlaceCategory()
	string n = CurrentPlaceName()
	If n == ""
		return -1
	EndIf
	InitArrays()
	int i = PlaceNames.Find(n)
	If i < 0
		return -1
	EndIf
	return PlaceCats[i]
EndFunction

string Function WhereName()
	string p = CurrentPlaceName()
	string l = CurrentLocName()
	If p != "" && p != l
		If l == "(unknown)" || l == "(unnamed)"
			return p
		EndIf
		return p + ", " + l
	EndIf
	return l
EndFunction

Function SetPlaceCat(string n, int cat)
	InitArrays()
	int i = PlaceNames.Find(n)
	If cat < 0
		If i >= 0
			PlaceNames[i] = ""
			PlaceCats[i] = 0
		EndIf
		return
	EndIf
	If i < 0
		i = PlaceNames.Find("")
	EndIf
	If i >= 0
		PlaceNames[i] = n
		PlaceCats[i] = cat
	EndIf
EndFunction

int Function MarkHere(string nm, int cat)
	If !PlacesOK()
		return -1
	EndIf
	string cur = SkyrimNetApi.GetPlaceName(PlayerRef)
	If cur == ""
		If nm == ""
			nm = "Rest spot"
		EndIf
		If StringUtil.GetLength(nm) > 60
			nm = StringUtil.Substring(nm, 0, 60)
		EndIf
		If !SkyrimNetApi.MarkPlace(nm, fPlaceRadius)
			return 0
		EndIf
		cur = nm
	EndIf
	SetPlaceCat(cur, cat)
	return 1
EndFunction

Function UntagHere()
	string cur = CurrentPlaceName()
	If cur != ""
		SetPlaceCat(cur, -1)
	EndIf
EndFunction

bool Function DeletePlaceHere()
	If !PlacesOK()
		return false
	EndIf
	string cur = SkyrimNetApi.GetPlaceName(PlayerRef)
	string id = SkyrimNetApi.GetPlaceId(PlayerRef)
	If id == ""
		return false
	EndIf
	SetPlaceCat(cur, -1)
	return SkyrimNetApi.RemovePlace(id)
EndFunction

bool Function RenamePlaceHere(string nm)
	If !PlacesOK() || nm == ""
		return false
	EndIf
	string cur = SkyrimNetApi.GetPlaceName(PlayerRef)
	string id = SkyrimNetApi.GetPlaceId(PlayerRef)
	If id == "" || !SkyrimNetApi.RenamePlace(id, nm)
		return false
	EndIf
	InitArrays()
	int i = PlaceNames.Find(cur)
	If i >= 0
		PlaceNames[i] = nm
	EndIf
	return true
EndFunction

bool Function SetRadiusHere(float r)
	If !PlacesOK()
		return false
	EndIf
	string id = SkyrimNetApi.GetPlaceId(PlayerRef)
	If id == ""
		return false
	EndIf
	return SkyrimNetApi.SetPlaceRadius(id, r)
EndFunction

; ======================= per-location overrides =======================
int Function OvrIndex(Form f, bool create)
	InitArrays()
	If f == None
		return -1
	EndIf
	int i = OvrLoc.Find(f)
	If i < 0 && create
		i = OvrLoc.Find(None)
		If i >= 0
			OvrLoc[i] = f
			OvrAtk[i] = -1.0
			OvrCheat[i] = -1.0
			OvrJail[i] = 0
		EndIf
	EndIf
	return i
EndFunction

float Function GetOverride(bool cheat)
	int i = OvrIndex(CurrentLocKey(), false)
	If i < 0
		return -1.0
	EndIf
	If cheat
		return OvrCheat[i]
	EndIf
	return OvrAtk[i]
EndFunction

Function TidyOverride(int i)
	If OvrAtk[i] < 0.0 && OvrCheat[i] < 0.0 && OvrJail[i] == 0
		OvrLoc[i] = None
	EndIf
EndFunction

Function SetOverride(bool cheat, float v)
	int i = OvrIndex(CurrentLocKey(), true)
	If i < 0
		return
	EndIf
	If cheat
		OvrCheat[i] = v
	Else
		OvrAtk[i] = v
	EndIf
	TidyOverride(i)
EndFunction

int Function GetJailOverride()
	int i = OvrIndex(CurrentLocKey(), false)
	If i < 0
		return 0
	EndIf
	return OvrJail[i]
EndFunction

Function SetJailOverride(int v)
	int i = OvrIndex(CurrentLocKey(), true)
	If i < 0
		return
	EndIf
	OvrJail[i] = v
	TidyOverride(i)
EndFunction

Function ClearOverridesHere()
	int i = OvrIndex(CurrentLocKey(), false)
	If i >= 0
		OvrAtk[i] = -1.0
		OvrCheat[i] = -1.0
		OvrJail[i] = 0
		OvrLoc[i] = None
	EndIf
EndFunction

float Function GetAttackChance()
	float o = GetOverride(false)
	If o >= 0.0
		return o
	EndIf
	return CatAttack(GetLocCategory())
EndFunction

float Function GetCheatChance()
	float o = GetOverride(true)
	If o >= 0.0
		return o
	EndIf
	return CatCheat(GetLocCategory())
EndFunction

; ======================= jail / barracks detection (all holds) =======================
bool Function NameHas(string n, string a)
	return StringUtil.Find(n, a) >= 0
EndFunction

string Function LocCellText()
	Location loc = PlayerRef.GetCurrentLocation()
	string n = ""
	If loc
		n = loc.GetName()
	EndIf
	Cell cl = PlayerRef.GetParentCell()
	If cl
		n += " " + cl.GetName()
	EndIf
	return n
EndFunction

bool Function InJail()
	int o = GetJailOverride()
	If o == 2
		return false
	EndIf
	If o == 1 || PlaceCategory() == 8
		return true
	EndIf
	If TreeHasKW(PlayerRef.GetCurrentLocation(), "LocTypeJail")
		return true
	EndIf
	string n = LocCellText()
	return NameHas(n, "Jail") || NameHas(n, "jail") || NameHas(n, "Prison") || NameHas(n, "prison") || NameHas(n, "Dungeon") && TreeHasKW(PlayerRef.GetCurrentLocation(), "LocTypeCity")
EndFunction

bool Function InBarracks()
	int o = GetJailOverride()
	If o == 2
		return false
	EndIf
	If o == 1 || PlaceCategory() == 8
		return true
	EndIf
	If HasKW(PlayerRef.GetCurrentLocation(), "LocTypeBarracks")
		return true
	EndIf
	string n = LocCellText()
	If NameHas(n, "Barracks") || NameHas(n, "barracks") || NameHas(n, "Guard House") || NameHas(n, "Guardhouse") || NameHas(n, "guardhouse") || NameHas(n, "Garrison") || NameHas(n, "garrison")
		return true
	EndIf
	Cell cl = PlayerRef.GetParentCell()
	return cl && cl.IsInterior() && (NameHas(n, "Guard Tower") || NameHas(n, "Guards' Quarters") || NameHas(n, "Guard Quarters"))
EndFunction

bool Function InJailOrBarracks()
	return InJail() || InBarracks()
EndFunction

; ======================= guards =======================
bool Function IsGuardActor(Actor a)
	If a == None
		return false
	EndIf
	If a.IsGuard()
		return true
	EndIf
	string n = a.GetDisplayName()
	return StringUtil.Find(n, "Guard") >= 0 || StringUtil.Find(n, "guard") >= 0
EndFunction

bool Function GuardsNearby()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fGuardRange, false, false, false)
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && !a.IsDead() && !a.IsDisabled() && IsGuardActor(a) && !a.IsHostileToActor(PlayerRef) && !a.IsPlayerTeammate()
			return true
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

; ======================= spouse =======================
bool Function IsSpouse(Actor a)
	If a == None || a == PlayerRef
		return false
	EndIf
	Quest q = Quest.GetQuest("RelationshipMarriageFIN")
	If q
		ReferenceAlias li = q.GetAliasByName("LoveInterest") as ReferenceAlias
		If li && li.GetActorReference() == a
			return true
		EndIf
	EndIf
	Faction mf = PO3_SKSEFunctions.GetFormFromEditorID("PlayerMarriedFaction") as Faction
	If mf && a.IsInFaction(mf)
		return true
	EndIf
	If bLoverIsSpouse && a.GetRelationshipRank(PlayerRef) >= 4 && IsFollowerActor(a)
		return true
	EndIf
	return false
EndFunction

bool Function IsValidSpouse(Actor a)
	If a == None || a.IsDead() || a.IsDisabled() || a.IsInCombat() || IsMinor(a) || OActor.IsInOStim(a)
		return false
	EndIf
	return IsSpouse(a)
EndFunction

Actor Function FindSpouseNearby()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, false)
	int i = 0
	While i < near.Length
		If IsValidSpouse(near[i])
			return near[i]
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

; ======================= participant checks: NEVER minors =======================
bool Function IsMinor(Actor a)
	If a == None
		return true
	EndIf
	If a.IsChild()
		return true
	EndIf
	If OUtils.IsChild(a)
		return true
	EndIf
	Race r = a.GetRace()
	If r
		string rn = r.GetName()
		If StringUtil.Find(rn, "Child") >= 0 || StringUtil.Find(rn, "child") >= 0
			return true
		EndIf
		string re = PO3_SKSEFunctions.GetFormEditorID(r)
		If StringUtil.Find(re, "Child") >= 0 || StringUtil.Find(re, "child") >= 0
			return true
		EndIf
	EndIf
	ActorBase b = a.GetLeveledActorBase()
	If b && StringUtil.Find(b.GetName(), "Child") >= 0
		return true
	EndIf
	return false
EndFunction

bool Function IsFollowerActor(Actor a)
	return a && (a.IsPlayerTeammate() || a.IsInFaction(CurrentFollowerFaction))
EndFunction

bool Function IsProtected(Actor a)
	If bProtectSerana
		ActorBase serana = Game.GetFormFromFile(0x2B6C, "Dawnguard.esm") as ActorBase
		If serana && a.GetActorBase() == serana
			return true
		EndIf
		If a.GetDisplayName() == "Serana"
			return true
		EndIf
	EndIf
	If Protected
		If Protected.Find(a as Form) >= 0 || Protected.Find(a.GetActorBase() as Form) >= 0
			return true
		EndIf
	EndIf
	return false
EndFunction

bool Function GenderOK(Actor a)
	If iVictimGender == 0
		return true
	EndIf
	int sex = a.GetLeveledActorBase().GetSex()
	If iVictimGender == 1
		return sex == 1
	EndIf
	return sex == 0
EndFunction

bool Function IsFemale(Actor a)
	return a && a.GetLeveledActorBase().GetSex() == 1
EndFunction

; quest-critical guard: essential/protected unique NPCs are skipped unless "Named NPCs" is on
bool Function NamedOK(Actor a)
	If bAllowNamed || IsSpawned(a)
		return true
	EndIf
	ActorBase b = a.GetActorBase()
	If b && b.IsUnique() && (a.IsEssential() || b.IsEssential() || b.IsProtected())
		return false
	EndIf
	return true
EndFunction

bool Function IsStaged(Actor a)
	return kAtt.Find(a) >= 0 || kVic.Find(a) >= 0
EndFunction

; victim check, per context
bool Function IsValidVictim(Actor a, bool allowPlayer, bool allowFollowers, bool allowCombat = false)
	If a == None || a.IsDead() || a.IsDisabled()
		return false
	EndIf
	If !allowCombat && a.IsInCombat()
		return false
	EndIf
	If IsMinor(a) || OActor.IsInOStim(a) || IsStaged(a)
		return false
	EndIf
	If !bGuardVictims && IsGuardActor(a) && a != PlayerRef
		return false
	EndIf
	If !GenderOK(a)
		return false
	EndIf
	If a == PlayerRef
		return allowPlayer
	EndIf
	If !allowFollowers || !IsFollowerActor(a)
		return false
	EndIf
	return !IsProtected(a)
EndFunction

; pick one victim near the player into kVic[nVic]; returns it
Actor Function PickVictim(bool allowPlayer, bool allowFollowers)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, true)
	Actor[] pool = new Actor[32]
	int c = 0
	int i = 0
	While i < near.Length && c < 31
		If IsValidVictim(near[i], false, allowFollowers)
			pool[c] = near[i]
			c += 1
		EndIf
		i += 1
	EndWhile
	If IsValidVictim(PlayerRef, allowPlayer, false)
		pool[c] = PlayerRef
		c += 1
	EndIf
	If c == 0
		return None
	EndIf
	Actor v = pool[Utility.RandomInt(0, c - 1)]
	AddVictim(v)
	return v
EndFunction

Function AddVictim(Actor v)
	If v && nVic < 2
		kVic[nVic] = v
		nVic += 1
	EndIf
EndFunction

Function AddAttacker(Actor a)
	If a && nAtt < 4
		kAtt[nAtt] = a
		nAtt += 1
	EndIf
EndFunction

; base eligibility for any non-victim participant
bool Function BaseEligible(Actor a, bool allowCombat = false)
	If a == None || a == PlayerRef || a.IsDead() || a.IsDisabled()
		return false
	EndIf
	If !allowCombat && a.IsInCombat()
		return false
	EndIf
	If IsMinor(a) || OActor.IsInOStim(a) || IsStaged(a)
		return false
	EndIf
	return NamedOK(a)
EndFunction

; ======================= drunk / skooma detection (read only at roll time) =======================
bool Function IsDrunk(Actor a)
	If a == None
		return false
	EndIf
	MagicEffect[] fx = PO3_SKSEFunctions.GetActiveEffects(a, false)
	int i = 0
	While i < fx.Length
		If fx[i]
			string n = fx[i].GetName() + " " + PO3_SKSEFunctions.GetFormEditorID(fx[i])
			If NameHas(n, "Drunk") || NameHas(n, "drunk") || NameHas(n, "Alcohol") || NameHas(n, "alcohol") || NameHas(n, "Skooma") || NameHas(n, "skooma") || NameHas(n, "Intoxic") || NameHas(n, "intoxic") || NameHas(n, "Inebriat") || NameHas(n, "Mead") || NameHas(n, "Sujamma") || NameHas(n, "Wine") || NameHas(n, "Ale")
				return true
			EndIf
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

; ======================= SkyrimNet "would they?" check =======================
; Uses SkyrimNetApi.SendCustomDecisionToLLM (beta28+) with the shipped template
; SKSE/Plugins/SkyrimNet/external/coronerra.odeadly/prompts/decisions/odeadly/would_act.prompt.
; Any failure (no decisions provider, timeout, old SkyrimNet) falls back to the heuristic.
string Function JsonSafe(string s)
	string o = ""
	int n = StringUtil.GetLength(s)
	int i = 0
	While i < n
		string c = StringUtil.GetNthChar(s, i)
		If c != "\"" && c != "\\"
			o += c
		EndIf
		i += 1
	EndWhile
	return o
EndFunction

Function OnBioDecision(String answer, String resultJson, int success)
	If success == 1 && answer == "true"
		iBioAnswer = 1
	ElseIf success == 1 && answer == "false"
		iBioAnswer = 0
	Else
		iBioAnswer = 2
	EndIf
EndFunction

; 1 yes, 0 no, 2 unknown
int Function AskBio(Actor a, Actor v, string situation, int ep)
	If !bBioCheck || !SNetOK() || !DecisionsAvailable() || iBioAsked >= 2
		return 2
	EndIf
	iBioAsked += 1
	iBioAnswer = -1
	string ctx = "{\"actor_name\":\"" + JsonSafe(a.GetDisplayName()) + "\",\"target_name\":\"" + JsonSafe(v.GetDisplayName()) + "\",\"situation\":\"" + JsonSafe(situation) + "\"}"
	int rc = SkyrimNetApi.SendCustomDecisionToLLM("odeadly/would_act", ctx, self, "ODS_Main", "OnBioDecision")
	If rc != 1
		return 2
	EndIf
	float waited = 0.0
	While iBioAnswer < 0 && waited < fBioTimeout && Alive(ep)
		Utility.Wait(0.5)
		waited += 0.5
	EndWhile
	If iBioAnswer < 0
		return 2
	EndIf
	return iBioAnswer
EndFunction

bool Function Heuristic(Actor a, Actor v, int kind)
	If !bMoralityFilter || kind == K_JAIL
		return true
	EndIf
	float m = a.GetActorValue("Morality")     ; 0 any crime .. 3 no crime
	If kind == K_BETRAYAL
		return m <= 1.0 || a.GetRelationshipRank(PlayerRef) <= 0
	EndIf
	If (kind == K_INN || kind == K_SPIKED) && bDrunkEvent
		return m <= 2.0 || a.GetRelationshipRank(v) < 0
	EndIf
	return m <= 1.0 || a.GetRelationshipRank(v) < 0
EndFunction

; would this real NPC do it? hostiles always would; others ask SkyrimNet, else heuristic
bool Function WouldAct(Actor a, Actor v, int kind, string situation, int ep)
	If IsSpawned(a) || a.IsHostileToActor(PlayerRef) || a.IsHostileToActor(v)
		return true
	EndIf
	If !IsHumanoid(a)
		return true
	EndIf
	int r = AskBio(a, v, situation, ep)
	If r == 1
		return true
	ElseIf r == 0
		Log(a.GetDisplayName() + ": SkyrimNet says no")
		return false
	EndIf
	return Heuristic(a, v, kind)
EndFunction

; ======================= OStim scene search =======================
bool Function IsAggroScene(string s)
	return OMetaData.HasSceneTag(s, "aggressive") || OMetaData.HasSceneTag(s, "forced") || OMetaData.HasSceneTag(s, "rough") || OMetaData.HasSceneTag(s, "rape")
EndFunction

; scene filter: never start (or stay in) a kissing scene, in any module
bool Function IsKissScene(string s)
	If s == ""
		return false
	EndIf
	If OMetaData.HasAnySceneTagCSV(s, "kiss,kissing,kisses,frenchkiss,frenchkissing,makeout,making out,makingout")
		return true
	EndIf
	If OMetaData.FindAnyActionCSV(s, "kissing,frenchkissing,kissingcheek,kissingneck,kissinghand,kissingfoot") >= 0
		return true
	EndIf
	return StringUtil.Find(s, "kiss") >= 0 || StringUtil.Find(s, "Kiss") >= 0 || StringUtil.Find(s, "KISS") >= 0 || StringUtil.Find(s, "makeout") >= 0 || StringUtil.Find(s, "Makeout") >= 0
EndFunction

; one random pick with a tag set, retried a few times to skip kissing scenes
string Function PickTagged(Actor[] acts, string tags, bool rejectAggro)
	int t = 0
	While t < 8
		string s
		If tags == ""
			s = OLibrary.GetRandomScene(acts)
		Else
			s = OLibrary.GetRandomSceneWithAnySceneTagCSV(acts, tags)
		EndIf
		If s == ""
			return ""
		EndIf
		If !IsKissScene(s) && (!rejectAggro || !IsAggroScene(s))
			return s
		EndIf
		t += 1
	EndWhile
	return ""
EndFunction

string Function TagSearch(Actor[] acts, bool forced)
	If forced
		string s = ""
		If iKind == K_JAIL && bZaZ && ZaZOK()
			s = PickTagged(acts, "bondage,restrained,pillory,tied", false)
		EndIf
		If s == ""
			s = PickTagged(acts, "aggressive,forced,rough", false)
		EndIf
		If s == "" && bFallbackAnyScene
			s = PickTagged(acts, "", false)
		EndIf
		return s
	EndIf
	string c = PickTagged(acts, "lustful,romantic,loving,sensual,passionate,seduction", true)
	If c == ""
		c = PickTagged(acts, "", true)
	EndIf
	return c
EndFunction

; attackers first, then victims; tries the given order, then the reverse / OStim-sorted order. Sets outActs.
string Function SceneForSet(Actor[] att, int na, Actor[] vic, int nv, bool forced, Actor[] outActs)
	int total = na + nv
	Actor[] acts = OActorUtil.CreateArray(total)
	int i = 0
	While i < na
		acts[i] = att[i]
		i += 1
	EndWhile
	int j = 0
	While j < nv
		acts[na + j] = vic[j]
		j += 1
	EndWhile
	int q = 0
	While q < total
		If IsMinor(acts[q])
			return ""   ; absolute: no children in any role
		EndIf
		q += 1
	EndWhile
	string s = TagSearch(acts, forced)
	If s == ""
		If total == 2
			Actor tmp = acts[0]
			acts[0] = acts[1]
			acts[1] = tmp
			s = TagSearch(acts, forced)
		Else
			Actor[] dom = OActorUtil.CreateArray(na)
			int k = 0
			While k < na
				dom[k] = att[k]
				k += 1
			EndWhile
			acts = OActorUtil.Sort(acts, dom)
			s = TagSearch(acts, forced)
		EndIf
	EndIf
	If s != ""
		int m = 0
		While m < total && m < outActs.Length
			outActs[m] = acts[m]
			m += 1
		EndWhile
	EndIf
	return s
EndFunction

; scene for a single pair (used to qualify candidates)
string Function PairScene(Actor att, Actor vic, bool forced)
	If IsMinor(att) || IsMinor(vic)
		return ""
	EndIf
	Actor[] a1 = new Actor[1]
	a1[0] = att
	Actor[] v1 = new Actor[1]
	v1[0] = vic
	Actor[] outA = new Actor[2]
	return SceneForSet(a1, 1, v1, 1, forced, outA)
EndFunction

; final scene for everything staged; drops extras (deleting spawned ones), then the 2nd victim, down to 1v1
string Function BuildScene(bool forced)
	While nAtt >= 1 && nVic >= 1
		Actor[] outA = new Actor[6]
		string s = SceneForSet(kAtt, nAtt, kVic, nVic, forced, outA)
		If s != ""
			int total = nAtt + nVic
			kSceneActs = OActorUtil.CreateArray(total)
			int i = 0
			While i < total
				kSceneActs[i] = outA[i]
				i += 1
			EndWhile
			return s
		EndIf
		If nAtt > 1
			nAtt -= 1
			Actor ex = kAtt[nAtt]
			kAtt[nAtt] = None
			If IsSpawned(ex)
				DeleteSpawn(ex)
			EndIf
			Log("no group scene, dropping an extra")
		ElseIf nVic > 1
			nVic -= 1
			kVic[nVic] = None
			Log("no scene with two victims, dropping one")
		Else
			return ""
		EndIf
	EndWhile
	return ""
EndFunction

; release everything staged that never started (spawns deleted)
Function ReleaseStaged()
	int i = 0
	While i < 4
		Actor a = kAtt[i]
		If a && IsSpawned(a)
			DeleteSpawn(a)
		EndIf
		kAtt[i] = None
		i += 1
	EndWhile
	nAtt = 0
	kVic[0] = None
	kVic[1] = None
	nVic = 0
EndFunction

; ======================= rest hooks: sleep and wait =======================
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	bSleptThisMenu = true
	If !Ready()
		return
	EndIf
	float hours = (afDesiredSleepEndTime - afSleepStartTime) * 24.0
	If hours < 1.0
		return
	EndIf
	HandleRest(hours, true)
EndEvent

Event OnMenuOpen(string menuName)
	If menuName == "Sleep/Wait Menu"
		fMenuOpenGT = Utility.GetCurrentGameTime()
		bSleptThisMenu = false
	EndIf
EndEvent

Event OnMenuClose(string menuName)
	If menuName != "Sleep/Wait Menu" || bSleptThisMenu || !Ready()
		return
	EndIf
	float hours = (Utility.GetCurrentGameTime() - fMenuOpenGT) * 24.0
	If hours >= 1.0
		HandleRest(hours, false)
	EndIf
	CheckBlackmail()
EndEvent

float Function Mod(float c, bool drunk)
	If drunk && bDrunkMod
		c = c * fDrunkMult
	EndIf
	If c > 100.0
		c = 100.0
	EndIf
	return c
EndFunction

; per-hour rolls over every module that fits this place; returns the kind (0 none), sets iHitHour
int Function RollKinds(int hours, bool isSleep)
	InitArrays()
	float[] ch = new float[12]
	int cat = GetLocCategory()
	bool drunk = IsDrunk(PlayerRef)
	bool jail = InJailOrBarracks()
	bool sleepish = isSleep || bWaitAsSleep
	kPendingSpouse = None
	If bJailEnabled && jail
		ch[K_JAIL] = fJailChance
	EndIf
	If bTrespassEnabled && IsTrespassing()
		ch[K_TRESPASS] = Mod(fTrespassChance, drunk)
	EndIf
	If bCheatEnabled && sleepish
		kPendingSpouse = FindSpouseNearby()
		If kPendingSpouse
			ch[K_CHEAT] = GetCheatChance()
		EndIf
	EndIf
	If bBetrayal && (isSleep || drunk)
		ch[K_BETRAYAL] = Mod(fBetrayalChance, drunk)
	EndIf
	If cat == 2
		If bSpiked
			ch[K_SPIKED] = Mod(fSpikedChance, drunk)
		EndIf
		If bInnPlayer
			ch[K_INN] = Mod(fInnPlayerChance, drunk)
		EndIf
	EndIf
	If bVampire && sleepish && (cat == 7 || HasKW(PlayerRef.GetCurrentLocation(), "LocTypeVampireLair"))
		ch[K_VAMPIRE] = fVampireChance
	EndIf
	If isSleep && AnyCreatureOK() && (cat == 5 || cat == 6 || cat == 7)
		ch[K_CREATURE] = fCrCampChance
	EndIf
	If bSleepEnabled && sleepish
		float atk = GetAttackChance()
		If bGuardsBlock && !(bGuardAttackers && jail) && GuardsNearby()
			atk = 0.0
		EndIf
		ch[K_ATTACK] = Mod(atk, drunk)
	EndIf
	If !isSleep && bTravelEnabled && cat == 5 && IsOutdoors()
		ch[K_ROAD] = fRoadWaitChance
	EndIf
	; priority order
	int[] order = new int[11]
	order[0] = K_JAIL
	order[1] = K_TRESPASS
	order[2] = K_CHEAT
	order[3] = K_BETRAYAL
	order[4] = K_SPIKED
	order[5] = K_INN
	order[6] = K_VAMPIRE
	order[7] = K_CREATURE
	order[8] = K_ATTACK
	order[9] = K_ROAD
	order[10] = 0
	int h = 1
	While h <= hours
		int k = 0
		While k < 10
			int kind = order[k]
			If ch[kind] > 0.0 && Utility.RandomFloat(0.0, 100.0) < ch[kind]
				iHitHour = h
				Log("rest " + hours + "h at " + WhereName() + " (" + CategoryName(cat) + ") -> kind " + kind + " at hour " + h)
				return kind
			EndIf
			k += 1
		EndWhile
		h += 1
	EndWhile
	Log("rest " + hours + "h at " + WhereName() + " (" + CategoryName(cat) + "): nothing (atk " + ch[K_ATTACK] + "%, jail " + ch[K_JAIL] + "%, cheat " + ch[K_CHEAT] + "%)")
	return 0
EndFunction

Function HandleRest(float hours, bool isSleep)
	If bBusy || OtherBusy(false)
		Log("skip rest: busy / ODN / OStim / combat")
		return
	EndIf
	int ep = iEpoch
	int kind = 0
	iHitHour = 1
	If iForceMode > 0 && iForceMode != K_DEFEAT
		kind = iForceMode
		iForceMode = 0
		If kind == K_CHEAT
			kPendingSpouse = FindSpouseNearby()
		EndIf
		Log("debug force kind " + kind)
	Else
		If CooldownActive()
			Log("skip rest: cooldown")
			return
		EndIf
		kind = RollKinds(hours as int, isSleep)
	EndIf
	If kind == 0
		return
	EndIf
	bBusy = true
	If isSleep
		Utility.WaitMenuMode(0.6 * iHitHour + 0.5)
	EndIf
	StageWithFade(kind, ep, true)
EndFunction

; ======================= staging =======================
Function StageWithFade(int kind, int ep, bool fromRest)
	If !Alive(ep)
		bBusy = false
		return
	EndIf
	FadeToBlackHoldIMod.Apply()
	If fromRest
		PlayerRef.MoveTo(PlayerRef)
		int n = 0
		While PlayerRef.GetSitState() != 0 && n < 20
			Utility.Wait(0.25)
			n += 1
		EndWhile
	EndIf
	Utility.Wait(0.5)
	If !Alive(ep) || OtherBusy(kind == K_DEFEAT)
		Log("abort staging")
		If Alive(ep)
			ClearFade()
			bBusy = false
		EndIf
		return
	EndIf
	ClearStage()
	iKind = kind
	iBioAsked = 0
	bool ok = Dispatch(kind, ep)
	If !ok
		If Alive(ep)
			ReleaseStaged()
			ClearStage()
			ClearFade()
			bBusy = false
		EndIf
		If kind == K_DEFEAT
			DefeatFailed(kDefeatVictim)
		EndIf
	EndIf
	kPendingSpouse = None
EndFunction

bool Function Dispatch(int kind, int ep)
	If kind == K_ATTACK
		return StageAttack(ep, 0)
	ElseIf kind == K_CHEAT
		return StageCheat(kPendingSpouse, ep)
	ElseIf kind == K_JAIL
		return StageJail(ep)
	ElseIf kind == K_INN || kind == K_SPIKED
		return StagePatron(kind, ep)
	ElseIf kind == K_DEFEAT
		return StageDefeat(kDefeatVictim, ep)
	ElseIf kind == K_TRESPASS
		return StageTrespass(ep)
	ElseIf kind == K_ROAD
		return StageRoad(ep)
	ElseIf kind == K_CREATURE
		return StageCreature(ep)
	ElseIf kind == K_BETRAYAL
		return StageBetrayal(ep)
	ElseIf kind == K_VAMPIRE
		return StageVampire(ep)
	EndIf
	return false
EndFunction

; ---------- spawning ----------
Actor Function SpawnNear(Form base, Actor anchor)
	If base == None || anchor == None
		return None
	EndIf
	Actor a = anchor.PlaceAtMe(base, 1, false, true) as Actor
	If a == None
		return None
	EndIf
	AddSpawn(a)
	float dx = anchor.GetPositionX() - PlayerRef.GetPositionX()
	float dy = anchor.GetPositionY() - PlayerRef.GetPositionY()
	If dx != 0.0 || dy != 0.0
		float len = Math.sqrt(dx * dx + dy * dy)
		dx = dx / len
		dy = dy / len
	Else
		float ang = Utility.RandomFloat(0.0, 360.0)
		dx = Math.cos(ang)
		dy = Math.sin(ang)
	EndIf
	float dist = Utility.RandomFloat(1050.0, 1750.0)
	a.SetPosition(anchor.GetPositionX() + dx * dist, anchor.GetPositionY() + dy * dist, anchor.GetPositionZ())
	PO3_SKSEFunctions.MoveToNearestNavmeshLocation(a)
	If IsMinor(a) || (!bGuardAttackers && IsGuardActor(a))
		DeleteSpawn(a)
		return None
	EndIf
	return a
EndFunction

; spawn from a pool and keep it only if OStim has a scene with the victim
Actor Function TrySpawn(FormList pool, Actor vic, bool forced, int ep)
	If pool == None || pool.GetSize() == 0 || !Alive(ep)
		return None
	EndIf
	Actor a = SpawnNear(pool.GetAt(Utility.RandomInt(0, pool.GetSize() - 1)), vic)
	If a == None
		return None
	EndIf
	If !Alive(ep)
		DeleteSpawn(a)
		return None
	EndIf
	If PairScene(a, vic, forced) == ""
		Log("no installed scene for " + a.GetDisplayName() + " - discarding spawn")
		DeleteSpawn(a)
		return None
	EndIf
	return a
EndFunction

; pick an available creature type that fits this place
int Function PickCreatureType()
	int cat = GetLocCategory()
	int[] cand = new int[7]
	int c = 0
	int t = 0
	While t < 7
		If CrTypeOK(t)
			bool fits = true
			If cat == 7
				fits = t == 1 || t == 2 || t == 3 || t == 0
			ElseIf IsOutdoors()
				fits = t != 3 && t != 1
			EndIf
			If fits
				cand[c] = t
				c += 1
			EndIf
		EndIf
		t += 1
	EndWhile
	If c == 0
		t = 0
		While t < 7
			If CrTypeOK(t)
				cand[c] = t
				c += 1
			EndIf
			t += 1
		EndWhile
	EndIf
	If c == 0
		return -1
	EndIf
	return cand[Utility.RandomInt(0, c - 1)]
EndFunction

Actor Function TryCreatures(Actor vic, int ep)
	int tries = 0
	Actor att = None
	While att == None && tries < 3
		int t = PickCreatureType()
		If t < 0
			return None
		EndIf
		att = TrySpawn(CrPool(t), vic, true, ep)
		tries += 1
	EndWhile
	return att
EndFunction

; real nearby attacker for a forced scene
Actor Function TryNearbyAttacker(Actor vic, bool guardsOnly, bool needHostile, int ep)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && a != vic && BaseEligible(a) && !IsFollowerActor(a) && CreatureAllowed(a)
			bool grd = IsGuardActor(a)
			bool ok = true
			If guardsOnly
				ok = grd
			Else
				If grd && !bGuardAttackers
					ok = false
				EndIf
				If needHostile && !(a.IsHostileToActor(PlayerRef) || a.IsHostileToActor(vic) || (bGuardAttackers && grd))
					ok = false
				EndIf
			EndIf
			If ok && PairScene(a, vic, true) != ""
				return a
			EndIf
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

; extras for a group scene: more real actors like the lead, then optional spawns
Function AddExtras(Actor vic, bool guardsOnly, bool hostileOnly, FormList spawnPool, Form copyBase, int ep)
	If !bGroupScenes || !Alive(ep)
		return
	EndIf
	int want = iGroupMax
	If want > 3
		want = 3
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
	int i = 0
	While i < near.Length && nAtt < want + 1
		Actor a = near[i]
		If a && a != vic && BaseEligible(a) && !IsFollowerActor(a) && CreatureAllowed(a)
			bool grd = IsGuardActor(a)
			bool ok = true
			If guardsOnly && !grd
				ok = false
			EndIf
			If !guardsOnly && grd && !bGuardAttackers
				ok = false
			EndIf
			If hostileOnly && !a.IsHostileToActor(PlayerRef) && !a.IsHostileToActor(vic)
				ok = false
			EndIf
			If ok && !hostileOnly && !guardsOnly && (!IsHumanoid(a) || a.GetSleepState() == 3 || !Heuristic(a, vic, iKind))
				ok = false
			EndIf
			If ok
				AddAttacker(a)
			EndIf
		EndIf
		i += 1
	EndWhile
	int guard = 0
	While nAtt < want + 1 && guard < 3 && Alive(ep)
		Actor s = None
		If spawnPool
			s = SpawnNear(spawnPool.GetAt(Utility.RandomInt(0, spawnPool.GetSize() - 1)), vic)
		ElseIf copyBase
			s = SpawnNear(copyBase, vic)
		EndIf
		If s
			AddAttacker(s)
		EndIf
		guard += 1
	EndWhile
EndFunction

; optional second victim for group scenes (player + follower, or two followers)
Function AddSecondVictim(bool allowPlayer, bool allowFollowers)
	If !bGroupScenes || !bGroupBoth || nVic != 1
		return
	EndIf
	PickVictim(allowPlayer, allowFollowers)
EndFunction

; ======================= module stagers =======================
; night attack (Sleep Ambush port). force: 0 normal
bool Function StageAttack(int ep, int force)
	Actor vic = PickVictim(bPlayerVictim, true)
	If vic == None
		Log("no valid victim nearby")
		return false
	EndIf
	If bCheatEnabled && IsSpouse(vic)
		Log("victim is the spouse - switching to cheating scene")
		ReleaseStaged()
		iKind = K_CHEAT
		return StageCheat(vic, ep)
	EndIf
	Actor att = None
	bool spawnedBandit = false
	If bAllowNearby
		att = TryNearbyAttacker(vic, false, true, ep)
	EndIf
	If att == None
		bool beastFirst = AnyCreatureOK() && Utility.RandomInt(1, 100) <= iBeastChance
		If beastFirst
			att = TryCreatures(vic, ep)
		EndIf
		If bAllowBandit && att == None
			att = TrySpawn(ODS_PoolBandit, vic, true, ep)
			spawnedBandit = att != None
		EndIf
		If !beastFirst && att == None && AnyCreatureOK()
			att = TryCreatures(vic, ep)
		EndIf
	EndIf
	If att == None
		Log("no attacker with an installed scene for this victim")
		return false
	EndIf
	AddAttacker(att)
	If spawnedBandit
		AddExtras(vic, false, true, ODS_PoolBandit, None, ep)
	ElseIf !IsSpawned(att)
		AddExtras(vic, false, true, None, None, ep)
	EndIf
	AddSecondVictim(bPlayerVictim, true)
	return StartEncounter(true, "odangerous,aggressive", ep)
EndFunction

; cheating spouse (Sleep Ambush port): consensual, never aggressive
bool Function IsValidPartner(Actor a, Actor sp)
	If a == None || a == sp || !BaseEligible(a)
		return false
	EndIf
	If !IsHumanoid(a) || a.GetSleepState() == 3
		return false
	EndIf
	bool fol = IsFollowerActor(a)
	bool grd = IsGuardActor(a)
	If bPartnerPatronsOnly && (fol || grd)
		return false
	EndIf
	If fol && !bPartnerFollowers
		return false
	EndIf
	If grd && !bPartnerGuards
		return false
	EndIf
	If !bPartnerSameGender && a.GetLeveledActorBase().GetSex() == sp.GetLeveledActorBase().GetSex()
		return false
	EndIf
	return true
EndFunction

bool Function StageCheat(Actor sp, int ep)
	If sp == None || !IsValidSpouse(sp)
		Log("cheating: no valid spouse nearby")
		return false
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange + 1000.0, false, false, false)
	Actor[] pool = new Actor[32]
	int c = 0
	int i = 0
	While i < near.Length && c < 32
		If IsValidPartner(near[i], sp)
			pool[c] = near[i]
			c += 1
		EndIf
		i += 1
	EndWhile
	Actor partner = None
	int tries = 0
	While tries < 6 && c > 0 && partner == None && Alive(ep)
		int k = Utility.RandomInt(0, c - 1)
		If PairScene(pool[k], sp, false) != ""
			partner = pool[k]
		Else
			pool[k] = pool[c - 1]
			c -= 1
		EndIf
		tries += 1
	EndWhile
	If partner == None
		Log("cheating: no partner with a suitable scene")
		return false
	EndIf
	AddAttacker(partner)
	AddVictim(sp)
	If GetLocCategory() == 2 && bDrunkEvent
		SendDrunkEvent()
	EndIf
	return StartEncounter(false, "odangerous,cheating", ep)
EndFunction

; real guards in this jail / barracks (never spawns the lead guard)
Actor Function FindGuard(Actor vic, Actor notThis, int ep)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && a != vic && a != notThis && IsGuardActor(a) && BaseEligible(a) && !IsFollowerActor(a)
			If PairScene(a, vic, true) != "" && WouldAct(a, vic, K_JAIL, "in the jail or guard barracks at " + WhereName(), ep)
				return a
			EndIf
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

Actor Function FemaleFollowerNearby()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, true)
	int i = 0
	While i < near.Length
		If IsFemale(near[i]) && IsValidVictim(near[i], false, true)
			return near[i]
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

; imprisonment & barracks (every hold)
bool Function StageJail(int ep)
	; paired staging when both are present
	If bJailPlayer && bJailFollowers && IsFemale(PlayerRef) && IsValidVictim(PlayerRef, true, false) && Utility.RandomInt(1, 100) <= 80
		Actor f = FemaleFollowerNearby()
		If f
			Actor g1 = FindGuard(PlayerRef, None, ep)
			If g1
				Actor g2 = FindGuard(f, g1, ep)
				If g2 == None && bJailSpawnExtras && Alive(ep)
					g2 = SpawnNear(g1.GetActorBase(), f)
					If g2 && PairScene(g2, f, true) == ""
						DeleteSpawn(g2)
						g2 = None
					EndIf
				EndIf
				If g2 && StagePair(g1, PlayerRef, g2, f, ep)
					return StartEncounter(true, "odangerous,aggressive,jail", ep)
				EndIf
				; closest real fallback: one scene with both if OStim has one, else 1v1
				AddAttacker(g1)
				If g2
					AddAttacker(g2)
				EndIf
				AddVictim(PlayerRef)
				AddVictim(f)
				AddExtras(PlayerRef, true, false, None, None, ep)
				return StartEncounter(true, "odangerous,aggressive,jail", ep)
			EndIf
		EndIf
	EndIf
	Actor vic = PickVictim(bJailPlayer, bJailFollowers)
	If vic == None
		Log("jail: no valid victim")
		return false
	EndIf
	Actor g = FindGuard(vic, None, ep)
	If g == None
		Log("jail: no real guard with a scene here")
		return false
	EndIf
	AddAttacker(g)
	Form copyBase = None
	If bJailSpawnExtras
		copyBase = g.GetActorBase()
	EndIf
	AddExtras(vic, true, false, None, copyBase, ep)
	AddSecondVictim(bJailPlayer, bJailFollowers)
	return StartEncounter(true, "odangerous,aggressive,jail", ep)
EndFunction

; two simultaneous 1v1 scenes; true if both have scenes
bool Function StagePair(Actor a1, Actor v1, Actor a2, Actor v2, int ep)
	Actor[] at = new Actor[1]
	Actor[] vi = new Actor[1]
	Actor[] o1 = new Actor[2]
	Actor[] o2 = new Actor[2]
	at[0] = a1
	vi[0] = v1
	string s1 = SceneForSet(at, 1, vi, 1, true, o1)
	at[0] = a2
	vi[0] = v2
	string s2 = SceneForSet(at, 1, vi, 1, true, o2)
	If s1 == "" || s2 == "" || !Alive(ep)
		return false
	EndIf
	AddAttacker(a1)
	AddAttacker(a2)
	AddVictim(v1)
	AddVictim(v2)
	kSceneActs = o1
	kSceneActs2 = o2
	sScene1 = s1
	sScene2 = s2
	bPaired = true
	return true
EndFunction

; inn: drunk patrons (player) or a spiked drink
bool Function StagePatron(int kind, int ep)
	Actor vic
	If kind == K_INN
		vic = PickVictim(true, false)
	Else
		vic = PickVictim(bSpikedPlayer, bSpikedFollowers)
	EndIf
	If vic == None
		Log("inn: no valid victim")
		return false
	EndIf
	string sit = "a drunk patron at " + WhereName() + " late at night, with " + vic.GetDisplayName() + " alone and vulnerable"
	If kind == K_SPIKED
		sit = "at " + WhereName() + ", " + vic.GetDisplayName() + " has been slipped a drugged drink"
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 2500.0, false, false, true)
	Actor lead = None
	int i = 0
	While i < near.Length && lead == None && Alive(ep)
		Actor a = near[i]
		If a && a != vic && BaseEligible(a) && IsHumanoid(a) && !IsFollowerActor(a) && a.GetSleepState() != 3 && (bGuardAttackers || !IsGuardActor(a))
			If PairScene(a, vic, true) != "" && WouldAct(a, vic, kind, sit, ep)
				lead = a
			EndIf
		EndIf
		i += 1
	EndWhile
	If lead == None
		Log("inn: no willing patron with a scene")
		return false
	EndIf
	AddAttacker(lead)
	AddExtras(vic, false, false, None, None, ep)
	If bDrunkEvent
		SendDrunkEvent()
	EndIf
	return StartEncounter(true, "odangerous,aggressive,inn", ep)
EndFunction

; trespass: the owner or a resident finds the intruder
bool Function IsTrespassing()
	Cell cl = PlayerRef.GetParentCell()
	If cl == None || !cl.IsInterior()
		return false
	EndIf
	Location loc = PlayerRef.GetCurrentLocation()
	If HasKW(loc, "LocTypePlayerHouse") || HasKW(loc, "LocTypeInn") || InJailOrBarracks()
		return false
	EndIf
	ActorBase ob = cl.GetActorOwner()
	Faction ofc = cl.GetFactionOwner()
	If ob == None && ofc == None
		return false
	EndIf
	If ob && ob == PlayerRef.GetActorBase()
		return false
	EndIf
	If ofc && PlayerRef.IsInFaction(ofc)
		return false
	EndIf
	return true
EndFunction

bool Function StageTrespass(int ep)
	Cell cl = PlayerRef.GetParentCell()
	If cl == None
		return false
	EndIf
	ActorBase ob = cl.GetActorOwner()
	Faction ofc = cl.GetFactionOwner()
	Actor vic = PickVictim(bTrespassPlayer, bTrespassFollowers)
	If vic == None
		return false
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
	Actor lead = None
	int i = 0
	While i < near.Length && lead == None && Alive(ep)
		Actor a = near[i]
		If a && a != vic && BaseEligible(a) && IsHumanoid(a) && !IsFollowerActor(a)
			bool resident = (ob && a.GetActorBase() == ob) || (ofc && a.IsInFaction(ofc))
			If resident && PairScene(a, vic, true) != "" && WouldAct(a, vic, K_TRESPASS, "finding an intruder asleep in their home at " + WhereName(), ep)
				lead = a
			EndIf
		EndIf
		i += 1
	EndWhile
	If lead == None
		Log("trespass: no resident with a scene")
		return false
	EndIf
	AddAttacker(lead)
	AddSecondVictim(bTrespassPlayer, bTrespassFollowers)
	return StartEncounter(true, "odangerous,aggressive,trespass", ep)
EndFunction

; road robbery / toll; the gold goes into the thief's inventory (never deleted)
bool Function StageRoad(int ep)
	Actor thief = None
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
	int i = 0
	While i < near.Length && thief == None
		Actor a = near[i]
		If a && BaseEligible(a, true) && IsHumanoid(a) && !IsFollowerActor(a) && !IsGuardActor(a) && a.IsHostileToActor(PlayerRef)
			thief = a
		EndIf
		i += 1
	EndWhile
	If thief == None && Alive(ep)
		thief = SpawnNear(ODS_PoolBandit.GetAt(Utility.RandomInt(0, ODS_PoolBandit.GetSize() - 1)), PlayerRef)
	EndIf
	If thief == None || !Alive(ep)
		return false
	EndIf
	If IsSpawned(thief)
		thief.Enable()
	EndIf
	int gold = PlayerRef.GetItemCount(Gold001)
	int take = (gold * iRobberyPct) / 100
	If take > 0
		PlayerRef.RemoveItem(Gold001, take, true, thief)
		kThief = thief
		iRobbedGold = take
	EndIf
	fLastEvent = Utility.GetCurrentGameTime()
	; maybe it turns into a scene
	If Utility.RandomFloat(0.0, 100.0) < fRobberySceneChance
		Actor vic = PickVictim(bTravelPlayer, bTravelFollowers)
		If vic && PairScene(thief, vic, true) != ""
			AddAttacker(thief)
			If IsSpawned(thief)
				AddExtras(vic, false, true, ODS_PoolBandit, None, ep)
			EndIf
			AddSecondVictim(bTravelPlayer, bTravelFollowers)
			If StartEncounter(true, "odangerous,aggressive,road", ep)
				return true
			EndIf
			kAtt[0] = None   ; keep the thief (and the gold) in the world
			ReleaseStaged()
		EndIf
	EndIf
	; robbery only
	ClearFade()
	If take > 0
		ShowMsg(thief.GetDisplayName() + " robbed you of " + take + " gold!")
	Else
		ShowMsg(thief.GetDisplayName() + " shakes you down on the road and finds nothing worth taking.")
	EndIf
	If bSkyrimNetStart && SNetOK()
		SkyrimNetApi.DirectNarration(thief.GetDisplayName() + " ambushes " + PlayerRef.GetDisplayName() + " on the road near " + WhereName() + " and demands their coin.", thief, PlayerRef)
	EndIf
	If bSkyrimNetLog && SNetOK()
		SkyrimNetApi.RegisterPersistentEvent(thief.GetDisplayName() + " robbed " + PlayerRef.GetDisplayName() + " of " + take + " gold on the road near " + WhereName() + ".", thief, PlayerRef)
	EndIf
	thief.StartCombat(PlayerRef)
	iKind = K_ROAD
	bAftermathDone = true
	iCleanupTicks = 0
	RegisterForSingleUpdate(5.0)
	return true
EndFunction

; OCreatures encounter (camping or awake in the wild)
bool Function StageCreature(int ep)
	If !AnyCreatureOK()
		return false
	EndIf
	Actor vic = PickVictim(bCrPlayer, bCrFollowers)
	If vic == None
		return false
	EndIf
	Actor att = None
	If bAllowNearby
		Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3000.0, false, false, true)
		int i = 0
		While i < near.Length && att == None
			Actor a = near[i]
			If a && !IsHumanoid(a) && BaseEligible(a) && CreatureAllowed(a) && PairScene(a, vic, true) != ""
				att = a
			EndIf
			i += 1
		EndWhile
	EndIf
	If att == None
		att = TryCreatures(vic, ep)
	EndIf
	If att == None
		return false
	EndIf
	AddAttacker(att)
	If IsSpawned(att)
		int t = CreatureTypeOf(att)
		If t >= 0
			AddExtras(vic, false, true, CrPool(t), None, ep)
		EndIf
	EndIf
	AddSecondVictim(bCrPlayer, bCrFollowers)
	return StartEncounter(true, "odangerous,aggressive,creature", ep)
EndFunction

; a follower takes advantage of the player (asleep, drunk or downed)
bool Function StageBetrayal(int ep)
	If !IsValidVictim(PlayerRef, true, false, true)
		return false
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, true)
	Actor lead = None
	int i = 0
	While i < near.Length && lead == None && Alive(ep)
		Actor a = near[i]
		If a && IsFollowerActor(a) && !IsProtected(a) && BaseEligible(a, true) && (bGuardAttackers || !IsGuardActor(a))
			If PairScene(a, PlayerRef, true) != "" && WouldAct(a, PlayerRef, K_BETRAYAL, "travelling with " + PlayerRef.GetDisplayName() + ", who is helpless at " + WhereName(), ep)
				lead = a
			EndIf
		EndIf
		i += 1
	EndWhile
	If lead == None
		return false
	EndIf
	AddAttacker(lead)
	AddVictim(PlayerRef)
	return StartEncounter(true, "odangerous,aggressive,betrayal", ep)
EndFunction

bool Function IsVampire(Actor a)
	Keyword vk = Keyword.GetKeyword("Vampire")
	If vk && a.HasKeyword(vk)
		return true
	EndIf
	Race r = a.GetRace()
	return r && (StringUtil.Find(r.GetName(), "Vampire") >= 0 || StringUtil.Find(PO3_SKSEFunctions.GetFormEditorID(r), "Vampire") >= 0)
EndFunction

; vampire seduction in a lair / dungeon: uses a real vampire already there (no spawns, no assets)
bool Function StageVampire(int ep)
	Actor vic = PickVictim(bPlayerVictim, true)
	If vic == None
		return false
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3500.0, false, false, true)
	Actor lead = None
	int i = 0
	While i < near.Length && lead == None
		Actor a = near[i]
		If a && a != vic && IsHumanoid(a) && IsVampire(a) && BaseEligible(a) && !IsFollowerActor(a)
			If PairScene(a, vic, false) != "" || PairScene(a, vic, true) != ""
				lead = a
			EndIf
		EndIf
		i += 1
	EndWhile
	If lead == None
		Log("vampire: none nearby")
		return false
	EndIf
	AddAttacker(lead)
	; entranced: prefer a seductive scene, else forced
	If StartEncounter(false, "odangerous,vampire", ep)
		return true
	EndIf
	If nAtt == 0
		AddAttacker(lead)
		AddVictim(vic)
	EndIf
	return StartEncounter(true, "odangerous,aggressive,vampire", ep)
EndFunction

; ======================= defeat / bleedout (event-based only) =======================
; called by ODS_PlayerAlias / ODS_FollowerAlias OnEnterBleedout
Function OnActorBleedout(Actor a)
	If a == None
		return
	EndIf
	If !Ready() || !bDefeatEnabled
		DefeatFailed(a)
		return
	EndIf
	bool forced = iForceMode == K_DEFEAT
	If a == PlayerRef && !bDefeatPlayer
		DefeatFailed(a)
		return
	EndIf
	If a != PlayerRef && (!bDefeatFollowers || !IsFollowerActor(a))
		return
	EndIf
	If bBusy || OActor.IsInOStim(a) || (!forced && CooldownActive())
		DefeatFailed(a)
		return
	EndIf
	If !forced && Utility.RandomFloat(0.0, 100.0) >= fDefeatChance
		DefeatFailed(a)
		return
	EndIf
	If forced
		iForceMode = 0
	EndIf
	bBusy = true
	kDefeatVictim = a
	StageWithFade(K_DEFEAT, iEpoch, false)
EndFunction

; no defeat scene: if this mod made the player essential, the fight ends the normal way
Function DefeatFailed(Actor a)
	If a == PlayerRef && EssentialAlias.GetReference() == PlayerRef && !PlayerRef.GetActorBase().IsEssential()
		Log("defeat: no scene - normal death")
		EssentialAlias.Clear()
		PlayerRef.Kill()
	EndIf
EndFunction

Function Pacify(Actor a)
	If a == None || kPacified.Find(a) >= 0
		return
	EndIf
	int i = kPacified.Find(None)
	If i < 0
		return
	EndIf
	kPacified[i] = a
	fPacAgg[i] = a.GetActorValue("Aggression")
	a.SetActorValue("Aggression", 0.0)
	a.StopCombat()
	a.StopCombatAlarm()
EndFunction

Function RestorePacified()
	int i = 0
	While i < 8
		Actor a = kPacified[i]
		If a
			If !a.IsDead()
				a.SetActorValue("Aggression", fPacAgg[i])
			EndIf
			kPacified[i] = None
		EndIf
		i += 1
	EndWhile
EndFunction

bool Function StageDefeat(Actor vic, int ep)
	If vic == None || IsMinor(vic)
		return false
	EndIf
	; end the fight: calm every hostile nearby (restored on the next location change)
	Actor[] near = OActorUtil.GetActorsInRangeV2(vic, 3500.0, false, false, false)
	Actor lead = None
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && !a.IsDead() && (a.IsHostileToActor(PlayerRef) || a.IsHostileToActor(vic)) && !IsFollowerActor(a)
			Pacify(a)
			If lead == None && BaseEligible(a, true) && CreatureAllowed(a) && (bGuardAttackers || !IsGuardActor(a))
				If PairScene(a, vic, true) != ""
					lead = a
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	PlayerRef.StopCombatAlarm()
	vic.RestoreActorValue("Health", vic.GetBaseActorValue("Health") * 0.3)
	vic.StopCombat()
	If lead == None
		If vic == PlayerRef && bBetrayal
			return StageBetrayal(ep)
		EndIf
		Log("defeat: no winner with a scene")
		return false
	EndIf
	AddAttacker(lead)
	AddVictim(vic)
	; extras from the pacified winners
	If bGroupScenes
		int want = iGroupMax
		If want > 3
			want = 3
		EndIf
		int j = 0
		While j < 8 && nAtt < want + 1
			Actor p = kPacified[j]
			If p && p != lead && BaseEligible(p, true) && CreatureAllowed(p)
				AddAttacker(p)
			EndIf
			j += 1
		EndWhile
	EndIf
	If vic != PlayerRef
		AddSecondVictim(bDefeatPlayer, bDefeatFollowers)
	EndIf
	return StartEncounter(true, "odangerous,aggressive,defeat", ep)
EndFunction

Function UpdateEssential()
	If bMaster && bDefeatEnabled && bDefeatPlayer && bDefeatEssential
		EssentialAlias.ForceRefTo(PlayerRef)
	ElseIf EssentialAlias.GetReference()
		EssentialAlias.Clear()
	EndIf
EndFunction

; ======================= encounter start =======================
Function Calm(int idx)
	Actor att = kAtt[idx]
	If att == None
		return
	EndIf
	fOldAgg[idx] = att.GetActorValue("Aggression")
	fOldConf[idx] = att.GetActorValue("Confidence")
	att.StopCombat()
	att.StopCombatAlarm()
	If !att.IsInFaction(PlayerFaction)
		att.AddToFaction(PlayerFaction)
		bAddedFac[idx] = true
	Else
		bAddedFac[idx] = false
	EndIf
	att.SetActorValue("Aggression", 0.0)
EndFunction

Function CalmFollowers()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 4000.0, false, false, false)
	int i = 0
	While i < near.Length
		If IsFollowerActor(near[i])
			near[i].StopCombat()
		EndIf
		i += 1
	EndWhile
	PlayerRef.StopCombatAlarm()
EndFunction

int Function StartThread(Actor[] acts, Actor[] dom, string scene, string meta, int ep)
	If !Alive(ep)
		return -1
	EndIf
	int b = OThreadBuilder.Create(acts)
	If b < 0
		Log("OThreadBuilder.Create failed")
		return -1
	EndIf
	If dom
		OThreadBuilder.SetDominantActors(b, dom)
	EndIf
	OThreadBuilder.SetStartingAnimation(b, scene)
	float mn = fMinDuration
	float mx = fMaxDuration
	If mx < mn
		mx = mn
	EndIf
	OThreadBuilder.SetDuration(b, Utility.RandomFloat(mn, mx))
	OThreadBuilder.UndressActors(b)
	OThreadBuilder.NoPostDialogue(b)
	OThreadBuilder.NoFurniture(b)
	If acts.Find(PlayerRef) < 0
		OThreadBuilder.NoPlayerControl(b)
	EndIf
	OThreadBuilder.SetMetadataCSV(b, meta)
	If !Alive(ep)
		OThreadBuilder.Cancel(b)
		return -1
	EndIf
	int t = OThreadBuilder.Start(b)
	If t >= 0 && !Alive(ep)
		OThread.Stop(t)
		return -1
	EndIf
	Log("scene " + scene + " thread " + t + " (" + acts.Length + " actors)")
	return t
EndFunction

Actor[] Function DomFor(Actor[] acts)
	Actor[] dom = OActorUtil.CreateArray(nAtt)
	int i = 0
	While i < nAtt
		dom[i] = kAtt[i]
		i += 1
	EndWhile
	return dom
EndFunction

bool Function StartEncounter(bool forced, string meta, int ep)
	If !Alive(ep)
		return false
	EndIf
	bForcedScene = forced
	string scene = sScene1
	If !bPaired
		scene = BuildScene(forced)
		If scene == ""
			Log("no suitable scene - aborting cleanly")
			return false
		EndIf
		sScene1 = scene
	EndIf
	If !Alive(ep)
		return false
	EndIf
	kAttacker = kAtt[0]
	kVictim = kVic[0]
	kVictim2 = None
	If nVic > 1
		kVictim2 = kVic[1]
	EndIf
	bIntervened = false
	bAftermathDone = false
	int i = 0
	While i < nAtt
		If IsSpawned(kAtt[i])
			kAtt[i].Enable()
		EndIf
		If forced
			Calm(i)
		Else
			kAtt[i].StopCombat()
		EndIf
		i += 1
	EndWhile
	CalmFollowers()
	AttackerAlias.ForceRefTo(kAttacker)
	VictimAlias.ForceRefTo(kVictim)
	If kVictim2
		Victim2Alias.ForceRefTo(kVictim2)
	EndIf
	If nAtt > 1
		Extra1Alias.ForceRefTo(kAtt[1])
	EndIf
	If nAtt > 2
		Extra2Alias.ForceRefTo(kAtt[2])
	EndIf
	If nAtt > 3
		Extra3Alias.ForceRefTo(kAtt[3])
	EndIf
	If bPaired
		Actor[] d1 = new Actor[1]
		d1[0] = kAtt[0]
		iThread = StartThread(kSceneActs, d1, sScene1, meta, ep)
		If iThread >= 0
			Actor[] d2 = new Actor[1]
			d2[0] = kAtt[1]
			iThread2 = StartThread(kSceneActs2, d2, sScene2, meta, ep)
		EndIf
	Else
		Actor[] dom = None
		If forced
			dom = DomFor(kSceneActs)
		EndIf
		iThread = StartThread(kSceneActs, dom, scene, meta, ep)
	EndIf
	If iThread < 0
		RestoreAttackers(false)
		AttackerAlias.Clear()
		VictimAlias.Clear()
		Victim2Alias.Clear()
		Extra1Alias.Clear()
		Extra2Alias.Clear()
		Extra3Alias.Clear()
		bAftermathDone = true
		return false
	EndIf
	fLastEvent = Utility.GetCurrentGameTime()
	SendStartEvent()
	Wake()
	iCleanupTicks = 0
	RegisterForSingleUpdate(10.0)
	return true
EndFunction

; ======================= text =======================
string Function Names2(Actor a, Actor b)
	If b
		return a.GetDisplayName() + " and " + b.GetDisplayName()
	EndIf
	return a.GetDisplayName()
EndFunction

string Function AttackerNames()
	string s = kAttacker.GetDisplayName()
	If nAtt == 2
		s += " and " + kAtt[1].GetDisplayName()
	ElseIf nAtt > 2
		s += " and " + (nAtt - 1) + " others"
	EndIf
	return s
EndFunction

string Function StartText()
	string pn = PlayerRef.GetDisplayName()
	string an = AttackerNames()
	string vn = Names2(kVictim, kVictim2)
	string where = WhereName()
	If iKind == K_CHEAT
		return pn + " wakes in the night to find their spouse " + kVictim.GetDisplayName() + " having sex with " + kAttacker.GetDisplayName() + " nearby, thinking " + pn + " was asleep."
	ElseIf iKind == K_JAIL
		return "In the cells at " + where + ", " + an + " decide the prisoners are theirs to use and force themselves on " + vn + "."
	ElseIf iKind == K_INN
		return "Late in the night at " + where + ", " + an + ", deep in their cups, corner " + vn + " and force themselves on them."
	ElseIf iKind == K_SPIKED
		return "At " + where + ", " + vn + " drank something that was spiked. Dazed and barely able to stand, they are taken by " + an + "."
	ElseIf iKind == K_DEFEAT
		return "Beaten and bleeding at " + where + ", " + vn + " can no longer fight back, and the victorious " + an + " claim their prize."
	ElseIf iKind == K_TRESPASS
		return an + " finds " + vn + " sleeping uninvited in their home at " + where + " and takes payment in flesh."
	ElseIf iKind == K_ROAD
		return "On the road near " + where + ", " + an + " robbed " + pn + " and now forces themselves on " + vn + "."
	ElseIf iKind == K_CREATURE
		return "Out in the wild near " + where + ", " + an + " falls upon " + vn + "."
	ElseIf iKind == K_BETRAYAL
		return pn + "'s own companion " + kAttacker.GetDisplayName() + " takes advantage of " + pn + " while they are helpless at " + where + "."
	ElseIf iKind == K_VAMPIRE
		return "In the dark of " + where + ", the vampire " + kAttacker.GetDisplayName() + " entrances " + vn + " and draws them into an embrace."
	EndIf
	If kVictim == PlayerRef
		return an + " has fallen upon " + pn + " in their sleep and is forcing themselves on " + pn + "."
	EndIf
	return "While the camp slept, " + an + " crept in and is forcing themselves on " + vn + ". " + vn + " is screaming for help, waking " + pn + "."
EndFunction

Function SendDrunkEvent()
	If !bSkyrimNetStart || !SNetOK()
		return
	EndIf
	string d = "The patrons of " + WhereName() + " have been drinking heavily all night; inhibitions are low and the common room is rowdy."
	SkyrimNetApi.RegisterShortLivedEvent("odangerous_drunk_patrons", "odangerous_drunk", d, "", 600000, None, None)
EndFunction

Function SendStartEvent()
	If !bSkyrimNetStart || !SNetOK() || !bMaster
		return
	EndIf
	string t = StartText()
	If iKind == K_JAIL && bZaZ && ZaZOK() && kVictim != PlayerRef && kVictim2 != PlayerRef
		t += " " + PlayerRef.GetDisplayName() + " is held back and made to watch."
	EndIf
	int rc = SkyrimNetApi.DirectNarration(t, None, None)
	Log("SkyrimNet start event (rc " + rc + ")")
EndFunction

Function Wake()
	Utility.Wait(1.5)
	ClearFade()
	If !bMaster
		return
	EndIf
	string an = AttackerNames()
	string vn = Names2(kVictim, kVictim2)
	bool shake = bForcedScene
	If iKind == K_CHEAT
		ShowMsg("You wake to find your spouse " + kVictim.GetDisplayName() + " in bed with " + kAttacker.GetDisplayName() + "...")
	ElseIf iKind == K_JAIL
		ShowMsg("The guards have come for " + vn + "...")
	ElseIf iKind == K_INN
		ShowMsg("Rough hands drag you from your rest... " + an + "!")
	ElseIf iKind == K_SPIKED
		ShowMsg("The drink was spiked... " + vn + " can barely stand.")
	ElseIf iKind == K_DEFEAT
		ShowMsg("Defeated... " + an + " claim " + vn + ".")
	ElseIf iKind == K_TRESPASS
		ShowMsg(kAttacker.GetDisplayName() + " found you in their home...")
	ElseIf iKind == K_ROAD
		ShowMsg("Robbed on the road... and " + an + " isn't finished.")
	ElseIf iKind == K_CREATURE
		ShowMsg(an + " falls upon " + vn + "!")
	ElseIf iKind == K_BETRAYAL
		ShowMsg(kAttacker.GetDisplayName() + " takes advantage of you...")
	ElseIf iKind == K_VAMPIRE
		ShowMsg(kAttacker.GetDisplayName() + " entrances " + vn + "...")
		shake = false
	ElseIf kVictim == PlayerRef
		ShowMsg("You wake to rough hands on you... " + an + "!")
	Else
		ShowMsg("You wake to screams... " + vn + " is being taken by " + an + "!")
	EndIf
	If shake
		Game.ShakeCamera(None, 0.35, 1.2)
	EndIf
EndFunction

; ======================= intervention (hit / activate to stop) =======================
Function Intervene()
	If bIntervened || iThread < 0 || !bMaster
		return
	EndIf
	If kVictim == PlayerRef && kVictim2 == None
		return
	EndIf
	bIntervened = true
	Log("player intervened")
	int t = iThread
	int t2 = iThread2
	If t2 >= 0 && OThread.IsRunning(t2)
		OThread.Stop(t2)
	EndIf
	If OThread.IsRunning(t)
		OThread.Stop(t)
	Else
		Aftermath()
	EndIf
EndFunction

; ======================= OStim events =======================
Event OnOStimThreadEnd(string eventName, string strArgs, float numArg, Form sender)
	int id = numArg as int
	If id < 0 || (id != iThread && id != iThread2)
		return
	EndIf
	If id == iThread2
		iThread2 = -1
		If iThread < 0 || !OThread.IsRunning(iThread)
			Aftermath()
		EndIf
		return
	EndIf
	If iThread2 >= 0 && OThread.IsRunning(iThread2)
		iThread = -2   ; first thread done, wait for the second
		return
	EndIf
	Aftermath()
EndEvent

; kiss filter also covers OStim's own auto navigation: warp back to the starting scene
Event OnOStimSceneChanged(string eventName, string strArgs, float numArg, Form sender)
	int id = numArg as int
	If id < 0 || (id != iThread && id != iThread2)
		return
	EndIf
	string sc = OThread.GetScene(id)
	If IsKissScene(sc) || IsKissScene(strArgs)
		string back = sScene1
		If id == iThread2
			back = sScene2
		EndIf
		If back != "" && !IsKissScene(back)
			OThread.WarpTo(id, back, false)
		EndIf
	EndIf
EndEvent

; another mod's OStim scene with the player: the spouse or a follower may walk in on it
Event OnOStimThreadStart(string eventName, string strArgs, float numArg, Form sender)
	int id = numArg as int
	If !Ready() || !bCaught || id < 0 || id == iThread || id == iThread2
		return
	EndIf
	If (Utility.GetCurrentGameTime() - fLastCaught) < 1.0
		return
	EndIf
	Actor[] acts = OThread.GetActors(id)
	If acts.Find(PlayerRef) < 0 || acts.Length < 2
		return
	EndIf
	int q = 0
	While q < acts.Length
		If IsMinor(acts[q])
			return
		EndIf
		q += 1
	EndWhile
	Actor partner = acts[0]
	If partner == PlayerRef
		partner = acts[1]
	EndIf
	Actor catcher = None
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 2000.0, false, false, false)
	int i = 0
	While i < near.Length && catcher == None
		Actor a = near[i]
		If a && acts.Find(a) < 0 && !a.IsDead() && !IsMinor(a) && !OActor.IsInOStim(a) && IsSpouse(a)
			catcher = a
		EndIf
		i += 1
	EndWhile
	If catcher == None
		i = 0
		While i < near.Length && catcher == None
			Actor b = near[i]
			If b && acts.Find(b) < 0 && !b.IsDead() && !IsMinor(b) && !OActor.IsInOStim(b) && IsFollowerActor(b)
				catcher = b
			EndIf
			i += 1
		EndWhile
	EndIf
	If catcher == None || Utility.RandomFloat(0.0, 100.0) >= fCaughtChance
		return
	EndIf
	fLastCaught = Utility.GetCurrentGameTime()
	string pn = PlayerRef.GetDisplayName()
	string rel = "companion "
	If IsSpouse(catcher)
		rel = "spouse "
	EndIf
	If SNetOK() && bSkyrimNetStart
		SkyrimNetApi.DirectNarration(pn + "'s " + rel + catcher.GetDisplayName() + " walks in and catches " + pn + " having sex with " + partner.GetDisplayName() + ".", catcher, PlayerRef)
	EndIf
	If SNetOK() && bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(catcher.GetDisplayName() + " caught " + pn + " having sex with " + partner.GetDisplayName() + " at " + WhereName() + ".", catcher, PlayerRef)
	EndIf
	ShowMsg(catcher.GetDisplayName() + " has seen you...")
EndEvent

; ======================= aftermath =======================
Function RestoreAttackers(bool afterScene)
	int i = 0
	While i < 4
		Actor a = kAtt[i]
		If a && !a.IsDead()
			If bAddedFac[i]
				a.RemoveFromFaction(PlayerFaction)
				bAddedFac[i] = false
			EndIf
			If bForcedScene
				If !afterScene
					a.SetActorValue("Aggression", fOldAgg[i])
				ElseIf IsSpawned(a)
					If bIntervened
						a.SetActorValue("Aggression", 2.0)
						a.SetActorValue("Confidence", fOldConf[i])
					ElseIf a == kThief
						a.SetActorValue("Aggression", 1.0)
						a.SetActorValue("Confidence", 0.0)
					Else
						a.SetActorValue("Aggression", 0.0)
						a.SetActorValue("Confidence", 0.0)
					EndIf
					a.StartCombat(PlayerRef)
				ElseIf iKind == K_DEFEAT
					Pacify(a)   ; winners stay calm until the next location change
				ElseIf bIntervened && !IsGuardActor(a) && !IsFollowerActor(a)
					a.SetActorValue("Aggression", 2.0)
					a.StartCombat(PlayerRef)
				Else
					a.SetActorValue("Aggression", fOldAgg[i])
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Function Aftermath()
	If bAftermathDone
		return
	EndIf
	bAftermathDone = true
	iThread = -1
	iThread2 = -1
	If !bMaster
		return
	EndIf
	RestoreAttackers(true)
	SendDoneEvent()
	LogSkyrimNet()
	ArrestAlternative()
	Leftover()
	RememberBlackmail()
	iCleanupTicks = 0
	RegisterForSingleUpdate(5.0)
EndFunction

Function SendDoneEvent()
	int h = ModEvent.Create("ODeadlySkyrim_Done")
	If h
		ModEvent.PushInt(h, iKind)
		ModEvent.PushForm(h, kVictim)
		ModEvent.PushForm(h, kAttacker)
		ModEvent.PushBool(h, IsSpawned(kAttacker))
		ModEvent.PushBool(h, bIntervened)
		ModEvent.PushBool(h, !bForcedScene)
		ModEvent.Send(h)
	EndIf
EndFunction

string Function MessyText()
	If bOCumMemory && OCumOK() && bForcedScene
		return " They were left used and dripping, the mess plain for anyone to see."
	EndIf
	return ""
EndFunction

Function LogSkyrimNet()
	If !bSkyrimNetLog || !SNetOK() || kVictim == None || kAttacker == None
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	string an = AttackerNames()
	string vn = Names2(kVictim, kVictim2)
	string where = WhereName()
	string txt
	If iKind == K_CHEAT
		txt = "While " + pn + " slept, " + pn + "'s spouse " + kVictim.GetDisplayName() + " had sex with " + kAttacker.GetDisplayName() + ". " + pn + " woke and saw it"
		If bIntervened
			txt += " and interrupted them."
		Else
			txt += "."
		EndIf
	ElseIf iKind == K_VAMPIRE
		txt = "At " + where + ", the vampire " + kAttacker.GetDisplayName() + " entranced " + vn + " and had their way with them."
	ElseIf iKind == K_ATTACK && kVictim != PlayerRef
		txt = "While " + pn + " slept, " + an + " crept into camp and forced themselves on " + vn + "."
		If bIntervened
			txt += " " + pn + " woke to the screams and fought them off."
		Else
			txt += " " + pn + " woke to the screams but did not intervene."
		EndIf
	ElseIf iKind == K_ATTACK
		txt = an + " fell upon " + pn + " in the night while the camp slept and forced themselves on " + pn + "."
	Else
		txt = StartText()
		If bIntervened
			txt += " " + pn + " stepped in and stopped it."
		EndIf
	EndIf
	txt += MessyText()
	SkyrimNetApi.RegisterPersistentEvent(txt, kAttacker, kVictim)
EndFunction

; jail fallback for "pay the fine with your body": the player's bounty in this hold is cleared after a jail scene
Function ArrestAlternative()
	If !bArrestAlt || iKind != K_JAIL || (kVictim != PlayerRef && kVictim2 != PlayerRef) || kAttacker == None
		return
	EndIf
	Faction cf = kAttacker.GetCrimeFaction()
	If cf && cf.GetCrimeGold() > 0
		cf.SetCrimeGold(0)
		cf.SetCrimeGoldViolent(0)
		ShowMsg("\"Consider your debt to the hold paid.\"")
		If SNetOK() && bSkyrimNetLog
			SkyrimNetApi.RegisterPersistentEvent(kAttacker.GetDisplayName() + " let " + PlayerRef.GetDisplayName() + " pay off their bounty with their body in the cells at " + WhereName() + ".", kAttacker, PlayerRef)
		EndIf
	EndIf
EndFunction

; public leftover after jail / defeat: rumours and a spectator remark, then done
Function Leftover()
	If !bLeftover || !SNetOK() || (iKind != K_JAIL && iKind != K_DEFEAT)
		return
	EndIf
	string vn = Names2(kVictim, kVictim2)
	string where = WhereName()
	If bRumors
		SkyrimNetApi.RegisterShortLivedEvent("odangerous_rumor", "odangerous_rumor", "Word is spreading around " + where + " about what was done to " + vn + ".", "", 3600000, None, None)
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 2500.0, false, false, false)
	int i = 0
	Actor spec = None
	While i < near.Length && spec == None
		Actor a = near[i]
		If a && !a.IsDead() && IsHumanoid(a) && !IsMinor(a) && !IsStaged(a) && !IsFollowerActor(a) && !OActor.IsInOStim(a)
			spec = a
		EndIf
		i += 1
	EndWhile
	If spec
		SkyrimNetApi.DirectNarration(spec.GetDisplayName() + " saw what was done to " + vn + " at " + where + " and does not keep quiet about it.", spec, kVictim)
	EndIf
EndFunction

; ======================= blackmail (light, one cooldown, no questline) =======================
Function RememberBlackmail()
	If !bBlackmail || iKind == K_CREATURE || kAttacker == None || IsSpawned(kAttacker) || !IsHumanoid(kAttacker)
		return
	EndIf
	If kVictim != PlayerRef && kVictim2 != PlayerRef && iKind != K_CHEAT
		return
	EndIf
	kBlackmailer = kAttacker
	fBlackmailTime = Utility.GetCurrentGameTime()
	sBlackmailWhere = WhereName()
EndFunction

Function CheckBlackmail()
	If !Ready() || !bBlackmail || kBlackmailer == None || bBusy
		return
	EndIf
	If kBlackmailer.IsDead()
		kBlackmailer = None
		return
	EndIf
	If (Utility.GetCurrentGameTime() - fBlackmailTime) < 1.0 || kBlackmailer.GetDistance(PlayerRef) > 2000.0 || IsMinor(kBlackmailer)
		return
	EndIf
	If Utility.RandomFloat(0.0, 100.0) >= fBlackmailChance
		fBlackmailTime = Utility.GetCurrentGameTime()   ; try again another day
		return
	EndIf
	If SNetOK()
		string pn = PlayerRef.GetDisplayName()
		SkyrimNetApi.DirectNarration(kBlackmailer.GetDisplayName() + " remembers what happened with " + pn + " at " + sBlackmailWhere + ", and quietly lets " + pn + " know that everyone could hear about it - unless " + pn + " makes it worth their while.", kBlackmailer, PlayerRef)
	EndIf
	kBlackmailer = None
EndFunction

; ======================= watchdog / cleanup =======================
Event OnUpdate()
	If !bMaster
		return
	EndIf
	If !bAftermathDone
		bool run1 = iThread >= 0 && OThread.IsRunning(iThread)
		bool run2 = iThread2 >= 0 && OThread.IsRunning(iThread2)
		If run1 || run2
			RegisterForSingleUpdate(10.0)
			return
		EndIf
		Aftermath()
		return
	EndIf
	iCleanupTicks += 1
	bool pending = false
	int i = 0
	While i < 8
		Actor s = kSpawned[i]
		If s
			bool holdsGold = s == kThief && iRobbedGold > 0
			bool gone = s.IsDead() || s.GetDistance(PlayerRef) > 4000.0 || (!bIntervened && !holdsGold && iCleanupTicks >= 4) || iCleanupTicks >= 36
			If gone
				kSpawned[i] = None
				If holdsGold && !s.IsDead()
					; never delete the player's gold: the thief stays in the world
				ElseIf holdsGold
					s.Delete()   ; dead thief: lootable until the cell unloads
				Else
					s.Disable(true)
					s.Delete()
				EndIf
			Else
				pending = true
			EndIf
		EndIf
		i += 1
	EndWhile
	If pending
		RegisterForSingleUpdate(5.0)
		return
	EndIf
	Cleanup()
EndEvent

Function Cleanup()
	ClearStage()
	kThief = None
	iRobbedGold = 0
	iThread = -1
	iThread2 = -1
	bAftermathDone = true
	bBusy = false
	kDefeatVictim = None
EndFunction

; ======================= location change: linger + road timers =======================
; called by ODS_PlayerAlias.OnLocationChange
Function OnLocChange(Location akOld, Location akNew)
	RestorePacified()
	If !Ready()
		return
	EndIf
	FillFollowerAliases()
	RefreshTimers(akNew)
	CheckBlackmail()
EndFunction

bool Function TravelWanted()
	return (bTravelEnabled || (AnyCreatureOK() && fCrRoamChance > 0.0)) && IsOutdoors() && GetLocCategory() == 5
EndFunction

Function RefreshTimers(Location akNew)
	float now = Utility.GetCurrentGameTime()
	If bJailEnabled && InJailOrBarracks()
		If fLingerDue < 0.0
			fLingerDue = now + fLingerHours / 24.0
		EndIf
	Else
		fLingerDue = -1.0
	EndIf
	If TravelWanted()
		If fTravelDue < 0.0
			fTravelDue = now + 1.0 / 24.0
		EndIf
	Else
		fTravelDue = -1.0
	EndIf
	ScheduleGameTime()
EndFunction

Function ScheduleGameTime()
	UnregisterForUpdateGameTime()
	float now = Utility.GetCurrentGameTime()
	float due = -1.0
	If fLingerDue > 0.0
		due = fLingerDue
	EndIf
	If fTravelDue > 0.0 && (due < 0.0 || fTravelDue < due)
		due = fTravelDue
	EndIf
	If due > 0.0
		float hrs = (due - now) * 24.0
		If hrs < 0.05
			hrs = 0.05
		EndIf
		RegisterForSingleUpdateGameTime(hrs)
	EndIf
EndFunction

; one-shot game-time timer: at most one roll per linger / per game hour outdoors
Event OnUpdateGameTime()
	If !Ready()
		return
	EndIf
	float now = Utility.GetCurrentGameTime()
	int kind = 0
	If fLingerDue > 0.0 && now >= fLingerDue
		fLingerDue = -1.0
		If bJailEnabled && InJailOrBarracks()
			fLingerDue = now + fLingerHours / 24.0
			If !bBusy && !OtherBusy(false) && !CooldownActive() && Utility.RandomFloat(0.0, 100.0) < fJailLingerChance
				kind = K_JAIL
			EndIf
		EndIf
	EndIf
	If fTravelDue > 0.0 && now >= fTravelDue
		fTravelDue = -1.0
		If TravelWanted()
			fTravelDue = now + 1.0 / 24.0
			If kind == 0 && !bBusy && !OtherBusy(false) && !CooldownActive()
				If bTravelEnabled && Utility.RandomFloat(0.0, 100.0) < fRoadChance
					kind = K_ROAD
				ElseIf AnyCreatureOK() && Utility.RandomFloat(0.0, 100.0) < fCrRoamChance
					kind = K_CREATURE
				EndIf
			EndIf
		EndIf
	EndIf
	ScheduleGameTime()
	If kind != 0
		bBusy = true
		StageWithFade(kind, iEpoch, false)
	EndIf
EndEvent

; ======================= follower aliases (bleedout events for defeat) =======================
Function FillFollowerAliases()
	ReferenceAlias[] al = new ReferenceAlias[4]
	al[0] = Follower1Alias
	al[1] = Follower2Alias
	al[2] = Follower3Alias
	al[3] = Follower4Alias
	int c = 0
	If bMaster && bDefeatEnabled && bDefeatFollowers
		Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 4000.0, false, false, false)
		int i = 0
		While i < near.Length && c < 4
			If IsFollowerActor(near[i]) && !IsMinor(near[i])
				al[c].ForceRefTo(near[i])
				c += 1
			EndIf
			i += 1
		EndWhile
	EndIf
	While c < 4
		al[c].Clear()
		c += 1
	EndWhile
EndFunction

; ======================= protect list helper (MCM) =======================
bool Function ToggleProtected(Actor a)
	If a == None
		return false
	EndIf
	InitArrays()
	Form f = a.GetActorBase()
	int i = Protected.Find(f)
	If i >= 0
		Protected[i] = None
		return false
	EndIf
	i = Protected.Find(None)
	If i >= 0
		Protected[i] = f
		return true
	EndIf
	return false
EndFunction
