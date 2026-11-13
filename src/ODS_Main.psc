Scriptname ODS_Main extends Quest
{O'Deadly Skyrim (A SkyrimNet environmental mod) v0.3 - by That Guy (Coronerra). One dangerous-world engine for OStim + SkyrimNet. Inspired by ODangerousNights (no ODN files used). Adults only: children are refused for every role.}

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
FormList Property ODS_PoolVampire Auto      ; 0.2: Dark Gift spawns (vanilla vampires)
FormList Property ODS_PoolWatcher Auto      ; 0.2: distant watcher spawn (vanilla hunter)
FormList Property ODS_AlcoholVanilla Auto   ; 0.2: vanilla drinks, used when iActions is not installed
FormList Property ODS_PoolFauna Auto        ; 0.2: easter egg rabbits (vanilla hare)
FormList Property ODS_PoolButterfly Auto    ; 0.2: easter egg butterflies / moths (vanilla critters)

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
int Property K_MORNING = 12 AutoReadOnly  ; 0.2 morning after (drinking, then sleep)
int Property K_BATH = 13 AutoReadOnly     ; 0.2 bathing (Dirt and Blood / Bathing in Skyrim)
float Property BATH_WAIT_CAP = 150.0 AutoReadOnly   ; 0.7: longest wait for a bath to end (s)
float Property BATH_SETTLE = 2.5 AutoReadOnly       ; 0.7: pause after the bath ends, before the scene (s)
float Property REST_MENU_CAP = 10.0 AutoReadOnly    ; 0.7: longest wait for the Sleep/Wait Menu to close after a rest (s)
float Property REST_SETTLE = 1.0 AutoReadOnly       ; 0.7: pause after the rest ends, before staging (s)
int Property K_INNSHARE = 14 AutoReadOnly ; 0.2 inns full: one rented room for the whole party
int Property K_DARKGIFT = 15 AutoReadOnly ; 0.2 Dark Gift: a vampire wakes the player
int Property K_COUNT = 16 AutoReadOnly
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

Form[] Property ProtectedForms Auto Hidden          ; 0.6: renamed property; the protected-NPC list resets once on update
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

; ======================= settings: 0.2 modules (all OFF by default) =======================
bool Property bMorningAfter = false Auto Hidden
float Property fMorningChance = 50.0 Auto Hidden    ; % when you sleep after a binge
int Property iMorningDrinks = 4 Auto Hidden         ; drinks within the window ("more than 3")
float Property fMorningWindow = 2.0 Auto Hidden     ; game hours
bool Property bMorningSpawn = true Auto Hidden      ; nobody suitable nearby: a stranger is found

bool Property bBath = false Auto Hidden
float Property fBathChance = 15.0 Auto Hidden       ; % per wash
bool Property bBathPlayer = true Auto Hidden
bool Property bBathFollowers = true Auto Hidden
bool Property bBathSpawn = true Auto Hidden

bool Property bInnShare = false Auto Hidden
float Property fInnShareChance = 4.0 Auto Hidden    ; % per hour slept in an inn with your party
bool Property bInnSharePlayer = true Auto Hidden
bool Property bInnShareFollowers = true Auto Hidden

bool Property bWatched = false Auto Hidden
float Property fWatchChance = 25.0 Auto Hidden      ; % per outdoor scene
bool Property bWatchSpawn = true Auto Hidden

bool Property bDarkGift = false Auto Hidden
float Property fDarkGiftChance = 1.0 Auto Hidden    ; % per hour slept
bool Property bDarkInfect = true Auto Hidden        ; vampirism unless immune to disease

bool Property bFauna = false Auto Hidden            ; easter egg: climax fauna (true when iFaunaMode > 0)
int Property iFaunaMode = 0 Auto Hidden             ; 0 off, 1 vanilla rabbits, 2 Killer Rabbit of Caerbannog if detected
float Property fFaunaChance = 5.0 Auto Hidden       ; % per climax
int Property iFaunaRabbits = 20 Auto Hidden
bool Property bForceFauna = false Auto Hidden       ; debug: next climax
bool Property bForceWatch = false Auto Hidden       ; debug: next outdoor scene

; ======================= settings: 0.3 (SkyrimNet bridges, only active when the other mod is installed) =======================
bool Property bOKRSkyrimNet = true Auto Hidden      ; OStim Kidnapped Redux events -> SkyrimNet
bool Property bODefSkyrimNet = true Auto Hidden     ; ODefeat Reforged events -> SkyrimNet
bool Property bBakaSkyrimNet = true Auto Hidden     ; 0.5: Baka Defeat (OStim Edition) events -> SkyrimNet
bool Property bRescue = false Auto Hidden           ; follower rescue (mid-battle), OFF by default
float Property fRescueChance = 50.0 Auto Hidden     ; % when a matching follower goes down
int Property iRescueGender = 0 Auto Hidden          ; downed follower: 0 both, 1 female, 2 male (this module only)

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
Actor[] kNoActors       ; 0.6: never assigned (stays None); used to clear actor arrays without a None literal
Form[] kNoForms         ; 0.6: same, for Form arrays
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
; 0.2 runtime
ObjectReference kFurn       ; bed for this encounter (None = no furniture)
string sPreScene = ""       ; scene chosen by a module (furniture / feeding), used by StartEncounter
bool[] bCalmed              ; per kAtt slot: calmed for a non-forced scene
float[] fDrinkTimes         ; [8] game time of the player's recent drinks
int iDrinkIdx = 0
bool bMorningArmed = false
float fMorningArmedAt = 0.0
bool bMorningPending = false
; 0.7 (NPC AI Position Fix compat): a sleep event rolled at sleep start waits here until you wake
bool bRestPending = false
int iRestKind = 0
int iRestEpoch = -1
FormList kIActAlc           ; iActions_AlcoholList (soft)
Faction kIActDrunk          ; iActions_DrunkFaction (soft)
Form[] kExtraAlc            ; iActions extra_alcohol.json + DLC drinks
FormList kDnBList           ; Dirty_BathingActors (soft)
MagicEffect[] kBathFx       ; wash-start effects from Dirt and Blood / Bathing in Skyrim
MagicEffect kBisFx1
MagicEffect kBisFx2
bool bBathPending = false
bool bBathDone = false
Actor kBathSubject
Actor kBathCo
float fLastBathRoll = -10.0
float fLastWatched = -10.0
Actor kWatchSpawn
float fLastFauna = -10.0
bool bFaunaRunning = false
ObjectReference[] kFauna    ; [48]
; 0.3 runtime (listeners only)
float fOKRHeldUntil = 0.0   ; game time; O'Deadly holds its own encounters while Kidnapped Redux has the player
string sOKRWhere = ""       ; where the player was taken
float fODefUntil = 0.0      ; game time; an ODefeat Reforged defeat of the player is in progress
bool bODefAwait = false     ; its scene ended without an escape: an outcome event is due
string sODefWhere = ""
string sODefBy = ""         ; display name of the winner, from the OStim scene (may be empty)
bool bRescueOn = false      ; follower rescue side scene running (not an O'Deadly encounter: bBusy stays as it is)
bool bRescueDone = false
int iRescueThread = -1
Actor kRescueVic
Actor kRescueAtt
float fRescueAgg = 0.0
bool bRescueFac = false
bool bRescueProt = false
string sRescueWhere = ""
float fLastRescue = -10.0
; 0.5 runtime (Baka Defeat listener only)
float fBakaUntil = 0.0      ; game time; a Baka Defeat defeat of the player is in progress
string sBakaWhere = ""      ; where the player went down
string sBakaBy = ""         ; display name of the first one who took the player (may be empty)
bool bBakaMemDone = false   ; the "had their way" memory for this defeat is written
int[] iBakaTid              ; [8] Baka scene threads O'Deadly is narrating
int[] iBakaKind             ; [8] 1 player victim, 2 companion, 3 player on top, 4 NPC victim
Actor[] kBakaVic            ; [8]
Actor[] kBakaAgg            ; [8]
bool bBothDefeatsWarned = false   ; the one-time MessageBox for this save

string Property MODNAME = "O'Deadly Skyrim" AutoReadOnly

; ======================= lifecycle =======================
Event OnInit()
	InitArrays()
	Register()
	BothDefeatsWarn()
EndEvent

; 0.6: runtime (scene) arrays first, settings arrays after, so a problem with a settings
; list can never leave scenes without their arrays. Arrays are tested with "If !arr" and built
; through a local, never compared to or assigned from a None literal (see ClearStage).
Function InitArrays()
	; ---- runtime arrays the scene flow needs ----
	If !kAtt
		Actor[] tAtt = new Actor[4]
		kAtt = tAtt
	EndIf
	If !kVic
		Actor[] tVic = new Actor[2]
		kVic = tVic
	EndIf
	If !kSpawned
		Actor[] tSpawned = new Actor[8]
		kSpawned = tSpawned
	EndIf
	If !fOldAgg
		float[] tOldAgg = new float[4]
		fOldAgg = tOldAgg
	EndIf
	If !fOldConf
		float[] tOldConf = new float[4]
		fOldConf = tOldConf
	EndIf
	If !bAddedFac
		bool[] tAddedFac = new bool[4]
		bAddedFac = tAddedFac
	EndIf
	If !kPacified
		Actor[] tPacified = new Actor[8]
		kPacified = tPacified
	EndIf
	If !fPacAgg
		float[] tPacAgg = new float[8]
		fPacAgg = tPacAgg
	EndIf
	If !bCalmed
		bool[] tCalmed = new bool[4]
		bCalmed = tCalmed
	EndIf
	If !bCrType
		bool[] tCrType = new bool[7]
		int i = 0
		While i < 7
			tCrType[i] = true
			i += 1
		EndWhile
		bCrType = tCrType
	EndIf
	If !iCrStatus
		int[] tCrStatus = new int[7]
		int j = 0
		While j < 7
			tCrStatus[j] = 3
			j += 1
		EndWhile
		iCrStatus = tCrStatus
	EndIf
	If !fDrinkTimes
		float[] tDrink = new float[8]
		fDrinkTimes = tDrink
	EndIf
	If !kFauna
		ObjectReference[] tFauna = new ObjectReference[48]
		kFauna = tFauna
	EndIf
	If !kBathFx
		MagicEffect[] tBathFx = new MagicEffect[8]
		kBathFx = tBathFx
	EndIf
	If !iBakaTid
		int[] tBakaTid = new int[8]
		iBakaTid = tBakaTid
	EndIf
	If !iBakaKind
		int[] tBakaKind = new int[8]
		iBakaKind = tBakaKind
	EndIf
	If !kBakaVic
		Actor[] tBakaVic = new Actor[8]
		kBakaVic = tBakaVic
	EndIf
	If !kBakaAgg
		Actor[] tBakaAgg = new Actor[8]
		kBakaAgg = tBakaAgg
	EndIf
	; ---- settings arrays (MCM) ----
	If !ProtectedForms
		Form[] tProt = new Form[64]
		ProtectedForms = tProt
	EndIf
	If !OvrLoc
		Form[] tOvrLoc = new Form[128]
		OvrLoc = tOvrLoc
	EndIf
	If !OvrAtk
		float[] tOvrAtk = new float[128]
		OvrAtk = tOvrAtk
	EndIf
	If !OvrCheat
		float[] tOvrCheat = new float[128]
		OvrCheat = tOvrCheat
	EndIf
	If !OvrJail
		int[] tOvrJail = new int[128]
		OvrJail = tOvrJail
	EndIf
	If !PlaceNames
		string[] tPlaceNames = new string[64]
		PlaceNames = tPlaceNames
	EndIf
	If !PlaceCats
		int[] tPlaceCats = new int[64]
		PlaceCats = tPlaceCats
	EndIf
	MigrateFaunaMode()
EndFunction

; registrations are cheap and event-only: no polling anywhere
Function Register()
	RegisterForSleep()
	RegisterForMenu("Sleep/Wait Menu")
	RegisterForModEvent("ostim_thread_end", "OnOStimThreadEnd")
	RegisterForModEvent("ostim_thread_start", "OnOStimThreadStart")
	RegisterForModEvent("ostim_thread_scenechanged", "OnOStimSceneChanged")
	RegisterForModEvent("ODN_NightAttack", "OnODNNightAttack")
	RegisterForModEvent("ostim_actor_orgasm", "OnOStimOrgasm")
	RegisterForModEvent("BiS_WashActorFinish", "OnBiSWashFinish")
	RegisterForModEvent("BiS_BatheEvent_" + PlayerRef.GetFormID(), "OnBiSBathePlayer")
	If OKROK()
		RegisterForModEvent("OKidnapped_Taken", "OnOKRTaken")
		RegisterForModEvent("OKidnapped_Dodged", "OnOKRDodged")
		RegisterForModEvent("OKidnapped_End", "OnOKREnd")
	EndIf
	If ODefeatOK()
		RegisterForModEvent("ODefeatAnimStart_odefeat", "OnODefStart")
		RegisterForModEvent("oDefeat_robberyEvent", "OnODefRobbery")
		RegisterForModEvent("oDefeat_safeWakeupEvent", "OnODefSafeWakeup")
		RegisterForModEvent("oDefeat_killEvent", "OnODefKill")
		RegisterForModEvent("oDefeat_arrestEvent", "OnODefArrest")
		RegisterForModEvent("SSLV Entry", "OnODefSlavery")
	EndIf
	If BakaDefeatOK()
		RegisterForModEvent("DefeatOStimStart", "OnBakaSceneStart")
		RegisterForModEvent("DefeatOStimEnd", "OnBakaSceneEnd")
		RegisterForModEvent("DefeatPostAssault", "OnBakaPostAssault")
	EndIf
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
	If bRescueOn
		RescueRelease(false)
	EndIf
	; 0.7: a sleep event that never got to stage does not survive a load
	bRestPending = false
	iRestKind = 0
	bMorningPending = false
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
	ResolveSoft()
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
	If Game.GetModByName(n) != 255
		return true
	EndIf
	return Game.GetLightModByName(n) != 65535     ; ESL-flagged plugins (e.g. Bathing in Skyrim)
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

; ---- 0.2 soft detection (never masters) ----
bool Function IActionsOK()
	return ModLoaded("iActions.esp")
EndFunction

bool Function DnBOK()
	return ModLoaded("Dirt and Blood - Dynamic Visuals.esp")
EndFunction

bool Function BiSOK()
	return ModLoaded("Bathing in Skyrim.esp")
EndFunction

bool Function BathModOK()
	return DnBOK() || BiSOK()
EndFunction

bool Function BaOOK()
	return ModLoaded("Blood and OStim.esp")
EndFunction

bool Function SacrosanctOK()
	return ModLoaded("Sacrosanct - Vampires of Skyrim.esp")
EndFunction

bool Function JCOK()
	return SKSE.GetPluginVersion("JContainers64") > 0
EndFunction

; ---- 0.3 soft detection (never masters) ----
bool Function OKROK()
	return ModLoaded("OStim Kidnapped Redux.esp")
EndFunction

bool Function ODefeatOK()
	return ModLoaded("ODefeat.esp")
EndFunction

; ---- 0.5 soft detection (never masters) ----
; Baka Defeat - OStim Edition keeps the old plugin name so mods that hook Defeat still find it
bool Function BakaDefeatOK()
	return ModLoaded("SexLabDefeat.esp")
EndFunction

; any defeat mod that takes over a downed player: O'Deadly's own player defeat stands down
bool Function DefeatModOK()
	return ODefeatOK() || BakaDefeatOK()
EndFunction

bool Function BothDefeatsOK()
	return ODefeatOK() && BakaDefeatOK()
EndFunction

string Function DefeatModName()
	If BakaDefeatOK()
		return "Baka Defeat"
	ElseIf ODefeatOK()
		return "ODefeat Reforged"
	EndIf
	return ""
EndFunction

string Property BOTH_DEFEATS_MSG = "O'Deadly Skyrim: Both ODefeat Reforged and Baka Defeat (OStim Edition) were detected. For stability use only one, preferably Baka Defeat since it does more." AutoReadOnly
string Property BOTH_DEFEATS_NOTE = "O'Deadly Skyrim: ODefeat Reforged and Baka Defeat both detected. Use only one (Baka Defeat preferred)." AutoReadOnly

; once per game load (from ODS_PlayerAlias a few seconds after loading) and on first install;
; the MessageBox only the first time on a save. Plain text, shown even with the master switch off.
Function BothDefeatsWarn()
	If !BothDefeatsOK()
		return
	EndIf
	Debug.Trace("[ODeadlySkyrim] both ODefeat Reforged and Baka Defeat detected")
	Debug.Notification(BOTH_DEFEATS_NOTE)
	If !bBothDefeatsWarned
		bBothDefeatsWarned = true
		Debug.MessageBox(BOTH_DEFEATS_MSG)
	EndIf
EndFunction

bool Function KillerBunnyOK()
	return ModLoaded("mihailkillerbunny.esp")
EndFunction

; Mihail's cave rabbit is Unique, so we never PlaceAtMe that actor (killing a copy can kill the original).
; When the third climax-fauna option is on, vanilla hares are reskinned to his killer-rabbit race instead.
Race Function KillerBunnyRace()
	If !KillerBunnyOK()
		return None
	EndIf
	return Game.GetFormFromFile(0x00000800, "mihailkillerbunny.esp") as Race
EndFunction

Function SyncFaunaFlag()
	bFauna = iFaunaMode > 0
EndFunction

; Old saves only had bFauna on/off: on becomes vanilla rabbits (mode 1).
Function MigrateFaunaMode()
	If iFaunaMode == 0 && bFauna
		iFaunaMode = 1
	EndIf
	SyncFaunaFlag()
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
	ResolveSoft()
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
	RescueRelease(false)
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
	; 0.2 modules: nothing pending survives a panic
	bMorningArmed = false
	bMorningPending = false
	bRestPending = false
	iRestKind = 0
	ClearDrinks()
	bBathPending = false
	bBathDone = true
	kBathSubject = None
	kBathCo = None
	bForceFauna = false
	bForceWatch = false
	If kWatchSpawn
		kWatchSpawn.Disable(false)
		kWatchSpawn.Delete()
		kWatchSpawn = None
	EndIf
	DeleteFauna()
	UpdateWatchers()
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
	kSceneActs = kNoActors
	kSceneActs2 = kNoActors
	sScene2 = ""
	bPaired = false
	iKind = 0
	kFurn = None
	sPreScene = ""
	If bCalmed
		bCalmed[0] = false
		bCalmed[1] = false
		bCalmed[2] = false
		bCalmed[3] = false
	EndIf
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
	float now = Utility.GetCurrentGameTime()
	If now < fOKRHeldUntil || now < fODefUntil || now < fBakaUntil   ; 0.3/0.5: Kidnapped Redux / a defeat mod has the player
		return true
	EndIf
	If bRescueOn                                     ; 0.3: a follower rescue side scene is running
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
	If ProtectedForms
		If ProtectedForms.Find(a as Form) >= 0 || ProtectedForms.Find(a.GetActorBase() as Form) >= 0
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

; 0.6: an Actor array of exactly n slots (1-8) built with plain Papyrus, so lists handed to
; OStim have Length == actor count and no empty slots. Scene lists are at most 4 + 2 = 6.
Actor[] Function NewActorArray(int n)
	If n <= 1
		return new Actor[1]
	ElseIf n == 2
		return new Actor[2]
	ElseIf n == 3
		return new Actor[3]
	ElseIf n == 4
		return new Actor[4]
	ElseIf n == 5
		return new Actor[5]
	ElseIf n == 6
		return new Actor[6]
	ElseIf n == 7
		return new Actor[7]
	EndIf
	return new Actor[8]
EndFunction

; attackers first, then victims; tries the given order, then the reverse / OStim-sorted order. Sets outActs.
string Function SceneForSet(Actor[] att, int na, Actor[] vic, int nv, bool forced, Actor[] outActs)
	int total = na + nv
	Actor[] acts = NewActorArray(total)
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
			Actor[] dom = NewActorArray(na)
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
			kSceneActs = NewActorArray(total)
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
; 0.7: nothing is moved, spawned, or staged while the sleep or wait is running or the
; Sleep/Wait Menu is open (other mods, e.g. NPC AI Position Fix, track every actor moved in
; that window). Sleep start only rolls; the event stages after you wake and the menu closes.
Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	bSleptThisMenu = true
	If bRestPending || bMorningPending
		; stale: the last sleep never reported its end; release it instead of blocking forever
		bRestPending = false
		bMorningPending = false
		iRestKind = 0
		bBusy = false
	EndIf
	If !Ready()
		return
	EndIf
	If MorningCheck()
		return      ; the morning after takes this sleep; it stages when you wake
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
	If menuName != "Sleep/Wait Menu"
		return
	EndIf
	If bSleptThisMenu
		If bRestPending || bMorningPending
			RunPendingRest(false)      ; 0.7: fallback if the sleep-stop event was missed
		EndIf
		return
	EndIf
	If !Ready()
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
	float[] ch = new float[16]
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
	If bInnShare && isSleep && cat == 2 && PartyFollowers(1500.0) >= 1
		ch[K_INNSHARE] = Mod(fInnShareChance, drunk)
	EndIf
	If bDarkGift && isSleep
		ch[K_DARKGIFT] = fDarkGiftChance
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
	int[] order = new int[13]
	order[0] = K_JAIL
	order[1] = K_TRESPASS
	order[2] = K_CHEAT
	order[3] = K_BETRAYAL
	order[4] = K_SPIKED
	order[5] = K_INN
	order[6] = K_INNSHARE
	order[7] = K_DARKGIFT
	order[8] = K_VAMPIRE
	order[9] = K_CREATURE
	order[10] = K_ATTACK
	order[11] = K_ROAD
	order[12] = 0
	int h = 1
	While h <= hours
		int k = 0
		While k < 12
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
	If iForceMode > 0 && iForceMode != K_DEFEAT && iForceMode != K_BATH
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
		; 0.7: do not interrupt the sleep; stage once you are awake and the menu has closed
		iRestKind = kind
		iRestEpoch = ep
		bRestPending = true
		Log("sleep event kind " + kind + " (rolled for hour " + iHitHour + ") waits until you wake")
		return
	EndIf
	; wait: OnMenuClose already runs after the menu closed; give other mods a moment first
	RestSettle()
	StageWithFade(kind, ep, true)
EndFunction

; 0.7: bounded wait for the Sleep/Wait Menu to close, then a short settle so other mods
; (e.g. NPC AI Position Fix) finish their after-rest update before anything moves or spawns
Function RestSettle()
	float waited = 0.0
	While UI.IsMenuOpen("Sleep/Wait Menu") && waited < REST_MENU_CAP
		Utility.WaitMenuMode(0.25)
		waited += 0.25
	EndWhile
	Utility.Wait(REST_SETTLE)      ; counts only outside menus
EndFunction

; 0.7: run the event rolled at sleep start (or the morning after), after the sleep ended
Function RunPendingRest(bool interrupted)
	bool morning = bMorningPending
	bool rest = bRestPending
	int kind = iRestKind
	int ep = iRestEpoch
	bMorningPending = false
	bRestPending = false
	iRestKind = 0
	If !morning && !rest
		return
	EndIf
	If morning
		ep = iEpoch
		kind = K_MORNING
	EndIf
	If interrupted || !Ready() || !Alive(ep) || kind == 0
		If interrupted
			Log("sleep was interrupted: event kind " + kind + " dropped")
		EndIf
		If Alive(ep) || !bMaster
			bBusy = false
		EndIf
		kPendingSpouse = None
		return
	EndIf
	RestSettle()
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
		; 0.7: runs only after the rest has ended and the menu has closed. Let the player get
		; out of bed on their own first; only nudge them to stand if they are still in it.
		int n = 0
		While PlayerRef.GetSitState() != 0 && n < 20
			Utility.Wait(0.25)
			n += 1
		EndWhile
		If PlayerRef.GetSitState() != 0
			PlayerRef.MoveTo(PlayerRef)
			n = 0
			While PlayerRef.GetSitState() != 0 && n < 20
				Utility.Wait(0.25)
				n += 1
			EndWhile
		EndIf
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
	ElseIf kind == K_MORNING
		return StageMorning(ep)
	ElseIf kind == K_BATH
		return StageBath(ep)
	ElseIf kind == K_INNSHARE
		return StageInnShare(ep)
	ElseIf kind == K_DARKGIFT
		return StageDarkGift(ep)
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
	; 0.3 follower rescue comes first for a downed follower; the full Defeat path below is unchanged
	If bRescueOn
		If a == PlayerRef
			RescueOutcome(0)       ; the player went down too: they did not get there in time
		ElseIf a == kRescueVic
			return
		Else
			return                 ; another follower: plain bleedout, the fight goes on
		EndIf
	ElseIf a != PlayerRef && TryFollowerRescue(a)
		return
	EndIf
	If !Ready() || !bDefeatEnabled
		DefeatFailed(a)
		return
	EndIf
	bool forced = iForceMode == K_DEFEAT
	If a == PlayerRef && (!bDefeatPlayer || DefeatModOK())   ; 0.3/0.5: ODefeat Reforged / Baka Defeat handles a downed player
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
	If bMaster && bDefeatEnabled && bDefeatPlayer && bDefeatEssential && !DefeatModOK()
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
	bCalmed[idx] = true
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

; 0.8: get every scene actor (not the player, StageWithFade handles them) out of a bed, chair
; or sleep before OStim takes them, so nobody stays in a sleeping pose during the scene.
; Bounded: one nudge, up to 4 s of waiting, one more nudge for anyone still stuck.
Function LeaveFurniture(Actor[] acts)
	If !acts
		return
	EndIf
	bool any = false
	int i = 0
	While i < acts.Length
		Actor a = acts[i]
		If a && a != PlayerRef && !a.IsDead() && (a.GetSitState() != 0 || a.GetSleepState() != 0)
			Log("scene: " + a.GetDisplayName() + " leaves furniture/sleep (sit " + a.GetSitState() + ", sleep " + a.GetSleepState() + ")")
			a.MoveTo(a)
			a.EvaluatePackage()
			any = true
		EndIf
		i += 1
	EndWhile
	If !any
		return
	EndIf
	int n = 0
	bool stuck = true
	While stuck && n < 16
		Utility.Wait(0.25)
		stuck = false
		i = 0
		While i < acts.Length
			Actor a = acts[i]
			If a && a != PlayerRef && !a.IsDead() && a.GetSitState() != 0
				stuck = true
			EndIf
			i += 1
		EndWhile
		n += 1
	EndWhile
	i = 0
	While i < acts.Length
		Actor a = acts[i]
		If a && a != PlayerRef && !a.IsDead() && (a.GetSitState() != 0 || a.GetSleepState() != 0)
			a.MoveTo(a)
			a.EvaluatePackage()
		EndIf
		i += 1
	EndWhile
EndFunction

int Function StartThread(Actor[] acts, Actor[] dom, string scene, string meta, int ep)
	If !Alive(ep)
		return -1
	EndIf
	LeaveFurniture(acts)      ; 0.8: also before a bed scene (kFurn): OStim places them on the bed
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
	If kFurn
		OThreadBuilder.SetFurniture(b, kFurn)
	Else
		OThreadBuilder.NoFurniture(b)
	EndIf
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
	Actor[] dom
	If nAtt < 1
		return dom      ; None: no dominant actors
	EndIf
	dom = NewActorArray(nAtt)
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
		If sPreScene != "" && kSceneActs
			scene = sPreScene
		Else
			kFurn = None
			scene = BuildScene(forced)
		EndIf
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
		If forced || IsSpawned(kAtt[i]) || (kAtt[i] != PlayerRef && kAtt[i].IsHostileToActor(PlayerRef))
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
		Actor[] dom
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
	ElseIf iKind == K_MORNING
		return "After a night of heavy drinking, " + pn + " wakes up in a strange bed at " + where + ", tangled up with " + kAttacker.GetDisplayName() + ", with no memory of how they got there - and things pick up right where they left off."
	ElseIf iKind == K_BATH
		If bForcedScene
			return "While " + vn + " is bathing, naked, near " + where + ", " + an + " comes upon them and forces themselves on " + vn + "."
		EndIf
		return "Bathing together near " + where + ", " + kAttacker.GetDisplayName() + " and " + kVictim.GetDisplayName() + " let the wash turn into something more."
	ElseIf iKind == K_INNSHARE
		return "The inn at " + where + " was full, so the party shares a single room. In the dark, " + kAttacker.GetDisplayName() + " and " + kVictim.GetDisplayName() + " end up in the same bed and do not go to sleep."
	ElseIf iKind == K_DARKGIFT
		If bForcedScene
			return "At " + where + ", " + pn + " wakes to the vampire " + kAttacker.GetDisplayName() + " pinning them down, fangs at their throat, taking them."
		EndIf
		return "At " + where + ", " + pn + " wakes to the vampire " + kAttacker.GetDisplayName() + " making love to them, cold lips at their throat."
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
	ElseIf iKind == K_MORNING
		ShowMsg("Your head is pounding... whose bed is this? " + kAttacker.GetDisplayName() + " is already awake.")
		shake = false
	ElseIf iKind == K_BATH
		ShowMsg(an + " joins " + vn + " in the water...")
	ElseIf iKind == K_INNSHARE
		ShowMsg("One room, one party... " + kAttacker.GetDisplayName() + " and " + kVictim.GetDisplayName() + " aren't sleeping.")
		shake = false
	ElseIf iKind == K_DARKGIFT
		ShowMsg("Cold lips at your throat... " + kAttacker.GetDisplayName() + " has come for you.")
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
	If fODefUntil > 0.0
		ODefSceneEnded(strArgs)
	EndIf
	int id = numArg as int
	If bRescueOn && id >= 0 && id == iRescueThread
		RescueOutcome(0)
		return
	EndIf
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
	If bRescueOn
		return       ; mid-battle: no walk-ins or distant watchers on top of a rescue
	EndIf
	int id = numArg as int
	CaughtCheck(id)
	WatchCheck(id)
EndEvent

Function CaughtCheck(int id)
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
EndFunction

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
			ElseIf bCalmed[i] && !IsSpawned(a)
				a.SetActorValue("Aggression", fOldAgg[i])
			EndIf
			bCalmed[i] = false
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
	DarkGiftAftermath()
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
	If bMaster && ((bDefeatEnabled && bDefeatFollowers) || bRescue || (bBath && bBathFollowers && BathModOK()))
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

; =====================================================================================
; ======================= 0.2 modules =======================
; Every module below is OFF by default, needs the master switch, and is stopped by the
; panic key. Children are refused for every role (IsMinor checks + SceneForSet).
; =====================================================================================

; ---------- soft-dependency forms (resolved on load / master on; no masters) ----------
Function ResolveSoft()
	InitArrays()
	kIActAlc = None
	kIActDrunk = None
	kExtraAlc = kNoForms
	If IActionsOK()
		kIActAlc = Game.GetFormFromFile(0x00000006, "iActions.esp") as FormList
		kIActDrunk = Game.GetFormFromFile(0x00000002, "iActions.esp") as Faction
		If JCOK()
			kExtraAlc = ODS_IActions.ExtraAlcohol()
		EndIf
	EndIf
	If !kExtraAlc
		Form[] tExtra = new Form[64]
		kExtraAlc = tExtra
	EndIf
	AddDlcDrink(0x000207E5, "Dragonborn.esm")
	AddDlcDrink(0x000207E6, "Dragonborn.esm")
	AddDlcDrink(0x000248CC, "Dragonborn.esm")
	AddDlcDrink(0x000248CE, "Dragonborn.esm")
	AddDlcDrink(0x0003572F, "Dragonborn.esm")
	AddDlcDrink(0x00003535, "HearthFires.esm")
	AddDlcDrink(0x00003536, "HearthFires.esm")
	kDnBList = None
	kBisFx1 = None
	kBisFx2 = None
	int i = 0
	While i < 8
		kBathFx[i] = None
		i += 1
	EndWhile
	If DnBOK()
		kDnBList = ODS_DnB.BathingActors()
		MagicEffect[] d = ODS_DnB.WashEffects()
		int j = 0
		While d && j < d.Length
			AddBathFx(d[j])
			j += 1
		EndWhile
	EndIf
	If BiSOK()
		kBisFx1 = Game.GetFormFromFile(0x0000002C, "Bathing in Skyrim.esp") as MagicEffect   ; mzinPlayBathingAnimationEffect
		kBisFx2 = Game.GetFormFromFile(0x0000002F, "Bathing in Skyrim.esp") as MagicEffect   ; mzinPlayBathingAnimationFollowerEffect
		AddBathFx(kBisFx1)
		AddBathFx(kBisFx2)
	EndIf
	UpdateWatchers()
	Log("soft: iActions " + IActionsOK() + ", Dirt and Blood " + DnBOK() + " (list " + kDnBList + "), Bathing in Skyrim " + BiSOK() + ", Blood and OStim " + BaOOK() + ", Sacrosanct " + SacrosanctOK() + ", OStim Kidnapped Redux " + OKROK() + ", ODefeat Reforged " + ODefeatOK() + ", Baka Defeat " + BakaDefeatOK() + ", Killer Rabbit of Caerbannog " + KillerBunnyOK())
EndFunction

Function AddDlcDrink(int id, string plugin)
	If !ModLoaded(plugin)
		return
	EndIf
	Form f = Game.GetFormFromFile(id, plugin)
	If f && (f as Potion) && kExtraAlc.Find(f) < 0
		int i = kExtraAlc.Find(None)
		If i >= 0
			kExtraAlc[i] = f
		EndIf
	EndIf
EndFunction

Function AddBathFx(MagicEffect fx)
	If fx && kBathFx.Find(fx) < 0
		int i = kBathFx.Find(None)
		If i >= 0
			kBathFx[i] = fx
		EndIf
	EndIf
EndFunction

; alias event states: the player / follower aliases only listen while a module needs it
Function UpdateWatchers()
	bool bathOn = bMaster && bBath && BathModOK()
	bool playerOn = (bathOn && bBathPlayer) || (bathOn && bBathFollowers) || (bMaster && bMorningAfter)
	ODS_PlayerAlias pa = GetAlias(0) as ODS_PlayerAlias
	If pa
		pa.SetWatch(playerOn, bathOn, bMaster && bMorningAfter, kBathFx)
	EndIf
	bool folOn = bathOn && bBathFollowers
	(Follower1Alias as ODS_FollowerAlias).SetWatch(folOn, kBathFx)
	(Follower2Alias as ODS_FollowerAlias).SetWatch(folOn, kBathFx)
	(Follower3Alias as ODS_FollowerAlias).SetWatch(folOn, kBathFx)
	(Follower4Alias as ODS_FollowerAlias).SetWatch(folOn, kBathFx)
EndFunction

; ---------- shared helpers ----------
; adult followers near the player (party size minus the player)
int Function PartyFollowers(float range)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, range, false, false, false)
	int c = 0
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && IsFollowerActor(a) && !a.IsDead() && !a.IsDisabled() && !IsMinor(a)
			c += 1
		EndIf
		i += 1
	EndWhile
	return c
EndFunction

; a free bed near center; random among the closest few when pickRandom
ObjectReference Function FindBed(ObjectReference center, float radius, bool pickRandom)
	If center == None
		return None
	EndIf
	ObjectReference[] fs = OFurniture.FindFurniture(2, center, radius, 0.0)
	ObjectReference[] beds = new ObjectReference[8]
	int c = 0
	int i = 0
	While fs && i < fs.Length && c < 8
		If fs[i] && StringUtil.Find(OFurniture.GetFurnitureType(fs[i]), "bed") >= 0
			beds[c] = fs[i]
			c += 1
		EndIf
		i += 1
	EndWhile
	If c == 0
		return None
	EndIf
	If pickRandom
		return beds[Utility.RandomInt(0, c - 1)]
	EndIf
	return beds[0]
EndFunction

; consensual scene on a bed for exactly two adults; sets kFurn / sPreScene / kSceneActs
bool Function PrepBedScene(Actor a, Actor b, ObjectReference bed)
	If bed == None || a == None || b == None || IsMinor(a) || IsMinor(b)
		return false
	EndIf
	string ft = OFurniture.GetFurnitureType(bed)
	If ft == "" || ft == "none"
		return false
	EndIf
	Actor[] acts = new Actor[2]
	acts[0] = a
	acts[1] = b
	int t = 0
	While t < 2
		int k = 0
		While k < 6
			string s
			If k < 3
				s = OLibrary.GetRandomFurnitureSceneWithAnySceneTagCSV(acts, ft, "romantic,loving,sensual,lustful,passionate")
			Else
				s = OLibrary.GetRandomFurnitureScene(acts, ft)
			EndIf
			If s != "" && !IsKissScene(s) && !IsAggroScene(s)
				kFurn = bed
				sPreScene = s
				kSceneActs = acts
				return true
			EndIf
			k += 1
		EndWhile
		Actor tmp = acts[0]
		acts[0] = acts[1]
		acts[1] = tmp
		t += 1
	EndWhile
	return false
EndFunction

; ======================= 0.2: MORNING AFTER =======================
; O'Deadly counts the player's own drinks (iActions does not track the player and sends no event).
; Called by ODS_PlayerAlias.OnObjectEquipped for potions while the module is on.
Function ClearDrinks()
	If fDrinkTimes
		int i = 0
		While i < 8
			fDrinkTimes[i] = 0.0
			i += 1
		EndWhile
	EndIf
	iDrinkIdx = 0
EndFunction

bool Function AlcoholName(string n)
	If n == ""
		return false
	EndIf
	If n == "Ale" || StringUtil.Find(n, " Ale") >= 0 || StringUtil.Find(n, "Ale ") == 0
		return true
	EndIf
	return StringUtil.Find(n, "Mead") >= 0 || StringUtil.Find(n, "Wine") >= 0 || StringUtil.Find(n, "Beer") >= 0 || StringUtil.Find(n, "Sujamma") >= 0 || StringUtil.Find(n, "Shein") >= 0 || StringUtil.Find(n, "Flin") >= 0 || StringUtil.Find(n, "Brandy") >= 0 || StringUtil.Find(n, "Rum") == 0 || StringUtil.Find(n, " Rum") >= 0 || StringUtil.Find(n, "Cider") >= 0 || StringUtil.Find(n, "Grog") >= 0 || StringUtil.Find(n, "Whiskey") >= 0 || StringUtil.Find(n, "Whisky") >= 0 || StringUtil.Find(n, "Vodka") >= 0 || StringUtil.Find(n, "Liquor") >= 0
EndFunction

bool Function IsAlcohol(Form f)
	If f == None || !(f as Potion)
		return false
	EndIf
	If kIActAlc && kIActAlc.HasForm(f)          ; iActions list (it also injects extra_alcohol.json into this list)
		return true
	EndIf
	If kExtraAlc && kExtraAlc.Find(f) >= 0      ; extra_alcohol.json read by us + DLC drinks
		return true
	EndIf
	If ODS_AlcoholVanilla && ODS_AlcoholVanilla.HasForm(f)
		return true
	EndIf
	return AlcoholName(f.GetName())
EndFunction

Function OnPlayerConsumed(Form f)
	If !bMaster || !bMorningAfter || !IsAlcohol(f)
		return
	EndIf
	InitArrays()
	float now = Utility.GetCurrentGameTime()
	fDrinkTimes[iDrinkIdx] = now
	iDrinkIdx = (iDrinkIdx + 1) % 8
	int c = 0
	int i = 0
	While i < 8
		If fDrinkTimes[i] > 0.0 && (now - fDrinkTimes[i]) * 24.0 <= fMorningWindow
			c += 1
		EndIf
		i += 1
	EndWhile
	If c >= iMorningDrinks && !bMorningArmed
		bMorningArmed = true
		fMorningArmedAt = now
		Log("morning after: " + c + " drinks in " + fMorningWindow + "h - armed for the next sleep")
	EndIf
EndFunction

Function ForceMorning()
	iForceMode = K_MORNING
	bMorningArmed = true
	fMorningArmedAt = Utility.GetCurrentGameTime()
EndFunction

; on sleep start: binge within the last 12 game hours, then a roll
bool Function MorningCheck()
	If !bMorningAfter || !bMorningArmed || bBusy
		return false
	EndIf
	If (Utility.GetCurrentGameTime() - fMorningArmedAt) * 24.0 > 12.0
		bMorningArmed = false
		return false
	EndIf
	bool forced = iForceMode == K_MORNING
	If OtherBusy(false) || (!forced && CooldownActive())
		return false
	EndIf
	bMorningArmed = false
	ClearDrinks()
	If forced
		iForceMode = 0
	ElseIf Utility.RandomFloat(0.0, 100.0) >= fMorningChance
		Log("morning after: no roll hit")
		return false
	EndIf
	bMorningPending = true
	bBusy = true
	return true
EndFunction

; 0.7: the sleep event (or the morning after) stages here, after the menu has closed
Event OnSleepStop(bool abInterrupted)
	If !bMorningPending && !bRestPending
		return
	EndIf
	RunPendingRest(abInterrupted)
EndEvent

; 3 = plastered / blackout (iActions), 2 = drunk, 1 = sober
int Function DrunkTier(Actor a)
	If kIActDrunk && a.IsInFaction(kIActDrunk)
		int r = a.GetFactionRank(kIActDrunk)
		If r >= 0
			int cat = 0
			If r > 0
				cat = ((r - 1) / 2) + 1    ; iActions GetCategoryFromRank, default 2 points per level
			EndIf
			If cat >= 3
				return 3
			EndIf
			return 2
		EndIf
	EndIf
	If IsDrunk(a)
		return 2
	EndIf
	return 1
EndFunction

bool Function MorningOK(Actor a)
	return a && BaseEligible(a) && IsHumanoid(a) && !IsProtected(a) && !a.IsHostileToActor(PlayerRef) && (bGuardAttackers || !IsGuardActor(a))
EndFunction

Actor Function FindMorningPartner(int ep)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 8000.0, false, false, true)
	Actor[] pool = new Actor[32]
	int[] tier = new int[32]
	int c = 0
	int best = 0
	int i = 0
	While i < near.Length && c < 32
		Actor a = near[i]
		If MorningOK(a)
			int t = DrunkTier(a)
			pool[c] = a
			tier[c] = t
			If t > best
				best = t
			EndIf
			c += 1
		EndIf
		i += 1
	EndWhile
	If c == 0
		return None
	EndIf
	int want = best
	While want >= 1 && Alive(ep)
		int tries = 0
		While tries < 6 && Alive(ep)
			int k = Utility.RandomInt(0, c - 1)
			If tier[k] == want && pool[k] && PairScene(pool[k], PlayerRef, false) != ""
				return pool[k]
			EndIf
			tries += 1
		EndWhile
		; sweep this tier in order before dropping a tier
		int j = 0
		While j < c
			If tier[j] == want && pool[j] && PairScene(pool[j], PlayerRef, false) != ""
				return pool[j]
			EndIf
			j += 1
		EndWhile
		want -= 1
	EndWhile
	return None
EndFunction

; nobody suitable: a stranger copied from someone local, else a traveller
Actor Function SpawnStranger(Actor vic, int ep)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 4000.0, false, false, true)
	int i = 0
	While i < near.Length && Alive(ep)
		Actor a = near[i]
		If a && IsHumanoid(a) && !IsFollowerActor(a) && !IsMinor(a) && !IsGuardActor(a) && a.GetActorBase() && !a.GetActorBase().IsUnique()
			Actor s = SpawnNear(a.GetActorBase(), vic)
			If s && PairScene(s, vic, false) != ""
				return s
			EndIf
			If s
				DeleteSpawn(s)
			EndIf
			i = near.Length
		EndIf
		i += 1
	EndWhile
	return TrySpawn(ODS_PoolWatcher, vic, false, ep)
EndFunction

bool Function StageMorning(int ep)
	If !IsValidVictim(PlayerRef, true, false, false)
		Log("morning after: player not a valid participant")
		return false
	EndIf
	Actor partner = FindMorningPartner(ep)
	If partner == None && bMorningSpawn
		partner = SpawnStranger(PlayerRef, ep)
	EndIf
	If partner == None || !Alive(ep)
		Log("morning after: nobody with a suitable scene")
		return false
	EndIf
	; somewhere random, in bed with them
	ObjectReference bed = FindBed(partner, 6000.0, true)
	If bed == None
		bed = FindBed(PlayerRef, 8000.0, true)
	EndIf
	If bed
		PlayerRef.MoveTo(bed)
		partner.MoveTo(bed)
		Utility.Wait(0.5)
	Else
		PlayerRef.MoveTo(partner)
	EndIf
	If !Alive(ep)
		return false
	EndIf
	AddAttacker(partner)
	AddVictim(PlayerRef)
	If bed && !PrepBedScene(partner, PlayerRef, bed)
		Log("morning after: no bed scene for this pair, using a normal scene")
	EndIf
	return StartEncounter(false, "odangerous,morningafter", ep)
EndFunction

; ======================= 0.2: BATHING =======================
; Dirt and Blood: every real wash runs Dirty_BathingQuest.PlayBatheAnimation, which keeps the actor
; in Dirty_BathingActors for the whole bath and applies Dirty_SoapEffectSpell (lather). We listen for
; that effect on the player / follower aliases and confirm via the formlist. Swimming and rain never
; call PlayBatheAnimation and are not hooked.
; Bathing in Skyrim: BiS_BatheEvent_<player FormID> and the PlayBathingAnimation effects mark a wash
; START; BiS_WashActorFinish (actor, wash prop, soap) marks the end. Both mods: one roll per wash.
bool Function StillBathing(Actor a)
	If a == None
		return false
	EndIf
	If kDnBList && kDnBList.HasForm(a)
		return true
	EndIf
	If kBisFx1 && a.HasMagicEffect(kBisFx1)
		return true
	EndIf
	return kBisFx2 && a.HasMagicEffect(kBisFx2)
EndFunction

; alias event: an effect in kBathFx was applied to the player or a follower
Function OnFxApplied(Actor a, MagicEffect fx)
	If !bMaster || !bBath || a == None || fx == None
		return
	EndIf
	If kBisFx1 && (fx == kBisFx1 || fx == kBisFx2)
		OnBathStart(a, 2)
	ElseIf kDnBList == None || kDnBList.HasForm(a)
		OnBathStart(a, 1)
	EndIf
EndFunction

Event OnBiSBathePlayer(bool abDoPlayerTeammates)
	OnBathStart(PlayerRef, 2)
EndEvent

Event OnBiSWashFinish(Form akActor, Form akWashProp, bool abUsedSoap)
	If bBathPending && akActor == kBathSubject
		bBathDone = true
	EndIf
EndEvent

Actor Function FindCoBather(Actor a)
	Actor[] near = OActorUtil.GetActorsInRangeV2(a, 1500.0, false, true, false)
	int i = 0
	While i < near.Length
		Actor b = near[i]
		If b && b != a && !b.IsDead() && IsHumanoid(b) && !IsMinor(b) && StillBathing(b)
			return b
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

Function OnBathStart(Actor a, int src)
	If !Ready() || !bBath || a == None || IsMinor(a)
		return
	EndIf
	float now = Utility.GetCurrentGameTime()
	If bBathPending || (now - fLastBathRoll) < 0.03
		return      ; one roll per wash, even with both bath mods installed
	EndIf
	If a == PlayerRef
		If !bBathPlayer
			return
		EndIf
	ElseIf !bBathFollowers || !IsFollowerActor(a) || IsProtected(a) || a.GetDistance(PlayerRef) > 4000.0
		return
	EndIf
	fLastBathRoll = now
	If iForceMode == K_BATH
		iForceMode = 0
		Log("bath: debug force")
	ElseIf bBusy || OtherBusy(false) || CooldownActive()
		return
	ElseIf Utility.RandomFloat(0.0, 100.0) >= fBathChance
		Log("bath: " + a.GetDisplayName() + " washes, no roll hit")
		return
	EndIf
	If bBusy || OtherBusy(false)
		return
	EndIf
	int ep = iEpoch
	bBusy = true
	bBathPending = true
	bBathDone = false
	kBathSubject = a
	kBathCo = FindCoBather(a)
	Log("bath: roll hit for " + a.GetDisplayName() + " (source " + src + "), waiting for the wash to finish")
	; let the bath mod finish its own animation / redress before the scene
	; 0.7: wait until the wash has really ended, however long the bath animation is. Vanilla
	; Dirt and Blood ends about 25 s after the lather; with the Malignis Animations patch a
	; woman's bath runs about 65 s (58 s wash + ~6.4 s dry, then the redress). One path covers
	; both: wait while the actor is still bathing, up to BATH_WAIT_CAP seconds.
	Utility.Wait(2.0)
	float waited = 0.0
	While Alive(ep) && !bBathDone && waited < BATH_WAIT_CAP && StillBathing(a)
		Utility.Wait(1.5)
		waited += 1.5
	EndWhile
	bBathPending = false
	If !Alive(ep)
		return
	EndIf
	If !bBathDone && StillBathing(a)
		; 0.7: still in the bath at the cap: never start a scene over a running bath
		Log("bath: " + a.GetDisplayName() + " still bathing after " + (waited as int) + " s, scene skipped")
		kBathSubject = None
		kBathCo = None
		bBusy = false
		return
	EndIf
	If kBathCo == None
		kBathCo = FindCoBather(a)
	EndIf
	Utility.Wait(BATH_SETTLE)      ; 0.7: let the bath mod re-equip clothes and give back controls
	StageWithFade(K_BATH, ep, false)
EndFunction

bool Function BathPartnerOK(Actor p, Actor vic)
	If p == None || p == vic || p.IsDead() || p.IsDisabled() || IsMinor(p) || OActor.IsInOStim(p) || IsStaged(p)
		return false
	EndIf
	If StillBathing(p)
		return false      ; 0.7: never pull someone out of a bath that is still running
	EndIf
	If p == PlayerRef
		return bBathPlayer
	EndIf
	return IsHumanoid(p) && NamedOK(p) && !IsProtected(p) && !p.IsInCombat()
EndFunction

bool Function StageBath(int ep)
	Actor vic = kBathSubject
	kBathSubject = None
	If vic == None || !IsValidVictim(vic, bBathPlayer, bBathFollowers, false)
		Log("bath: subject not valid")
		return false
	EndIf
	Actor partner = None
	bool forced = false
	; 1. someone already in the wash (a follower bathing with you, or you with them)
	If BathPartnerOK(kBathCo, vic) && PairScene(kBathCo, vic, false) != ""
		partner = kBathCo
	EndIf
	; 2. real people nearby: companions first, then strangers who would
	Actor[] near = OActorUtil.GetActorsInRangeV2(vic, 3000.0, false, true, true)
	int i = 0
	While partner == None && i < near.Length && Alive(ep)
		Actor a = near[i]
		If (a == PlayerRef || IsFollowerActor(a)) && BathPartnerOK(a, vic) && PairScene(a, vic, false) != ""
			partner = a
		EndIf
		i += 1
	EndWhile
	string sit = vic.GetDisplayName() + " is bathing, naked, in the water near " + WhereName()
	i = 0
	While partner == None && i < near.Length && Alive(ep)
		Actor b = near[i]
		If b && b != PlayerRef && !IsFollowerActor(b) && BathPartnerOK(b, vic) && BaseEligible(b) && (bGuardAttackers || !IsGuardActor(b))
			If PairScene(b, vic, true) != "" && WouldAct(b, vic, K_BATH, sit, ep)
				partner = b
				forced = true
			EndIf
		EndIf
		i += 1
	EndWhile
	; 3. only now spawn
	If partner == None && bBathSpawn
		partner = TrySpawn(ODS_PoolBandit, vic, true, ep)
		forced = partner != None
	EndIf
	If partner == None
		Log("bath: nobody nearby with a scene")
		return false
	EndIf
	kBathCo = partner
	AddAttacker(partner)
	AddVictim(vic)
	If forced
		return StartEncounter(true, "odangerous,aggressive,bath", ep)
	EndIf
	return StartEncounter(false, "odangerous,bath", ep)
EndFunction

; ======================= 0.2: INNS FULL (shared room) =======================
; The game rents one room. When the player sleeps in an inn with their party, sharing that room can
; lead somewhere. Sits beside the 0.1 inn modules (drunk patrons, spiked drinks), which are unchanged.
bool Function InnMateOK(Actor a)
	return a && IsFollowerActor(a) && !a.IsDead() && !a.IsDisabled() && !IsMinor(a) && !IsProtected(a) && !OActor.IsInOStim(a) && !IsStaged(a) && !a.IsInCombat() && NamedOK(a)
EndFunction

bool Function StageInnShare(int ep)
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 1500.0, false, false, true)
	Actor[] mates = new Actor[8]
	int c = 0
	int i = 0
	While i < near.Length && c < 8
		If InnMateOK(near[i])
			mates[c] = near[i]
			c += 1
		EndIf
		i += 1
	EndWhile
	If c == 0
		Log("inn share: no party in the room")
		return false
	EndIf
	bool withPlayer = bInnSharePlayer && IsValidVictim(PlayerRef, true, false)
	bool together = bInnShareFollowers && c >= 2
	If withPlayer && together
		withPlayer = Utility.RandomInt(0, 1) == 0
	EndIf
	Actor a = None
	Actor b = None
	If withPlayer
		int tries = 0
		While tries < c && a == None && Alive(ep)
			Actor f = mates[Utility.RandomInt(0, c - 1)]
			If PairScene(f, PlayerRef, false) != ""
				a = f
				b = PlayerRef
			EndIf
			tries += 1
		EndWhile
	EndIf
	If a == None && bInnShareFollowers && c >= 2
		int x = 0
		While x < c && a == None && Alive(ep)
			int y = x + 1
			While y < c && a == None
				If PairScene(mates[x], mates[y], false) != ""
					a = mates[x]
					b = mates[y]
				EndIf
				y += 1
			EndWhile
			x += 1
		EndWhile
	EndIf
	If a == None
		Log("inn share: no pair with a scene")
		return false
	EndIf
	AddAttacker(a)
	AddVictim(b)
	ObjectReference bed = FindBed(PlayerRef, 1500.0, false)
	If bed
		PrepBedScene(a, b, bed)
	EndIf
	return StartEncounter(false, "odangerous,innshare", ep)
EndFunction

; ======================= 0.2: WATCHED FROM A DISTANCE =======================
; Outdoors, during any OStim scene with the player or a follower, a hunter or traveller sees it from a
; distance. SkyrimNet gets what they saw (where, who, what) so they react: leave, call out or come closer.
string Function Compass(float dx, float dy)
	float ax = Math.abs(dx)
	float ay = Math.abs(dy)
	string ns = "north"
	If dy < 0.0
		ns = "south"
	EndIf
	string ew = "east"
	If dx < 0.0
		ew = "west"
	EndIf
	If ay > ax * 2.0
		return ns
	ElseIf ax > ay * 2.0
		return ew
	EndIf
	return ns + "-" + ew
EndFunction

string Function NamesOf(Actor[] acts)
	string s = ""
	int i = 0
	While i < acts.Length
		If acts[i]
			If s != ""
				If i == acts.Length - 1
					s += " and "
				Else
					s += ", "
				EndIf
			EndIf
			s += acts[i].GetDisplayName()
		EndIf
		i += 1
	EndWhile
	return s
EndFunction

Actor Function FindWatcher(Actor[] acts)
	Actor center = acts[0]
	Actor[] near = OActorUtil.GetActorsInRangeV2(center, 6000.0, false, false, false)
	bool playerIn = acts.Find(PlayerRef) >= 0
	Actor fallback = None
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && acts.Find(a) < 0 && !a.IsDead() && !a.IsDisabled() && IsHumanoid(a) && !IsMinor(a) && !IsFollowerActor(a) && !OActor.IsInOStim(a) && !a.IsInCombat() && !a.IsHostileToActor(PlayerRef) && a.GetSleepState() != 3 && a.GetDistance(center) >= 1000.0
			If playerIn && a.HasLOS(PlayerRef)
				return a
			EndIf
			If fallback == None
				fallback = a
			EndIf
		EndIf
		i += 1
	EndWhile
	return fallback
EndFunction

Actor Function SpawnWatcher(Actor center)
	If ODS_PoolWatcher == None || ODS_PoolWatcher.GetSize() == 0
		return None
	EndIf
	Form base = ODS_PoolWatcher.GetAt(Utility.RandomInt(0, ODS_PoolWatcher.GetSize() - 1))
	If base == None
		return None
	EndIf
	Actor w = center.PlaceAtMe(base, 1, false, true) as Actor
	If w == None
		return None
	EndIf
	float ang = Utility.RandomFloat(0.0, 360.0)
	float dist = Utility.RandomFloat(2200.0, 3200.0)
	w.SetPosition(center.GetPositionX() + Math.cos(ang) * dist, center.GetPositionY() + Math.sin(ang) * dist, center.GetPositionZ())
	PO3_SKSEFunctions.MoveToNearestNavmeshLocation(w)
	If IsMinor(w)
		w.Delete()
		return None
	EndIf
	w.SetActorValue("Aggression", 0.0)
	w.Enable()
	kWatchSpawn = w
	return w
EndFunction

Function WatchCheck(int id)
	If !Ready() || !bWatched || id < 0
		return
	EndIf
	float now = Utility.GetCurrentGameTime()
	If !bForceWatch && (now - fLastWatched) * 24.0 < 2.0
		return
	EndIf
	Actor[] acts = OThread.GetActors(id)
	If acts.Length < 1
		return
	EndIf
	bool ours = false
	int q = 0
	While q < acts.Length
		If IsMinor(acts[q])
			return
		EndIf
		If acts[q] == PlayerRef || IsFollowerActor(acts[q])
			ours = true
		EndIf
		q += 1
	EndWhile
	Cell cl = acts[0].GetParentCell()
	If !ours || cl == None || cl.IsInterior()
		return
	EndIf
	If !bForceWatch && Utility.RandomFloat(0.0, 100.0) >= fWatchChance
		return
	EndIf
	bForceWatch = false
	fLastWatched = now
	int ep = iEpoch
	Utility.Wait(Utility.RandomFloat(8.0, 20.0))
	If !Alive(ep) || !OThread.IsRunning(id)
		return
	EndIf
	Actor w = FindWatcher(acts)
	If w == None && bWatchSpawn && kWatchSpawn == None
		w = SpawnWatcher(acts[0])
	EndIf
	If w == None || !Alive(ep)
		Log("watched: nobody around to see it")
		return
	EndIf
	; what they saw: where, who, what
	string who = NamesOf(acts)
	string sc = OThread.GetScene(id)
	string how = "together, clearly enjoying themselves"
	If IsAggroScene(sc)
		how = "and it looks rough, maybe not willing"
	EndIf
	string pose = OMetaData.GetName(sc)
	If pose != "" && StringUtil.Find(pose, "$") != 0
		how += " (" + pose + ")"
	EndIf
	float dx = acts[0].GetPositionX() - w.GetPositionX()
	float dy = acts[0].GetPositionY() - w.GetPositionY()
	int metres = (Math.sqrt(dx * dx + dy * dy) / 70.0) as int
	string role = "a traveller"
	If StringUtil.Find(w.GetDisplayName(), "Hunter") >= 0 || StringUtil.Find(w.GetDisplayName(), "hunter") >= 0
		role = "a hunter"
	EndIf
	int r = Utility.RandomInt(0, 2)
	string act = "decides to slip away quietly and keep it to themselves for now"
	If r == 1
		act = "calls out to them from where they stand"
	ElseIf r == 2
		act = "starts to come closer for a better look"
	EndIf
	string txt = w.GetDisplayName() + ", " + role + " out in the wilds near " + WhereName() + ", spots " + who + " having sex out in the open, about " + metres + " metres to the " + Compass(dx, dy) + ", " + how + ". " + w.GetDisplayName() + " " + act + "."
	Actor tgt = acts[0]
	If acts.Find(PlayerRef) >= 0
		tgt = PlayerRef
	EndIf
	Log("watched: " + txt)
	If SNetOK() && bSkyrimNetStart
		SkyrimNetApi.DirectNarration(txt, w, tgt)
	Else
		ShowMsg("You feel eyes on you... someone is watching from a distance.")
	EndIf
	If SNetOK() && bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(w.GetDisplayName() + " saw " + who + " having sex out in the open near " + WhereName() + ".", w, tgt)
	EndIf
	If r == 2 && Alive(ep)
		w.PathToReference(acts[0], 0.4)
	EndIf
	; a spawned watcher goes back to the road after a while
	If w == kWatchSpawn
		Utility.Wait(120.0)
		If kWatchSpawn == w && !w.IsInCombat()
			kWatchSpawn = None
			w.Disable(true)
			w.Delete()
		EndIf
	EndIf
EndFunction

; ======================= 0.2: DARK GIFT =======================
; A vampire wakes the player, making love to them. With Blood and OStim installed the wake-up is a
; feeding scene. Afterwards: immune to disease (or already a vampire) = nothing infectious; otherwise
; vampirism. With Sacrosanct it goes through PlayerVampireQuest (Sacrosanct's own turning), else the
; vanilla Sanguinare Vampiris disease is contracted.
bool Function PrepFeedScene(Actor vamp, Actor vic)
	If !BaOOK() || IsMinor(vamp) || IsMinor(vic)
		return false
	EndIf
	Actor[] acts = new Actor[2]
	string[] ids = new string[3]
	If IsFemale(vamp) && !IsFemale(vic)
		acts[0] = vic
		acts[1] = vamp
		ids[0] = "Anub2PVampireFemaleCowgirlFeed"
		ids[1] = "Gunslicer2PVampire"
		ids[2] = "Anub2PVampireFemaleStandingFeed"
	ElseIf !IsFemale(vamp) && IsFemale(vic)
		acts[0] = vamp
		acts[1] = vic
		ids[0] = "Anub2PVampireMalePenetrationFeed"
		ids[1] = "Anub2PVampireMaleThighfuckFeed"
		ids[2] = "Anub2PVampireMalePenetrationFeed"
	Else
		return false
	EndIf
	int i = 0
	While i < 3
		If OMetaData.GetActorCount(ids[i]) == 2 && !IsKissScene(ids[i])
			sPreScene = ids[i]
			kSceneActs = acts
			kFurn = None
			return true
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

bool Function StageDarkGift(int ep)
	If !IsValidVictim(PlayerRef, true, false, false)
		return false
	EndIf
	Actor vamp = None
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 3500.0, false, false, true)
	int i = 0
	While i < near.Length && vamp == None && Alive(ep)
		Actor a = near[i]
		If a && IsHumanoid(a) && IsVampire(a) && BaseEligible(a, true) && !IsFollowerActor(a)
			If PairScene(a, PlayerRef, false) != "" || PairScene(a, PlayerRef, true) != ""
				vamp = a
			EndIf
		EndIf
		i += 1
	EndWhile
	If vamp == None
		vamp = TrySpawn(ODS_PoolVampire, PlayerRef, false, ep)
	EndIf
	If vamp == None
		vamp = TrySpawn(ODS_PoolVampire, PlayerRef, true, ep)
	EndIf
	If vamp == None || !Alive(ep)
		Log("dark gift: no vampire with a scene")
		return false
	EndIf
	vamp.MoveTo(PlayerRef)
	AddAttacker(vamp)
	AddVictim(PlayerRef)
	If PrepFeedScene(vamp, PlayerRef)
		Log("dark gift: Blood and OStim feeding scene " + sPreScene)
		If StartEncounter(false, "odangerous,vampire,darkgift,feeding", ep)
			return true
		EndIf
		sPreScene = ""
		If nAtt == 0
			AddAttacker(vamp)
			AddVictim(PlayerRef)
		EndIf
	EndIf
	If StartEncounter(false, "odangerous,vampire,darkgift", ep)
		return true
	EndIf
	If nAtt == 0
		AddAttacker(vamp)
		AddVictim(PlayerRef)
	EndIf
	return StartEncounter(true, "odangerous,aggressive,vampire,darkgift", ep)
EndFunction

Function DarkGiftAftermath()
	If iKind != K_DARKGIFT || kVictim != PlayerRef || !bDarkInfect || !bMaster
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	If PlayerRef.GetActorValue("DiseaseResist") >= 100.0 || IsVampire(PlayerRef)
		Log("dark gift: player is immune to disease - nothing infectious")
		return
	EndIf
	If SacrosanctOK()
		Log("dark gift: turning through Sacrosanct (PlayerVampireQuest)")
		Utility.Wait(2.0)
		If bMaster
			ODS_Vamp.TurnPlayer(PlayerRef)
		EndIf
	Else
		Spell d = Game.GetFormFromFile(0x000B8780, "Skyrim.esm") as Spell    ; Sanguinare Vampiris
		If d && !PlayerRef.HasSpell(d)
			PlayerRef.AddSpell(d, false)
		EndIf
		ShowMsg("The bite at your throat burns... you feel feverish.")
	EndIf
	If SNetOK() && bSkyrimNetLog && kAttacker
		SkyrimNetApi.RegisterPersistentEvent("The vampire " + kAttacker.GetDisplayName() + " fed on " + pn + " and left them with the Dark Gift in their blood.", kAttacker, PlayerRef)
	EndIf
EndFunction

; ======================= 0.2: CLIMAX FAUNA (easter egg) =======================
; A magical orgasm: rabbits surround the player and charge, butterflies swirl. Rabbits wait until
; the scene is over before they "attack" (vanilla hares have no real attack), so no scene is cut short.
Event OnOStimOrgasm(string eventName, string sceneId, float threadId, Form sender)
	If !Ready() || !bFauna || bFaunaRunning
		return
	EndIf
	int id = threadId as int
	If id < 0
		return
	EndIf
	Actor[] acts = OThread.GetActors(id)
	If acts.Find(PlayerRef) < 0
		return
	EndIf
	int q = 0
	While q < acts.Length
		If IsMinor(acts[q])
			return
		EndIf
		q += 1
	EndWhile
	float now = Utility.GetCurrentGameTime()
	If !bForceFauna && ((now - fLastFauna) * 24.0 < 1.0 || Utility.RandomFloat(0.0, 100.0) >= fFaunaChance)
		return
	EndIf
	bForceFauna = false
	fLastFauna = now
	FaunaBurst(id)
EndEvent

Function AddFauna(ObjectReference r)
	int i = kFauna.Find(None)
	If i >= 0
		kFauna[i] = r
	ElseIf r
		r.Delete()
	EndIf
EndFunction

Function DeleteFauna()
	If !kFauna
		return
	EndIf
	int i = 0
	While i < kFauna.Length
		ObjectReference r = kFauna[i]
		If r
			kFauna[i] = None
			r.Disable(false)
			r.Delete()
		EndIf
		i += 1
	EndWhile
	bFaunaRunning = false
EndFunction

Function FaunaBurst(int id)
	InitArrays()
	int ep = iEpoch
	bFaunaRunning = true
	ActorBase hare = None
	If ODS_PoolFauna && ODS_PoolFauna.GetSize() > 0
		hare = ODS_PoolFauna.GetAt(0) as ActorBase
	EndIf
	Race killerRace = None
	If iFaunaMode == 2
		killerRace = KillerBunnyRace()
		If !killerRace
			Log("fauna: Killer Rabbit option on, but mihailkillerbunny.esp was not found; using vanilla rabbits")
		EndIf
	EndIf
	int n = iFaunaRabbits
	If n > 30
		n = 30
	EndIf
	float px = PlayerRef.GetPositionX()
	float py = PlayerRef.GetPositionY()
	float pz = PlayerRef.GetPositionZ()
	Actor[] rabbits = new Actor[30]
	int i = 0
	While hare && i < n && Alive(ep)
		Actor r = PlayerRef.PlaceAtMe(hare, 1, false, true) as Actor
		If r
			If killerRace
				r.SetRace(killerRace)
				r.QueueNiNodeUpdate()
			EndIf
			float ang = (360.0 / n) * i + Utility.RandomFloat(-8.0, 8.0)
			float dist = Utility.RandomFloat(260.0, 460.0)
			r.SetPosition(px + Math.cos(ang) * dist, py + Math.sin(ang) * dist, pz)
			PO3_SKSEFunctions.MoveToNearestNavmeshLocation(r)
			r.SetActorValue("Aggression", 0.0)
			r.Enable()
			rabbits[i] = r
			AddFauna(r)
		EndIf
		i += 1
	EndWhile
	; butterflies of every kind we can find
	ObjectReference[] flies = new ObjectReference[18]
	int nb = 0
	If ODS_PoolButterfly && ODS_PoolButterfly.GetSize() > 0
		int k = 0
		While k < 18 && Alive(ep)
			Activator base = ODS_PoolButterfly.GetAt(k % ODS_PoolButterfly.GetSize()) as Activator
			If base
				ObjectReference b = PlayerRef.PlaceAtMe(base, 1, false, false)
				If b
					b.SetPosition(px + Utility.RandomFloat(-250.0, 250.0), py + Utility.RandomFloat(-250.0, 250.0), pz + Utility.RandomFloat(80.0, 220.0))
					flies[nb] = b
					nb += 1
					AddFauna(b)
				EndIf
			EndIf
			k += 1
		EndWhile
	EndIf
	string who = "rabbits"
	If killerRace
		who = "Killer Rabbits of Caerbannog"
	EndIf
	Log("fauna: " + n + " " + who + ", " + nb + " butterflies")
	ShowMsg("Wild magic answers the moment... the meadow comes alive.")
	If SNetOK() && bSkyrimNetStart
		If killerRace
			SkyrimNetApi.DirectNarration("At the peak of the moment a burst of wild, giddy magic ripples out from " + PlayerRef.GetDisplayName() + ": a swarm of butterflies of every colour whirls around them, and a ring of Killer Rabbits of Caerbannog appears out of nowhere, glaring.", None, None)
		Else
			SkyrimNetApi.DirectNarration("At the peak of the moment a burst of wild, giddy magic ripples out from " + PlayerRef.GetDisplayName() + ": a swarm of butterflies of every colour whirls around them, and a ring of rabbits appears out of nowhere, glaring.", None, None)
		EndIf
	EndIf
	; flutter around the player for a while
	int t = 0
	While t < 16 && Alive(ep)
		float cx = PlayerRef.GetPositionX()
		float cy = PlayerRef.GetPositionY()
		float cz = PlayerRef.GetPositionZ()
		int j = 0
		While j < nb
			If flies[j]
				flies[j].TranslateTo(cx + Utility.RandomFloat(-300.0, 300.0), cy + Utility.RandomFloat(-300.0, 300.0), cz + Utility.RandomFloat(60.0, 240.0), 0.0, 0.0, Utility.RandomFloat(0.0, 360.0), 140.0, 120.0)
			EndIf
			j += 1
		EndWhile
		Utility.Wait(1.25)
		t += 1
	EndWhile
	int j2 = 0
	While j2 < nb
		If flies[j2]
			int fi = kFauna.Find(flies[j2])
			If fi >= 0
				kFauna[fi] = None
			EndIf
			flies[j2].Disable(true)
			flies[j2].Delete()
		EndIf
		j2 += 1
	EndWhile
	; the rabbits charge once the scene is over
	float w = 0.0
	While Alive(ep) && OThread.IsRunning(id) && w < 180.0
		Utility.Wait(2.0)
		w += 2.0
	EndWhile
	If !Alive(ep)
		return
	EndIf
	i = 0
	While i < n
		Actor r2 = rabbits[i]
		If r2 && !r2.IsDead() && kFauna.Find(r2) >= 0
			r2.SetActorValue("Aggression", 2.0)
			r2.SetActorValue("Confidence", 4.0)
			r2.StartCombat(PlayerRef)
		EndIf
		i += 1
	EndWhile
	Utility.Wait(60.0)
	If Alive(ep)
		DeleteFauna()
	EndIf
	bFaunaRunning = false
EndFunction

; ======================= 0.3: SKYRIMNET BRIDGES (listeners only) =======================
; Lirael's OStim Kidnapped Redux (an OStim conversion of vinfamy's SexLab Kidnapped Redux) and
; Lirael's ODefeat Reforged. O'Deadly never starts, stops or changes their kidnappings or defeats:
; it listens to their public mod events, tells SkyrimNet what happened, and holds its own
; encounters while one of them has the player. Nothing here runs unless the plugin is loaded.
; Master switch off / panic: no SkyrimNet text. Adults only: a child is never named.

; ---------- OStim Kidnapped Redux ----------
; The events carry no actors, so the text names the player and the place only.
; OKidnapped_Refused only answers OKidnapped_Take, which O'Deadly never sends: not listened to.
bool Function OKRTalk()
	return bMaster && bOKRSkyrimNet && SNetOK()
EndFunction

; strArg "" / numArg 1 = another mod handed the player over (OKidnapped_Take), 0 = its own ambush
Event OnOKRTaken(string eventName, string strArg, float numArg, Form sender)
	sOKRWhere = WhereName()                              ; still at the ambush spot: the player is moved afterwards
	fOKRHeldUntil = Utility.GetCurrentGameTime() + 1.0   ; cleared by OKidnapped_End, lapses after a game day
	bool requested = numArg >= 1.0
	Log("Kidnapped Redux: taken near " + sOKRWhere + " (requested " + requested + ")")
	If !OKRTalk()
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	If bSkyrimNetStart
		If requested
			SkyrimNetApi.DirectNarration("Already beaten and helpless near " + sOKRWhere + ", " + pn + " is handed over to a gang of kidnappers, who drag them off to their hideout.", None, None)
		Else
			SkyrimNetApi.DirectNarration("Kidnappers jump " + pn + " near " + sOKRWhere + ", knock them down and drag them off to their hideout.", None, None)
		EndIf
	EndIf
	If bSkyrimNetLog
		If requested
			SkyrimNetApi.RegisterPersistentEvent(pn + " was handed over to kidnappers near " + sOKRWhere + " and dragged off to their hideout.", None, PlayerRef)
		Else
			SkyrimNetApi.RegisterPersistentEvent("Kidnappers ambushed " + pn + " near " + sOKRWhere + " and dragged them off to their hideout.", None, PlayerRef)
		EndIf
	EndIf
EndEvent

Event OnOKRDodged(string eventName, string strArg, float numArg, Form sender)
	string w = WhereName()
	Log("Kidnapped Redux: dodged near " + w)
	If OKRTalk() && bSkyrimNetStart
		string pn = PlayerRef.GetDisplayName()
		SkyrimNetApi.DirectNarration("Kidnappers try to jump " + pn + " near " + w + ", but " + pn + " slips the ambush.", None, None)
	EndIf
EndEvent

; strArg "escaped", "released" or "slavery"
Event OnOKREnd(string eventName, string strArg, float numArg, Form sender)
	fOKRHeldUntil = 0.0
	string w = sOKRWhere
	sOKRWhere = ""
	Log("Kidnapped Redux: end (" + strArg + ")")
	If !OKRTalk() || (strArg != "escaped" && strArg != "released" && strArg != "slavery")
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	string who = "The kidnappers who took " + pn
	If w != ""
		who += " near " + w
	EndIf
	string n
	string m
	If strArg == "escaped"
		n = pn + " breaks free and gets out of the kidnappers' hideout."
		m = who + " held them captive in their hideout and had their way with them, but " + pn + " escaped."
	ElseIf strArg == "released"
		n = pn + " comes to, exhausted, after the kidnappers are finished with them and let them go."
		m = who + " had their way with them in their hideout until " + pn + " passed out, then let them go. " + pn + " woke up exhausted."
	Else
		n = "After " + pn + " passes out in their hideout, the kidnappers sell them on into slavery."
		m = who + " had their way with them in their hideout until " + pn + " passed out, then sold them into slavery."
	EndIf
	If bSkyrimNetStart
		SkyrimNetApi.DirectNarration(n, None, None)
	EndIf
	If bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(m, None, PlayerRef)
	EndIf
EndEvent

; ---------- ODefeat Reforged ----------
; Its defeat scenes carry the OStim metadata "odefeat" + the victim's FormID, and it rebroadcasts
; ostim_start as "ODefeatAnimStart_" + each token. An escape tags the scene "odefeat_escaped"
; before stopping it; otherwise one outcome event follows the scene (robbery, safe wakeup, kill,
; arrest, or a third-party one such as "SSLV Entry"). Only OStim's own OJson is used to read the
; scene: no ODefeat script types.
bool Function ODefTalk()
	return bMaster && bODefSkyrimNet && SNetOK()
EndFunction

bool Function ODefPlayerScene(string json)
	string[] meta = OJson.GetMetadata(json)
	return meta && meta.Find("odefeat") >= 0 && meta.Find(PlayerRef.GetFormID() as string) >= 0
EndFunction

; "<winner> beat <player> near <place>" opener; falls back to "Someone"
string Function ODefWho()
	string w = sODefWhere
	If w == ""
		w = WhereName()
	EndIf
	string by = sODefBy
	If by == ""
		by = "Someone"
	EndIf
	return by + " beat " + PlayerRef.GetDisplayName() + " near " + w
EndFunction

Event OnODefStart(string eventName, string strArg, float numArg, Form sender)
	If !ODefPlayerScene(strArg)
		return      ; an NPC's defeat scene
	EndIf
	If Utility.GetCurrentGameTime() < fBakaUntil
		Log("ODefeat: player scene while Baka Defeat has the player, not narrated twice")
		return
	EndIf
	fODefUntil = Utility.GetCurrentGameTime() + 0.25     ; cleared by the outcome, lapses after 6 game hours
	bODefAwait = false
	sODefWhere = WhereName()
	sODefBy = ""
	Actor[] acts = OJson.GetActors(strArg)
	int i = 0
	While acts && i < acts.Length && sODefBy == ""
		If acts[i] && acts[i] != PlayerRef && !IsMinor(acts[i])
			sODefBy = acts[i].GetDisplayName()
		EndIf
		i += 1
	EndWhile
	Log("ODefeat: player defeated near " + sODefWhere + " by " + sODefBy)
	If ODefTalk() && bSkyrimNetStart
		string pn = PlayerRef.GetDisplayName()
		If sODefBy != ""
			SkyrimNetApi.DirectNarration(sODefBy + " has beaten " + pn + " near " + sODefWhere + ", and " + pn + " is at their mercy.", None, None)
		Else
			SkyrimNetApi.DirectNarration(pn + " has been beaten near " + sODefWhere + " and is at the mercy of whoever won the fight.", None, None)
		EndIf
	EndIf
EndEvent

; from OnOStimThreadEnd while a player defeat is in progress
Function ODefSceneEnded(string json)
	If !ODefPlayerScene(json)
		return
	EndIf
	string[] meta = OJson.GetMetadata(json)
	If meta.Find("odefeat_escaped") < 0
		bODefAwait = true       ; an outcome event follows
		return
	EndIf
	Log("ODefeat: player escaped")
	string pn = PlayerRef.GetDisplayName()
	string m = ODefWho() + " and forced themselves on them, but " + pn + " broke free and escaped."
	ODefClear()
	If ODefTalk()
		If bSkyrimNetStart
			SkyrimNetApi.DirectNarration(pn + " breaks free and escapes.", None, None)
		EndIf
		If bSkyrimNetLog
			SkyrimNetApi.RegisterPersistentEvent(m, None, PlayerRef)
		EndIf
	EndIf
EndFunction

Function ODefClear()
	fODefUntil = 0.0
	bODefAwait = false
	sODefWhere = ""
	sODefBy = ""
EndFunction

Function ODefSay(string n, string m)
	ODefClear()
	If !ODefTalk()
		return
	EndIf
	If bSkyrimNetStart && n != ""
		SkyrimNetApi.DirectNarration(n, None, None)
	EndIf
	If bSkyrimNetLog && m != ""
		SkyrimNetApi.RegisterPersistentEvent(m, None, PlayerRef)
	EndIf
EndFunction

Event OnODefRobbery(string eventName, string strArg, float numArg, Form sender)
	Log("ODefeat: robbery")
	string pn = PlayerRef.GetDisplayName()
	string keeper = "Whoever beat them"
	If sODefBy != ""
		keeper = sODefBy
	EndIf
	ODefSay(pn + " comes to not far from where they fell, beaten and missing some of their valuables. " + keeper + " may still have them.", ODefWho() + ", had their way with them and robbed them of some valuables.")
EndEvent

Event OnODefSafeWakeup(string eventName, string strArg, float numArg, Form sender)
	Log("ODefeat: safe wakeup")
	string pn = PlayerRef.GetDisplayName()
	ODefSay(pn + " comes to not far from where they fell, beaten and left behind.", ODefWho() + ", had their way with them and left them there.")
EndEvent

Event OnODefArrest(string eventName, string strArg, float numArg, Form sender)
	Log("ODefeat: arrest")
	string pn = PlayerRef.GetDisplayName()
	string by = "a guard"
	If sODefBy != ""
		by = sODefBy
	EndIf
	string w = sODefWhere
	If w == ""
		w = WhereName()
	EndIf
	string m = by + " beat " + pn + " near " + w + ", had their way with them and had them hauled off to jail."
	ODefSay("Beaten by " + by + " near " + w + ", " + pn + " is hauled off to jail.", m)
EndEvent

; the last save is reloaded right after, so a short narration only
Event OnODefKill(string eventName, string strArg, float numArg, Form sender)
	Log("ODefeat: kill")
	string pn = PlayerRef.GetDisplayName()
	string by = "The winner"
	If sODefBy != ""
		by = sODefBy
	EndIf
	ODefSay(by + " finishes " + pn + " off.", "")
EndEvent

; "SSLV Entry" is shared by several mods: only ours if a player defeat scene just ended without
; an escape, and Kidnapped Redux is not the one holding the player (it sends its own end event)
Event OnODefSlavery(string eventName, string strArg, float numArg, Form sender)
	float now = Utility.GetCurrentGameTime()
	If !bODefAwait || now >= fODefUntil || now < fOKRHeldUntil
		return
	EndIf
	Log("ODefeat: sold into slavery")
	string pn = PlayerRef.GetDisplayName()
	ODefSay("After the defeat, " + pn + " is sold on into slavery.", ODefWho() + ", had their way with them and sold them into slavery.")
EndEvent

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
	return bMaster && bBakaSkyrimNet && SNetOK()
EndFunction

Function BakaSay(string n, string m, Actor a1, Actor a2)
	If !BakaTalk()
		return
	EndIf
	If bSkyrimNetStart && n != ""
		SkyrimNetApi.DirectNarration(n, a1, a2)
	EndIf
	If bSkyrimNetLog && m != ""
		Actor who = a1
		If who == None
			who = PlayerRef
		EndIf
		SkyrimNetApi.RegisterPersistentEvent(m, who, a2)
	EndIf
EndFunction

int Function BakaSlot(int tid)
	If !iBakaTid || !iBakaKind
		InitArrays()
	EndIf
	int i = 0
	While i < 8
		If iBakaKind[i] > 0 && iBakaTid[i] == tid
			return i
		EndIf
		i += 1
	EndWhile
	return -1
EndFunction

int Function BakaFreeSlot()
	int i = 0
	While i < 8
		If iBakaKind[i] == 0
			return i
		EndIf
		i += 1
	EndWhile
	return 0     ; all busy (stale): reuse the first
EndFunction

; "<who> beat <player> near <place>"
string Function BakaWho()
	string w = sBakaWhere
	If w == ""
		w = WhereName()
	EndIf
	string by = sBakaBy
	If by == ""
		by = "Someone"
	EndIf
	return by + " beat " + PlayerRef.GetDisplayName() + " near " + w
EndFunction

Function BakaClear()
	sBakaWhere = ""
	sBakaBy = ""
	bBakaMemDone = false
EndFunction

Event OnBakaSceneStart(string eventName, string strArg, float numArg, Form sender)
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
		If acts[i] == None || IsMinor(acts[i])
			Log("Baka Defeat: scene " + tid + " has a child or an empty slot, not narrated")
			return
		EndIf
		If agg == None && acts[i] != vic
			agg = acts[i]
		EndIf
		i += 1
	EndWhile
	bool playerIn = acts.Find(PlayerRef) >= 0
	int kind = 4
	If vic == PlayerRef
		kind = 1
	ElseIf playerIn
		kind = 3
		agg = PlayerRef
	ElseIf IsFollowerActor(vic)
		kind = 2
	EndIf
	int s = BakaSlot(tid)
	If s < 0
		s = BakaFreeSlot()
	EndIf
	iBakaTid[s] = tid
	iBakaKind[s] = kind
	kBakaVic[s] = vic
	kBakaAgg[s] = agg
	string pn = PlayerRef.GetDisplayName()
	string w = WhereName()
	string an = agg.GetDisplayName()
	string vn = vic.GetDisplayName()
	Log("Baka Defeat: scene " + tid + " hook " + hook + " kind " + kind + " victim " + vn + " by " + an)
	If kind == 1
		float now = Utility.GetCurrentGameTime()
		bool fresh = now >= fBakaUntil
		fBakaUntil = now + 0.25        ; cleared by the outcome, lapses after 6 game hours
		If now < fODefUntil
			ODefClear()                ; both installed: Baka is the one telling this defeat
		EndIf
		If fresh
			BakaClear()
			sBakaWhere = w
			sBakaBy = an
			BakaSay(an + " has beaten " + pn + " near " + w + ". " + pn + " lies on the ground, disarmed and helpless, and " + an + " forces themselves on them.", "", agg, PlayerRef)
		Else
			BakaSay(an + " takes their turn with the beaten " + pn + ".", "", agg, PlayerRef)
		EndIf
	ElseIf kind == 2
		BakaSay(an + " drags " + pn + "'s companion " + vn + " down near " + w + " and forces themselves on them while the fight is lost.", "", agg, vic)
	ElseIf kind == 3
		BakaSay(pn + " pins the beaten " + vn + " to the ground near " + w + " and forces themselves on them.", "", PlayerRef, vic)
	Else
		BakaSay(an + " has beaten " + vn + " near " + w + " and forces themselves on them.", "", agg, vic)
	EndIf
EndEvent

Event OnBakaSceneEnd(string eventName, string strArg, float numArg, Form sender)
	int s = BakaSlot(numArg as int)
	If s < 0
		return
	EndIf
	int kind = iBakaKind[s]
	Actor vic = kBakaVic[s]
	Actor agg = kBakaAgg[s]
	iBakaKind[s] = 0
	iBakaTid[s] = -1
	kBakaVic[s] = None
	kBakaAgg[s] = None
	If vic == None || agg == None
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	string w = WhereName()
	If kind == 1
		If !bBakaMemDone
			bBakaMemDone = true
			BakaSay("", BakaWho() + " in a fight and had their way with them while " + pn + " lay helpless.", agg, PlayerRef)
		EndIf
	ElseIf kind == 2
		BakaSay("", agg.GetDisplayName() + " overpowered " + vic.GetDisplayName() + ", " + pn + "'s companion, near " + w + " and had their way with them.", agg, vic)
	ElseIf kind == 3
		BakaSay("", pn + " beat " + vic.GetDisplayName() + " near " + w + " and forced themselves on them.", PlayerRef, vic)
	Else
		BakaSay("", agg.GetDisplayName() + " beat " + vic.GetDisplayName() + " near " + w + " and had their way with them.", agg, vic)
	EndIf
EndEvent

; the player's post-assault events (Baka sends them only for the player)
Event OnBakaPostAssault(string eventName, string strArg, float numArg, Form sender)
	Log("Baka Defeat: post assault " + strArg)
	string pn = PlayerRef.GetDisplayName()
	float now = Utility.GetCurrentGameTime()
	If strArg == "DefeatedBegin"
		fBakaUntil = now + 0.04
		BakaSay(pn + " comes to in a rented bed at an inn, bruised and used. Someone hauled them off the field after the defeat.", BakaWho() + ". " + pn + " woke up later in a bed at an inn.", None, PlayerRef)
	ElseIf strArg == "LFDBegin"
		fBakaUntil = now + 0.04
		BakaSay("Hours later, " + pn + " comes to where the winners dumped them and left them for dead.", BakaWho() + ", used them and left them for dead.", None, PlayerRef)
	ElseIf strArg == "RobEnd"
		fBakaUntil = now + 0.04
		string by = "The ones who beat them"
		If sBakaBy != ""
			by = sBakaBy
		EndIf
		BakaSay(by + " goes through " + pn + "'s belongings and takes what is worth taking.", BakaWho() + " and robbed them of their valuables.", None, PlayerRef)
	ElseIf strArg == "EscapeEnd"
		fBakaUntil = 0.0
		BakaSay(pn + " gets away from the ones who beat them.", BakaWho() + ", but " + pn + " got away.", None, PlayerRef)
		BakaClear()
	EndIf
EndEvent

; ======================= 0.3: FOLLOWER RESCUE (mid-battle) =======================
; A follower who goes down in a fight may be taken by one nearby hostile while the rest of the
; fight goes on; the player can stop it. OFF by default, master switch and panic key apply, adults
; only. A side thread: it never sets bBusy, never pacifies the battlefield, never pulls the player
; or a second victim in. Only the pair is calmed: the attacker gets Aggression 0, stops combat and
; joins PlayerFaction (so followers stop fighting it); it is put in Extra3Alias (ODS_AttackerAlias),
; whose OnHit / OnActivate / OnDeath route here. It is not ghosted, so the player's hits land.
; The downed follower is healed to half, stops combat, and is set protected for the scene if it
; was neither essential nor protected (undone afterwards). While it runs, O'Deadly's own
; encounters wait (OtherBusy) and another downed follower bleeds out normally.
; Rescue = the player hits or activates the attacker, or the attacker dies. Scene ends on its own
; = the player did not get there in time. Either way both actors are released and the attacker
; goes back to the fight. Event-based: bleedout, OnHit / OnDeath, ostim_thread_end, panic.

bool Function RescueGenderOK(Actor a)
	If iRescueGender == 0
		return true
	EndIf
	int sex = a.GetLeveledActorBase().GetSex()
	If iRescueGender == 1
		return sex == 1
	EndIf
	return sex == 0
EndFunction

bool Function IsRescueAlias(ReferenceAlias r)
	return bRescueOn && r == Extra3Alias
EndFunction

; from OnActorBleedout for a downed follower. true = handled here (the full Defeat path is skipped)
bool Function TryFollowerRescue(Actor vic)
	If !Ready() || !bRescue || bRescueOn || bBusy || vic == None || vic == PlayerRef
		return false
	EndIf
	If !IsFollowerActor(vic) || IsMinor(vic) || IsProtected(vic) || vic.IsDead() || OActor.IsInOStim(vic)
		return false
	EndIf
	If (!bGuardVictims && IsGuardActor(vic)) || !RescueGenderOK(vic)
		return false
	EndIf
	If PlayerRef.IsDead() || PlayerRef.IsBleedingOut() || OActor.IsInOStim(PlayerRef)
		return false
	EndIf
	float now = Utility.GetCurrentGameTime()
	If now < fOKRHeldUntil || now < fODefUntil || now < fBakaUntil || (now - fLastRescue) * 24.0 < 1.0
		return false
	EndIf
	If Utility.RandomFloat(0.0, 100.0) >= fRescueChance
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
		If x && !IsFollowerActor(x) && !x.IsBleedingOut() && (x.IsHostileToActor(PlayerRef) || x.IsHostileToActor(vic)) && BaseEligible(x, true) && CreatureAllowed(x) && (bGuardAttackers || !IsGuardActor(x))
			Actor[] a1 = new Actor[1]
			a1[0] = x
			Actor[] v1 = new Actor[1]
			v1[0] = vic
			string s = SceneForSet(a1, 1, v1, 1, true, acts)
			If s != ""
				att = x
				scene = s
			EndIf
		EndIf
		i += 1
	EndWhile
	If att == None
		Log("rescue: no hostile with a scene near " + vic.GetDisplayName())
		return false
	EndIf
	int ep = iEpoch
	bRescueOn = true
	bRescueDone = false
	iRescueThread = -1
	kRescueVic = vic
	kRescueAtt = att
	sRescueWhere = WhereName()
	fLastRescue = now
	; calm only this pair
	fRescueAgg = att.GetActorValue("Aggression")
	att.StopCombat()
	att.StopCombatAlarm()
	bRescueFac = !att.IsInFaction(PlayerFaction)
	If bRescueFac
		att.AddToFaction(PlayerFaction)
	EndIf
	att.SetActorValue("Aggression", 0.0)
	vic.StopCombat()
	vic.RestoreActorValue("Health", vic.GetBaseActorValue("Health") * 0.5)
	bRescueProt = false
	ActorBase vb = vic.GetActorBase()
	If vb && !vb.IsEssential() && !vb.IsProtected() && !vic.IsEssential()
		vb.SetProtected(true)
		bRescueProt = true
	EndIf
	Extra3Alias.ForceRefTo(att)
	Utility.Wait(1.0)      ; one bounded wait: let the follower come out of bleedout
	If !Alive(ep) || !bRescueOn || att.IsDead() || vic.IsDead()
		RescueRelease(true)
		return true
	EndIf
	Actor[] dom = new Actor[1]
	dom[0] = att
	LeaveFurniture(acts)      ; 0.8
	int b = OThreadBuilder.Create(acts)
	If b < 0
		Log("rescue: OThreadBuilder.Create failed")
		RescueRelease(true)
		return false
	EndIf
	OThreadBuilder.SetDominantActors(b, dom)
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
	OThreadBuilder.NoPlayerControl(b)
	OThreadBuilder.SetMetadataCSV(b, "odangerous,aggressive,follower_rescue")
	If !Alive(ep) || !bRescueOn
		OThreadBuilder.Cancel(b)
		RescueRelease(true)
		return true
	EndIf
	int t = OThreadBuilder.Start(b)
	If t < 0
		Log("rescue: thread did not start")
		RescueRelease(true)
		return false
	EndIf
	iRescueThread = t
	If !Alive(ep) || !bRescueOn
		RescueRelease(true)
		return true
	EndIf
	Log("rescue: " + att.GetDisplayName() + " takes " + vic.GetDisplayName() + " at " + sRescueWhere + ", thread " + t + ", scene " + scene)
	If bSkyrimNetStart && SNetOK()
		SkyrimNetApi.DirectNarration(vic.GetDisplayName() + " has fallen near " + sRescueWhere + ", and " + att.GetDisplayName() + " is taking them right there while the fight goes on.", att, vic)
	EndIf
	return true
EndFunction

; how: 1 = player hit / pulled the attacker away, 2 = attacker died, 0 = the scene ended on its own
Function RescueOutcome(int how)
	If !bRescueOn || bRescueDone
		return
	EndIf
	bRescueDone = true
	Actor att = kRescueAtt
	Actor vic = kRescueVic
	string w = sRescueWhere
	RescueRelease(true)
	If !bMaster || !SNetOK() || att == None || vic == None
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	string vn = vic.GetDisplayName()
	string an = att.GetDisplayName()
	string n
	string m
	If how == 1
		n = pn + " pulls " + vn + " away from " + an + "."
		m = pn + " pulled " + vn + " away from " + an + ", who had started forcing themselves on " + vn + " in the middle of a fight near " + w + "."
	ElseIf how == 2
		n = an + " falls, and " + vn + " is free."
		m = an + " was killed in the middle of a fight near " + w + " while forcing themselves on " + vn + ", and " + vn + " got away."
	Else
		n = an + " leaves " + vn + " on the ground and turns back to the fight."
		m = an + " forced themselves on " + vn + " in the middle of a fight near " + w + ", and " + pn + " did not get there in time."
	EndIf
	If bSkyrimNetStart
		SkyrimNetApi.DirectNarration(n, att, vic)
	EndIf
	If bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(m, att, vic)
	EndIf
EndFunction

; stop the side scene and give both actors back (also used by panic, master off and game load)
Function RescueRelease(bool fight)
	int t = iRescueThread
	iRescueThread = -1
	Actor att = kRescueAtt
	Actor vic = kRescueVic
	kRescueAtt = None
	kRescueVic = None
	bRescueOn = false
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)       ; OStim redresses the actors it undressed
	EndIf
	If att && Extra3Alias.GetReference() == att
		Extra3Alias.Clear()
	EndIf
	If att
		If bRescueFac
			att.RemoveFromFaction(PlayerFaction)
		EndIf
		If !att.IsDead()
			att.SetActorValue("Aggression", fRescueAgg)
			att.EvaluatePackage()
			If fight && bMaster && att.IsHostileToActor(PlayerRef)
				att.StartCombat(PlayerRef)
			EndIf
		EndIf
	EndIf
	bRescueFac = false
	If vic
		If bRescueProt && vic.GetActorBase()
			vic.GetActorBase().SetProtected(false)
		EndIf
		If !vic.IsDead()
			vic.RestoreActorValue("Health", vic.GetBaseActorValue("Health") * 0.5)
			vic.EvaluatePackage()
		EndIf
	EndIf
	bRescueProt = false
EndFunction

; ======================= protect list helper (MCM) =======================
bool Function ToggleProtected(Actor a)
	If a == None
		return false
	EndIf
	InitArrays()
	Form f = a.GetActorBase()
	If !ProtectedForms
		return false
	EndIf
	int i = ProtectedForms.Find(f)
	If i >= 0
		ProtectedForms[i] = None
		return false
	EndIf
	i = ProtectedForms.Find(None)
	If i >= 0
		ProtectedForms[i] = f
		return true
	EndIf
	return false
EndFunction
