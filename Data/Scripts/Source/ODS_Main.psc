Scriptname ODS_Main extends Quest
{O'Deadly Skyrim (A SkyrimNet environmental mod) v1.2.0 - by That Guy (Coronerra). One dangerous-world engine for OStim + SkyrimNet. Inspired by ODangerousNights (no ODN files used). Adults only: children are refused for every role.}

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
FormList Property ODS_PoolTraveler Auto     ; 0.9: Savior Complex travelers / merchants (vanilla)
FormList Property ODS_PoolVigilant Auto     ; 0.9: generic Vigilants of Stendarr (vanilla, never unique)
Message Property ODS_SaviorChoice Auto      ; 0.9: Watch / Join in / Rescue

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
int Property K_SAVIOR = 16 AutoReadOnly    ; 0.9 Savior Complex: bandit forcefully taking a traveler
int Property K_BUNNYFIGHT = 17 AutoReadOnly ; 0.9 Killer Rabbit vs Vigilants of Stendarr
int Property K_CRWILD = 18 AutoReadOnly     ; 1.0 OCreatures: a creature takes a traveler / companion / the player on the road
int Property K_WEREWOLF = 19 AutoReadOnly   ; 1.0 OStim Beast Form: a werewolf in full beast form at night in the wilderness
int Property K_BEASTPREY = 20 AutoReadOnly  ; 1.0 OStim Beast Form: the player in beast form takes a beaten bandit
int Property K_BEASTCLAIM = 21 AutoReadOnly ; 1.0 OStim Beast Form: the player in beast form claims a willing spouse / companion
int Property K_COUNT = 22 AutoReadOnly
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

; 0.9 roadside events (own toggles, OFF by default; not part of Travel & roads)
bool Property bSavior = false Auto Hidden
float Property fSaviorChance = 2.0 Auto Hidden      ; % per game hour / wait hour on a wilderness road
bool Property bBunnyFight = false Auto Hidden
float Property fBunnyFightChance = 2.0 Auto Hidden  ; % per game hour / wait hour; needs mihailkillerbunny.esp

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
; 0.9 roadside events
int iSaviorChoice = 0            ; 0 none, 1 watch, 2 join, 3 rescue
bool bSaviorJoining = false      ; suppress Aftermath while a join/rescue stops the first thread
bool bRoadFight = false          ; savior rescue combat, or bunny vs Vigilants, still running
Actor kBunny
Actor kVigilant1
Actor kVigilant2
int iRoadTicks = 0

string Property MODNAME = "O'Deadly Skyrim" AutoReadOnly

; ======================= lifecycle =======================
Event OnInit()
	LogSessionStart()    ; 1.1.2: own log file, new session header
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
	If iBloodGiftKey > 0 && iBloodGiftKey != iPanicKey
		RegisterForKey(iBloodGiftKey)       ; 1.1
	EndIf
EndFunction

; called by ODS_PlayerAlias.OnPlayerLoadGame
Function OnGameLoaded()
	LogSessionStart()    ; 1.1.2: own log file, new session header (before anything logs)
	ODS_Text.Reload()    ; 1.2.0: narration.json is read again after each load (edits apply without a recompile)
	InitArrays()
	Register()
	HeatOnLoad()         ; 1.0
	PathoInitArrays()    ; 1.0 Blood Born Pathogen
	PathoOnLoad()
	PathoSkinOnLoad()    ; 1.1.3: skin swaps are not saved by the game, put them back
	VLFOnLoad()          ; 1.1.5: vampire followers as vampire lords (skin again, SkyrimNet marks)
	LoreBeastsSync()     ; 1.1.8: Serana / Companions transform data when Beast Form is present
	SatOnLoad()          ; 1.0 Saturalia
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
	If bOCreatures && (bCrEnabled || bCrWild) && bMaster
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
	LogFileLine(s)      ; 1.1.2: PapyrusUtil only when present, line cap per session
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
	ElseIf keyCode == iBloodGiftKey && iBloodGiftKey > 0
		BloodGiftKey()          ; 1.1 Blood Born Pathogen
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
	If bOCreatures && (bCrEnabled || bCrWild)
		DetectCreatures()
	EndIf
	ResolveSoft()
	RefreshTimers(PlayerRef.GetCurrentLocation())
	PathoSyncGlobals()   ; 1.1
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
	Log("panic key / master OFF: everything stopped")
EndFunction

Function AbortAll()
	RescueRelease(false)
	HeatAbort()          ; 1.0
	SatSendHome()        ; 1.0 Saturalia: Agrane goes back to his camp
	PathoRevertAll()     ; 1.0: nobody stays in beast form
	PathoSyncGlobals()   ; 1.1
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
	kBeastTarget = None
	ClearRoadEvent(false)
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
	iJoinChoice = 0
	kJoinOther = None
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
	Log("ODangerous Nights: night attack seen, O'Deadly events wait half a day")
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

; 1.2.0: last check over every actor of a scene, right before OStim starts it. None entries are
; skipped (an empty slot is not an actor). true = at least one is a minor: the caller must not start.
bool Function SceneHasMinor(Actor[] a1, Actor[] a2, string site)
	int i = 0
	If a1
		While i < a1.Length
			If a1[i] && IsMinor(a1[i])
				Log("final child check (" + site + "): " + NameOf(a1[i]) + " is a minor - scene not started")
				return true
			EndIf
			i += 1
		EndWhile
	EndIf
	i = 0
	If a2
		While i < a2.Length
			If a2[i] && IsMinor(a2[i])
				Log("final child check (" + site + "): " + NameOf(a2[i]) + " is a minor - scene not started")
				return true
			EndIf
			i += 1
		EndWhile
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
	float[] ch = new float[22]
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
	If !isSleep && cat == 5 && IsOutdoors()
		If bTravelEnabled
			ch[K_ROAD] = fRoadWaitChance
		EndIf
		If bSavior && RoadEventPlaceOK()
			ch[K_SAVIOR] = fSaviorChance
		EndIf
		If bBunnyFight && KillerBunnyOK() && RoadEventPlaceOK()
			ch[K_BUNNYFIGHT] = fBunnyFightChance
		EndIf
		If bWolfNight && WolfNightOK() && RoadEventPlaceOK()
			ch[K_WEREWOLF] = fWolfNightChance
		EndIf
		If bCrWild && AnyCrWildOK() && RoadEventPlaceOK()
			ch[K_CRWILD] = fCrWildChance
		EndIf
	EndIf
	; priority order
	int[] order = new int[17]
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
	order[11] = K_SAVIOR
	order[12] = K_BUNNYFIGHT
	order[13] = K_WEREWOLF
	order[14] = K_CRWILD
	order[15] = K_ROAD
	order[16] = 0
	int h = 1
	While h <= hours
		int k = 0
		While k < 16
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
	Log("event: " + KindName(kind) + " - staging")
	bool ok = Dispatch(kind, ep)
	If ok
		Log("event: " + KindName(kind) + " started")
	Else
		Log("event: " + KindName(kind) + " skipped (no cast or no installed scene; the line above says why)")
	EndIf
	If ok && Alive(ep)
		MaybeOfferJoin(ep)      ; 1.0: consensual scenes only, off by default
	EndIf
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
	ElseIf kind == K_SAVIOR
		return StageSavior(ep)
	ElseIf kind == K_BUNNYFIGHT
		return StageBunnyFight(ep)
	ElseIf kind == K_CRWILD || kind == K_WEREWOLF
		return StageWild(kind, ep)
	ElseIf kind == K_BEASTPREY
		return StageBeastPrey(ep)
	ElseIf kind == K_BEASTCLAIM
		return StageBeastClaim(ep)
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
		Log("defeat: " + a.GetDisplayName() + " down, skipped (busy, in a scene or cooldown)")
		DefeatFailed(a)
		return
	EndIf
	If !forced && Utility.RandomFloat(0.0, 100.0) >= fDefeatChance
		Log("defeat: " + a.GetDisplayName() + " down, chance roll missed (" + fDefeatChance + "%)")
		DefeatFailed(a)
		return
	EndIf
	If forced
		iForceMode = 0
	EndIf
	Log("defeat: " + a.GetDisplayName() + " down, defeat scene")
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
	If SceneHasMinor(acts, dom, "StartThread")
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
		If kAtt[i] == PlayerRef
			; 1.0 beast form: the player leads the scene; nothing to calm
		ElseIf forced || IsSpawned(kAtt[i]) || (kAtt[i].IsHostileToActor(PlayerRef))
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
	string fb = "{an} and {vn} near {where}."
	If iKind == K_CHEAT
		return ODS_Text.T("start.cheat", "{x1} and {x2} near {where}.", pn, an, vn, where, kVictim.GetDisplayName(), kAttacker.GetDisplayName())
	ElseIf iKind == K_JAIL
		return ODS_Text.T("start.jail", fb, pn, an, vn, where)
	ElseIf iKind == K_INN
		return ODS_Text.T("start.inn", fb, pn, an, vn, where)
	ElseIf iKind == K_SPIKED
		return ODS_Text.T("start.spiked", fb, pn, an, vn, where)
	ElseIf iKind == K_DEFEAT
		return ODS_Text.T("start.defeat", fb, pn, an, vn, where)
	ElseIf iKind == K_TRESPASS
		return ODS_Text.T("start.trespass", fb, pn, an, vn, where)
	ElseIf iKind == K_ROAD
		return ODS_Text.T("start.road", fb, pn, an, vn, where)
	ElseIf iKind == K_CREATURE
		return ODS_Text.T("start.creature", fb, pn, an, vn, where)
	ElseIf iKind == K_BETRAYAL
		return ODS_Text.T("start.betrayal", "{pn} and {x1} near {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
	ElseIf iKind == K_VAMPIRE
		return ODS_Text.T("start.vampire", "{x1} and {vn} near {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
	ElseIf iKind == K_MORNING
		return ODS_Text.T("start.morning", "{pn} and {x1} near {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
	ElseIf iKind == K_BATH
		If bForcedScene
			return ODS_Text.T("start.bath_forced", fb, pn, an, vn, where)
		EndIf
		return ODS_Text.T("start.bath_shared", "{x1} and {x2} near {where}.", pn, an, vn, where, kAttacker.GetDisplayName(), kVictim.GetDisplayName())
	ElseIf iKind == K_INNSHARE
		return ODS_Text.T("start.innshare", "{x1} and {x2} near {where}.", pn, an, vn, where, kAttacker.GetDisplayName(), kVictim.GetDisplayName())
	ElseIf iKind == K_SAVIOR
		return ODS_Text.T("start.savior", fb, pn, an, vn, where)
	ElseIf iKind == K_BUNNYFIGHT
		return ODS_Text.T("start.bunnyfight", "Something happens on the road near {where}.", pn, an, vn, where)
	ElseIf iKind == K_CRWILD
		return ODS_Text.T("start.crwild", "{x1} and {x2} near {where}.", pn, an, vn, where, WildBeastName(), WildVictimText())
	ElseIf iKind == K_WEREWOLF
		return ODS_Text.T("start.werewolf", "A werewolf and {x1} near {where}.", pn, an, vn, where, WildVictimText())
	ElseIf iKind == K_BEASTPREY
		return ODS_Text.T("start.beastprey", "{pn} and {x2} near {where}.", pn, an, vn, where, BeastWord(PlayerRef), kVictim.GetDisplayName())
	ElseIf iKind == K_BEASTCLAIM
		return ODS_Text.T("start.beastclaim", "{pn} and {x3} near {where}.", pn, an, vn, where, BeastWord(PlayerRef), BondText(kVictim), kVictim.GetDisplayName())
	ElseIf iKind == K_DARKGIFT
		If bForcedScene
			return ODS_Text.T("start.darkgift_forced", "{pn} and {x1} at {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
		EndIf
		return ODS_Text.T("start.darkgift", "{pn} and {x1} at {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
	EndIf
	If kVictim == PlayerRef
		return ODS_Text.T("start.sleep_victim", "{an} and {pn}.", pn, an, vn, where)
	EndIf
	return ODS_Text.T("start.camp_attack", "{an} and {vn} near {where}.", pn, an, vn, where)
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
		t += " " + ODS_Text.T("start.jail_zaz", "{pn} watches.", PlayerRef.GetDisplayName())
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
	string fb = "{an} and {vn}."
	If iKind == K_CHEAT
		ShowMsg(ODS_Text.T("wake.cheat", "{x1} and {x2}.", "", an, vn, "", kVictim.GetDisplayName(), kAttacker.GetDisplayName()))
	ElseIf iKind == K_JAIL
		ShowMsg(ODS_Text.T("wake.jail", fb, "", an, vn))
	ElseIf iKind == K_INN
		ShowMsg(ODS_Text.T("wake.inn", fb, "", an, vn))
	ElseIf iKind == K_SPIKED
		ShowMsg(ODS_Text.T("wake.spiked", fb, "", an, vn))
	ElseIf iKind == K_DEFEAT
		ShowMsg(ODS_Text.T("wake.defeat", fb, "", an, vn))
	ElseIf iKind == K_TRESPASS
		ShowMsg(ODS_Text.T("wake.trespass", "{x1}.", "", an, vn, "", kAttacker.GetDisplayName()))
	ElseIf iKind == K_ROAD
		ShowMsg(ODS_Text.T("wake.road", fb, "", an, vn))
	ElseIf iKind == K_CREATURE
		ShowMsg(ODS_Text.T("wake.creature", fb, "", an, vn))
	ElseIf iKind == K_BETRAYAL
		ShowMsg(ODS_Text.T("wake.betrayal", "{x1}.", "", an, vn, "", kAttacker.GetDisplayName()))
	ElseIf iKind == K_VAMPIRE
		ShowMsg(ODS_Text.T("wake.vampire", "{x1} and {vn}.", "", an, vn, "", kAttacker.GetDisplayName()))
		shake = false
	ElseIf iKind == K_MORNING
		ShowMsg(ODS_Text.T("wake.morning", "{x1}.", "", an, vn, "", kAttacker.GetDisplayName()))
		shake = false
	ElseIf iKind == K_BATH
		ShowMsg(ODS_Text.T("wake.bath", fb, "", an, vn))
	ElseIf iKind == K_INNSHARE
		ShowMsg(ODS_Text.T("wake.innshare", "{x1} and {x2}.", "", an, vn, "", kAttacker.GetDisplayName(), kVictim.GetDisplayName()))
		shake = false
	ElseIf iKind == K_SAVIOR
		ShowMsg(ODS_Text.T("wake.savior", fb, "", an, vn))
	ElseIf iKind == K_BUNNYFIGHT
		ShowMsg(ODS_Text.T("wake.bunnyfight", "Something is happening on the road.", "", an, vn))
	ElseIf iKind == K_CRWILD || iKind == K_WEREWOLF
		ShowMsg(ODS_Text.T("wake.wild", "{x1} and {vn}.", "", an, vn, "", kAttacker.GetDisplayName()))
	ElseIf iKind == K_BEASTPREY
		ShowMsg(ODS_Text.T("wake.beastprey", "The beast acts.", "", an, vn))
	ElseIf iKind == K_BEASTCLAIM
		ShowMsg(ODS_Text.T("wake.beastclaim", "{x1}.", "", an, vn, "", kVictim.GetDisplayName()))
		shake = false
	ElseIf iKind == K_DARKGIFT
		ShowMsg(ODS_Text.T("wake.darkgift", "{x1}.", "", an, vn, "", kAttacker.GetDisplayName()))
	ElseIf kVictim == PlayerRef
		ShowMsg(ODS_Text.T("wake.sleep_victim", fb, "", an, vn))
	Else
		ShowMsg(ODS_Text.T("wake.camp", fb, "", an, vn))
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
	If kAttacker == PlayerRef || iJoinChoice >= 2
		return      ; 1.0: the player is in the scene (beast form / joined); OStim ends it
	EndIf
	; 0.9: activating / hitting during Savior Complex (watch) is a rescue
	If IsWitnessKind(iKind) && iSaviorChoice == 1
		SaviorRescue(iEpoch)
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
	PathoSceneEnd(numArg as int)       ; 1.0 Blood Born Pathogen (off by default)
	If fODefUntil > 0.0
		ODefSceneEnded(strArgs)
	EndIf
	int id = numArg as int
	If id >= 0 && id == iHeatThread
		If HeatTurnNext(id)
			return             ; 1.1.5: the next beast takes his turn (our own encounter carries on in it)
		EndIf
		HeatSceneEnded()       ; 1.0: the beasts walk off (our own encounter still ends below)
	EndIf
	If bSaviorJoining
		return
	EndIf
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
	PathoSceneStart(numArg as int)     ; 1.0 Blood Born Pathogen (off by default)
	If bRescueOn
		return       ; mid-battle: no walk-ins or distant watchers on top of a rescue
	EndIf
	int id = numArg as int
	If bHeatOn || id == iHeatThread
		return       ; 1.0: the heat scene itself
	EndIf
	CaughtCheck(id)
	WatchCheck(id)
	HeatCheck(id)      ; 1.0 Bitch in Heat (off by default)
EndEvent

Function CaughtCheck(int id)
	If !Ready() || !bCaught || id < 0 || id == iThread || id == iThread2
		return
	EndIf
	If (Utility.GetCurrentGameTime() - fLastCaught) < 1.0
		return
	EndIf
	If bBusy && iJoinChoice >= 2
		return       ; 1.0: the player just joined our own scene
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
		SkyrimNetApi.DirectNarration(ODS_Text.T("caught.narration", "{x2} and {pn}, caught by {x1}.", pn, "", "", "", rel + catcher.GetDisplayName(), partner.GetDisplayName()), catcher, PlayerRef)
	EndIf
	If SNetOK() && bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(ODS_Text.T("caught.memory", "{x1} caught {pn} with {x2} at {where}.", pn, "", "", WhereName(), catcher.GetDisplayName(), partner.GetDisplayName()), catcher, PlayerRef)
	EndIf
	HeatNote(ODS_Text.T("caught.note", "{x1} has seen you.", "", "", "", "", catcher.GetDisplayName()))     ; 1.1.7: OStim scene start: corner notification only, never a box
	Log("caught: " + NameOf(catcher) + " has seen you (notification, no box)")
EndFunction

; ======================= aftermath =======================
Function RestoreAttackers(bool afterScene)
	int i = 0
	While i < 4
		Actor a = kAtt[i]
		If a && a != PlayerRef && !a.IsDead()
			If bAddedFac[i]
				a.RemoveFromFaction(PlayerFaction)
				bAddedFac[i] = false
			EndIf
			If bForcedScene
				If !afterScene
					a.SetActorValue("Aggression", fOldAgg[i])
				ElseIf IsSpawned(a)
					If IsWitnessKind(iKind) && iSaviorChoice != 3
						a.SetActorValue("Aggression", 0.0)
						a.SetActorValue("Confidence", 0.0)
					ElseIf bIntervened
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
	If IsWitnessKind(iKind) && iSaviorChoice == 3
		return
	EndIf
	string pn = PlayerRef.GetDisplayName()
	string an = AttackerNames()
	string vn = Names2(kVictim, kVictim2)
	string where = WhereName()
	string txt
	If iKind == K_CHEAT
		txt = ODS_Text.T("log.cheat", "{x1} and {x2}", pn, an, vn, where, kVictim.GetDisplayName(), kAttacker.GetDisplayName())
		If iJoinChoice >= 2
			txt += "." + JoinMemoryText()
		ElseIf bIntervened
			txt += " " + ODS_Text.T("log.cheat_interrupted", "and it was interrupted.", pn, an, vn, where)
		Else
			txt += "."
		EndIf
	ElseIf iKind == K_VAMPIRE
		txt = ODS_Text.T("log.vampire", "{x1} and {vn} at {where}.", pn, an, vn, where, kAttacker.GetDisplayName())
	ElseIf iKind == K_ATTACK && kVictim != PlayerRef
		txt = ODS_Text.T("log.attack_camp", "{an} and {vn} near the camp.", pn, an, vn, where)
		If bIntervened
			txt += " " + ODS_Text.T("log.attack_camp_stopped", "{pn} intervened.", pn, an, vn, where)
		Else
			txt += " " + ODS_Text.T("log.attack_camp_watched", "{pn} did not intervene.", pn, an, vn, where)
		EndIf
	ElseIf iKind == K_ATTACK
		txt = ODS_Text.T("log.attack_victim", "{an} and {pn} at night.", pn, an, vn, where)
	ElseIf iKind == K_SAVIOR
		If iSaviorChoice == 2
			txt = ODS_Text.T("log.savior_join", "{pn} joined {an} and {vn} near {where}.", pn, an, vn, where)
		Else
			txt = ODS_Text.T("log.savior_watch", "{pn} watched {an} and {vn} near {where}.", pn, an, vn, where)
		EndIf
	ElseIf (iKind == K_CRWILD || iKind == K_WEREWOLF) && kVictim != PlayerRef
		txt = StartText()
		If iSaviorChoice == 1
			txt += " " + ODS_Text.T("log.wild_watch", "{pn} watched.", pn, an, vn, where)
		EndIf
	Else
		txt = StartText()
		If iJoinChoice >= 2
			txt += JoinMemoryText()
		ElseIf bIntervened
			txt += " " + ODS_Text.T("log.stepped_in", "{pn} stepped in.", pn, an, vn, where)
		EndIf
	EndIf
	txt += MessyText()
	SkyrimNetApi.RegisterPersistentEvent(txt, kAttacker, kVictim)
	Log("SkyrimNet: memory saved for " + KindName(iKind))
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
	If !bBlackmail || iKind == K_CREATURE || iKind == K_CRWILD || iKind == K_WEREWOLF || iKind == K_BEASTPREY || iKind == K_BEASTCLAIM || kAttacker == None || IsSpawned(kAttacker) || !IsHumanoid(kAttacker)
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
	If bRoadFight
		WatchRoadFight()
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
	ClearRoadEvent(true)
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
	VLFScan()            ; 1.1.5
	RefreshTimers(akNew)
	CheckBlackmail()
EndFunction

bool Function TravelWanted()
	If !IsOutdoors() || GetLocCategory() != 5
		return false
	EndIf
	If bTravelEnabled || (AnyCreatureOK() && fCrRoamChance > 0.0)
		return true
	EndIf
	If bSavior || (bBunnyFight && KillerBunnyOK())
		return true
	EndIf
	If (bCrWild && AnyCrWildOK()) || (bWolfNight && BFScenesOK())
		return true
	EndIf
	return false
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
	If SatWanted()          ; 1.0 Saturalia rides the same timer
		If fSatDue < 0.0
			fSatDue = now + 0.05 / 24.0
		EndIf
	ElseIf !bSatAway
		fSatDue = -1.0
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
	If fSatDue > 0.0 && (due < 0.0 || fSatDue < due)       ; 1.0 Saturalia
		due = fSatDue
	EndIf
	float pd = PathoNextDue()                               ; 1.0 Blood Born Pathogen incubation
	If pd > 0.0 && (due < 0.0 || pd < due)
		due = pd
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
		If bMaster
			; 1.0.2: keep the timer alive (it used to be dropped here). Pathogen stages do not need OStim.
			float pdue = PathoNextDue()
			If pdue > 0.0 && Utility.GetCurrentGameTime() >= pdue
				PathoTick()
			EndIf
			UnregisterForUpdateGameTime()
			RegisterForSingleUpdateGameTime(1.0)     ; OStim not ready: try again in a game hour, then ScheduleGameTime() as usual
		EndIf
		return
	EndIf
	float now = Utility.GetCurrentGameTime()
	int kind = 0
	If fSatDue > 0.0 && now >= fSatDue          ; 1.0 Saturalia
		SatTick()
	EndIf
	float pd = PathoNextDue()                   ; 1.0 Blood Born Pathogen
	If pd > 0.0 && now >= pd
		PathoTick()
	EndIf
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
				If iForceMode == K_SAVIOR || iForceMode == K_BUNNYFIGHT || iForceMode == K_ROAD || iForceMode == K_CREATURE || iForceMode == K_CRWILD || iForceMode == K_WEREWOLF
					kind = iForceMode
					iForceMode = 0
				ElseIf bSavior && RoadEventPlaceOK() && Utility.RandomFloat(0.0, 100.0) < fSaviorChance
					kind = K_SAVIOR
				ElseIf bBunnyFight && KillerBunnyOK() && RoadEventPlaceOK() && Utility.RandomFloat(0.0, 100.0) < fBunnyFightChance
					kind = K_BUNNYFIGHT
				ElseIf bWolfNight && WolfNightOK() && Utility.RandomFloat(0.0, 100.0) < fWolfNightChance && RoadEventPlaceOK()
					kind = K_WEREWOLF
				ElseIf bCrWild && AnyCrWildOK() && Utility.RandomFloat(0.0, 100.0) < fCrWildChance && RoadEventPlaceOK()
					kind = K_CRWILD
				ElseIf bTravelEnabled && Utility.RandomFloat(0.0, 100.0) < fRoadChance
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
	bool pinc = bMaster && PathoPlayerIncubating()      ; 1.1: a Cure Disease potion stops your incubation
	bool playerOn = (bathOn && bBathPlayer) || (bathOn && bBathFollowers) || (bMaster && bMorningAfter) || pinc
	ODS_PlayerAlias pa = GetAlias(0) as ODS_PlayerAlias
	If pa
		pa.SetWatch(playerOn, bathOn, (bMaster && bMorningAfter) || pinc, kBathFx)
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
	If PathoPlayerDrank(f)      ; 1.1
		return
	EndIf
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
	string sit = ODS_Text.T("bath.sit", "{vn} is bathing near {where}.", "", "", vic.GetDisplayName(), WhereName())
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
	string how = ODS_Text.T("watch.how_willing", "a scene")
	If IsAggroScene(sc)
		how = ODS_Text.T("watch.how_rough", "a rough scene")
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
	string wn = w.GetDisplayName()
	string act = ODS_Text.T("watch.act_leave", "{pn} leaves.", wn)
	If r == 1
		act = ODS_Text.T("watch.act_call", "{pn} calls out.", wn)
	ElseIf r == 2
		act = ODS_Text.T("watch.act_closer", "{pn} comes closer.", wn)
	EndIf
	string txt = ODS_Text.T("watch.narration", "{pn}, {vn}, sees {an} near {where}, {x1} metres to the {x2}: {x3}.", wn, who, role, WhereName(), metres, Compass(dx, dy), how) + " " + act
	Actor tgt = acts[0]
	If acts.Find(PlayerRef) >= 0
		tgt = PlayerRef
	EndIf
	Log("watched: " + txt)
	If SNetOK() && bSkyrimNetStart
		SkyrimNetApi.DirectNarration(txt, w, tgt)
	Else
		HeatNote(ODS_Text.T("watch.note", "Someone is watching from a distance."))     ; 1.1.7: OStim scene start: never a box
		Log("watched: someone is watching from a distance (notification, no box)")
	EndIf
	If SNetOK() && bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(ODS_Text.T("watch.memory", "{pn} saw {an} near {where}.", w.GetDisplayName(), who, "", WhereName()), w, tgt)
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

; ======================= 0.9: roadside events (Savior Complex, Killer Rabbit vs Vigilants) =======================
; Wilderness roads only. Never interiors, cities/towns, or near unique essential/protected NPCs.
; Spawned copies only (never world / quest NPCs). No ActorBase.SetEssential. Panic clears everything.

bool Function RoadEventPlaceOK()
	If !IsOutdoors()
		return false
	EndIf
	If GetLocCategory() != 5
		return false
	EndIf
	Location loc = PlayerRef.GetCurrentLocation()
	If TreeHasKW(loc, "LocTypeCity") || TreeHasKW(loc, "LocTypeTown")
		return false
	EndIf
	return !QuestNPCNearby()
EndFunction

bool Function QuestNPCNearby()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 4000.0, false, false, false)
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && a != PlayerRef && !a.IsDead() && !a.IsDisabled() && !IsFollowerActor(a) && !IsSpawned(a)
			ActorBase b = a.GetActorBase()
			If b && b.IsUnique() && (a.IsEssential() || b.IsEssential() || b.IsProtected())
				Log("road event skipped: quest NPC " + a.GetDisplayName() + " nearby")
				return true
			EndIf
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

Function WakeUnconscious(Actor a)
	If a && !a.IsDead()
		a.SetUnconscious(false)
	EndIf
EndFunction

Function ClearRoadEvent(bool deleteSpawns)
	bRoadFight = false
	bSaviorJoining = false
	iSaviorChoice = 0
	iRoadTicks = 0
	WakeUnconscious(kVigilant1)
	WakeUnconscious(kVigilant2)
	WakeUnconscious(kVictim)
	kBunny = None
	kVigilant1 = None
	kVigilant2 = None
	If deleteSpawns
		DeleteAllSpawned()
	EndIf
EndFunction

Function TalkNet(string t, Actor a, Actor b, bool narrate, bool remember)
	If !SNetOK()
		return
	EndIf
	If narrate && bSkyrimNetStart
		SkyrimNetApi.DirectNarration(t, a, b)
	EndIf
	If remember && bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(t, a, b)
	EndIf
EndFunction

Function FinishRoadEvent()
	bRoadFight = false
	iSaviorChoice = 0
	iRoadTicks = 0
	WakeUnconscious(kVigilant1)
	WakeUnconscious(kVigilant2)
	kBunny = None
	kVigilant1 = None
	kVigilant2 = None
	iCleanupTicks = 0
	bAftermathDone = true
	RegisterForSingleUpdate(5.0)
EndFunction

Actor Function SpawnFromPool(FormList pool, Actor anchor, int tries)
	If pool == None || pool.GetSize() == 0 || anchor == None
		return None
	EndIf
	int n = 0
	While n < tries
		Form base = pool.GetAt(Utility.RandomInt(0, pool.GetSize() - 1))
		Actor a = SpawnNear(base, anchor)
		If a
			If !IsMinor(a) && IsHumanoid(a)
				a.Enable()
				return a
			EndIf
			DeleteSpawn(a)
		EndIf
		n += 1
	EndWhile
	return None
EndFunction

; debug: start it now if the player is already on a wilderness road; otherwise queues for the next travel hour / wait
bool Function TryForceRoadEvent(int kind)
	If !Ready()
		return false
	EndIf
	If kind == K_BUNNYFIGHT && !KillerBunnyOK()
		return false
	EndIf
	If (kind == K_CRWILD && !AnyCrWildOK()) || (kind == K_WEREWOLF && !BFScenesOK())
		return false
	EndIf
	If bBusy || OtherBusy(false)
		iForceMode = kind
		return false
	EndIf
	If !RoadEventPlaceOK()
		iForceMode = kind
		return false
	EndIf
	iForceMode = 0
	bBusy = true
	StageWithFade(kind, iEpoch, false)
	return true
EndFunction

bool Function StageSavior(int ep)
	If !RoadEventPlaceOK() || !Alive(ep)
		return false
	EndIf
	If ODS_PoolTraveler == None || ODS_PoolTraveler.GetSize() == 0 || ODS_PoolBandit == None || ODS_PoolBandit.GetSize() == 0
		Log("savior: missing traveler or bandit pool")
		return false
	EndIf
	Actor vic = None
	int t = 0
	While t < 6 && vic == None
		Actor c = SpawnFromPool(ODS_PoolTraveler, PlayerRef, 1)
		If c
			If GenderOK(c) && !IsMinor(c)
				vic = c
			Else
				DeleteSpawn(c)
			EndIf
		EndIf
		t += 1
	EndWhile
	If vic == None || !Alive(ep)
		If vic
			DeleteSpawn(vic)
		EndIf
		Log("savior: no adult traveler")
		return false
	EndIf
	Actor bandit = SpawnFromPool(ODS_PoolBandit, vic, 4)
	If bandit == None || IsMinor(bandit) || !Alive(ep)
		DeleteSpawn(vic)
		If bandit
			DeleteSpawn(bandit)
		EndIf
		Log("savior: no bandit")
		return false
	EndIf
	If PairScene(bandit, vic, true) == ""
		DeleteSpawn(vic)
		DeleteSpawn(bandit)
		Log("savior: no OStim scene for the pair")
		return false
	EndIf
	bandit.Enable()
	vic.Enable()
	AddAttacker(bandit)
	AddVictim(vic)
	iSaviorChoice = 0
	If !StartEncounter(true, "odangerous,aggressive,savior", ep)
		Log("savior: StartEncounter failed")
		DeleteAllSpawned()
		return false
	EndIf
	If !Alive(ep)
		return true
	EndIf
	int choice = 0
	If ODS_SaviorChoice
		choice = ODS_SaviorChoice.Show()
	EndIf
	If !Alive(ep)
		return true
	EndIf
	SaviorChosen(choice, ep)
	return true
EndFunction

Function SaviorChosen(int choice, int ep)
	string pn = PlayerRef.GetDisplayName()
	string an = AttackerNames()
	string vn = Names2(kVictim, kVictim2)
	string where = WhereName()
	If choice == 1
		iSaviorChoice = 2
		TalkNet(ODS_Text.T("savior.join", "{pn} joins {an} and {vn} near {where}.", pn, an, vn, where), kAttacker, kVictim, true, true)
		ShowMsg(ODS_Text.T("savior.join_msg", "You join in."))
		SaviorJoin(ep)
	ElseIf choice == 2
		TalkNet(ODS_Text.T("savior.rescue", "{pn} steps in for {vn} near {where}.", pn, an, vn, where), kAttacker, kVictim, true, true)
		SaviorRescue(ep)
	Else
		iSaviorChoice = 1
		TalkNet(ODS_Text.T("savior.watch", "{pn} watches {an} and {vn} near {where}.", pn, an, vn, where), kAttacker, kVictim, true, true)
		ShowMsg(ODS_Text.T("savior.watch_msg", "You stand and watch."))
	EndIf
EndFunction

Function SaviorJoin(int ep)
	If !Alive(ep) || kAttacker == None || kVictim == None
		return
	EndIf
	bSaviorJoining = true
	int t = iThread
	iThread = -1
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)
	EndIf
	Utility.Wait(0.6)
	bSaviorJoining = false
	If !Alive(ep)
		return
	EndIf
	Actor[] att = new Actor[2]
	att[0] = kAttacker
	att[1] = PlayerRef
	Actor[] vic = new Actor[1]
	vic[0] = kVictim
	Actor[] outA = new Actor[3]
	string sc = SceneForSet(att, 2, vic, 1, true, outA)
	If sc == "" || IsMinor(kVictim) || IsMinor(kAttacker)
		ShowMsg("There is no room for a third. You stay and watch.")
		iSaviorChoice = 1
		TalkNet(PlayerRef.GetDisplayName() + " tried to join the assault on " + kVictim.GetDisplayName() + " but could not, and stood and watched instead.", kAttacker, kVictim, true, true)
		bAftermathDone = false
		RegisterForSingleUpdate(10.0)
		return
	EndIf
	sScene1 = sc
	kSceneActs = outA
	Actor[] dom = new Actor[2]
	dom[0] = kAttacker
	dom[1] = PlayerRef
	iThread = StartThread(outA, dom, sc, "odangerous,aggressive,savior,joined", ep)
	If iThread < 0
		ShowMsg("You stay and watch...")
		iSaviorChoice = 1
		bAftermathDone = false
		RegisterForSingleUpdate(10.0)
		return
	EndIf
	bAftermathDone = false
	iCleanupTicks = 0
	RegisterForSingleUpdate(10.0)
EndFunction

Function SaviorRescue(int ep)
	If !bMaster
		return
	EndIf
	bSaviorJoining = true
	bIntervened = true
	iSaviorChoice = 3
	int t = iThread
	int t2 = iThread2
	iThread = -1
	iThread2 = -1
	If t2 >= 0 && OThread.IsRunning(t2)
		OThread.Stop(t2)
	EndIf
	If t >= 0 && OThread.IsRunning(t)
		OThread.Stop(t)
	EndIf
	Utility.Wait(0.6)
	bSaviorJoining = false
	If !Alive(ep)
		return
	EndIf
	RestoreAttackers(false)
	If kAttacker && !kAttacker.IsDead()
		kAttacker.SetActorValue("Aggression", 2.0)
		kAttacker.SetActorValue("Confidence", 4.0)
		kAttacker.StartCombat(PlayerRef)
	EndIf
	If kVictim && !kVictim.IsDead()
		kVictim.StopCombat()
		kVictim.StopCombatAlarm()
		If IsSpawned(kVictim)
			kVictim.SetActorValue("Aggression", 0.0)
		EndIf
		kVictim.RestoreActorValue("Health", 200.0)
	EndIf
	If iKind == K_SAVIOR
		ShowMsg("The bandit turns on you!")
	ElseIf kAttacker
		ShowMsg(kAttacker.GetDisplayName() + " turns on you!")
	EndIf
	bRoadFight = true
	bAftermathDone = true
	iRoadTicks = 0
	RegisterForSingleUpdate(1.0)
EndFunction

Function SaviorVictory()
	string pn = PlayerRef.GetDisplayName()
	string vn = "the traveler"
	If kVictim
		vn = kVictim.GetDisplayName()
	EndIf
	string where = WhereName()
	string t = ODS_Text.T("savior.victory_bandit", "{pn} killed the bandit near {where}; {vn} is saved.", pn, "", vn, where)
	If iKind == K_CRWILD || iKind == K_WEREWOLF
		t = ODS_Text.T("savior.victory_wild", "{pn} killed {x1} near {where}; {vn} is saved.", pn, "", vn, where, WildBeastName())
	EndIf
	If kVictim && !kVictim.IsDead()
		t += " " + ODS_Text.T("savior.victory_thanks", "{vn} thanks {pn}.", pn, "", vn, where)
		ShowMsg(ODS_Text.T("savior.victory_msg", "{vn} thanks you.", pn, "", vn))
		TalkNet(t, kVictim, PlayerRef, true, true)
	Else
		TalkNet(t, kAttacker, PlayerRef, true, true)
		If iKind == K_SAVIOR
			ShowMsg(ODS_Text.T("savior.dead_bandit", "The bandit is dead."))
		Else
			ShowMsg(ODS_Text.T("savior.dead_other", "It is dead."))
		EndIf
	EndIf
	FinishRoadEvent()
EndFunction

bool Function StageBunnyFight(int ep)
	If !RoadEventPlaceOK() || !KillerBunnyOK() || !Alive(ep)
		return false
	EndIf
	Race kr = KillerBunnyRace()
	ActorBase hare = None
	If ODS_PoolFauna && ODS_PoolFauna.GetSize() > 0
		hare = ODS_PoolFauna.GetAt(0) as ActorBase
	EndIf
	If kr == None || hare == None || ODS_PoolVigilant == None || ODS_PoolVigilant.GetSize() == 0
		Log("bunny fight: missing race, hare or Vigilant pool")
		return false
	EndIf
	Actor v1 = SpawnFromPool(ODS_PoolVigilant, PlayerRef, 4)
	Actor v2 = None
	If v1
		v2 = SpawnFromPool(ODS_PoolVigilant, v1, 4)
	EndIf
	If v1 == None || v2 == None || IsMinor(v1) || IsMinor(v2) || !Alive(ep)
		If v1
			DeleteSpawn(v1)
		EndIf
		If v2
			DeleteSpawn(v2)
		EndIf
		Log("bunny fight: could not spawn two Vigilants")
		return false
	EndIf
	; same method as climax fauna: vanilla hare, then SetRace. Never PlaceAtMe Mihail's unique cave rabbit.
	Actor bunny = SpawnNear(hare, v1)
	If bunny == None || !Alive(ep)
		DeleteSpawn(v1)
		DeleteSpawn(v2)
		If bunny
			DeleteSpawn(bunny)
		EndIf
		Log("bunny fight: could not spawn the rabbit")
		return false
	EndIf
	bunny.SetRace(kr)
	bunny.QueueNiNodeUpdate()
	v1.Enable()
	v2.Enable()
	bunny.Enable()
	v1.RestoreActorValue("Health", 250.0)
	v2.RestoreActorValue("Health", 250.0)
	bunny.SetActorValue("Aggression", 2.0)
	bunny.SetActorValue("Confidence", 4.0)
	v1.SetActorValue("Aggression", 2.0)
	v2.SetActorValue("Aggression", 2.0)
	v1.StartCombat(bunny)
	v2.StartCombat(bunny)
	bunny.StartCombat(v1)
	kVigilant1 = v1
	kVigilant2 = v2
	kBunny = bunny
	iKind = K_BUNNYFIGHT
	bRoadFight = true
	bAftermathDone = true
	fLastEvent = Utility.GetCurrentGameTime()
	ClearFade()
	ShowMsg("Two Vigilants of Stendarr are fighting a Killer Rabbit of Caerbannog... and they are losing!")
	TalkNet("On the road near " + WhereName() + ", two Vigilants of Stendarr, " + v1.GetDisplayName() + " and " + v2.GetDisplayName() + ", are fighting a Killer Rabbit of Caerbannog. The rabbit is beating them. " + PlayerRef.GetDisplayName() + " can still kill the rabbit.", bunny, PlayerRef, true, false)
	iRoadTicks = 0
	RegisterForSingleUpdate(1.0)
	return true
EndFunction

Function KnockIfLosing(Actor a)
	If a == None || a.IsDead() || a.IsUnconscious()
		return
	EndIf
	If a.GetActorValuePercentage("Health") < 0.25
		a.SetUnconscious(true)
		a.StopCombat()
		a.StopCombatAlarm()
	EndIf
EndFunction

bool Function VigilantDown(Actor a)
	return a == None || a.IsDead() || a.IsUnconscious()
EndFunction

Function WatchRoadFight()
	If !bMaster
		bRoadFight = false
		return
	EndIf
	iRoadTicks += 1
	If IsWitnessKind(iKind) && iSaviorChoice == 3
		If kVictim && !kVictim.IsDead() && kVictim.GetActorValuePercentage("Health") < 0.3
			kVictim.RestoreActorValue("Health", 100.0)
			kVictim.StopCombat()
		EndIf
		If kAttacker == None || kAttacker.IsDead()
			SaviorVictory()
			return
		EndIf
		If PlayerRef.IsDead() || (kAttacker && kAttacker.GetDistance(PlayerRef) > 6000.0) || iRoadTicks >= 180
			FinishRoadEvent()
			return
		EndIf
		RegisterForSingleUpdate(1.0)
		return
	EndIf
	If iKind == K_BUNNYFIGHT
		BunnyFightTick()
		return
	EndIf
	bRoadFight = false
	RegisterForSingleUpdate(5.0)
EndFunction

Function BunnyFightTick()
	KnockIfLosing(kVigilant1)
	KnockIfLosing(kVigilant2)
	bool bunnyDead = kBunny == None || kBunny.IsDead()
	bool playerGone = PlayerRef.IsDead() || (kBunny && !bunnyDead && kBunny.GetDistance(PlayerRef) > 6000.0)
	If bunnyDead
		BunnyResolved(true)
		return
	EndIf
	If playerGone || iRoadTicks >= 180
		If VigilantDown(kVigilant1) && VigilantDown(kVigilant2)
			BunnyResolved(false)
		Else
			; still fighting or player walked off mid-fight: wrap up
			BunnyResolved(false)
		EndIf
		return
	EndIf
	RegisterForSingleUpdate(1.0)
EndFunction

Function BunnyResolved(bool playerOrVigilantsWon)
	string pn = PlayerRef.GetDisplayName()
	string where = WhereName()
	int lived = 0
	If kVigilant1 && !kVigilant1.IsDead()
		lived += 1
	EndIf
	If kVigilant2 && !kVigilant2.IsDead()
		lived += 1
	EndIf
	If playerOrVigilantsWon
		WakeUnconscious(kVigilant1)
		WakeUnconscious(kVigilant2)
		If kVigilant1 && !kVigilant1.IsDead()
			kVigilant1.StopCombat()
			kVigilant1.RestoreActorValue("Health", 200.0)
		EndIf
		If kVigilant2 && !kVigilant2.IsDead()
			kVigilant2.StopCombat()
			kVigilant2.RestoreActorValue("Health", 200.0)
		EndIf
		lived = 0
		If kVigilant1 && !kVigilant1.IsDead()
			lived += 1
		EndIf
		If kVigilant2 && !kVigilant2.IsDead()
			lived += 1
		EndIf
		string t
		If lived > 0
			t = "On the road near " + where + ", " + pn + " killed the Killer Rabbit of Caerbannog and saved the Vigilants of Stendarr. The surviving Vigilants thank " + pn + ", and are embarrassed that a rabbit was beating them."
			ShowMsg("The Vigilants thank you... and look embarrassed that a rabbit had them on the ropes.")
		Else
			t = "On the road near " + where + ", " + pn + " killed the Killer Rabbit of Caerbannog, but both Vigilants of Stendarr had already fallen."
			ShowMsg("The Killer Rabbit is dead. The Vigilants were not so lucky.")
		EndIf
		TalkNet(t, kBunny, PlayerRef, true, true)
	Else
		string t = "On the road near " + where + ", the Killer Rabbit of Caerbannog defeated two Vigilants of Stendarr"
		If PlayerRef.IsDead()
			t += " and " + pn + " as well."
		Else
			t += "."
		EndIf
		ShowMsg("The Killer Rabbit of Caerbannog wins...")
		TalkNet(t, kBunny, PlayerRef, true, true)
	EndIf
	FinishRoadEvent()
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
; 1.2.0: the bridge bodies now live in ODS_Bridges (same quest). The mod-event handlers below keep
; their names, so RegisterForModEvent registrations (and any saved ones) still land on ODS_Main.
ODS_Bridges Function BridgeMod()
	ODS_Bridges b = (Self as Quest) as ODS_Bridges
	If !b
		ModMissing("ODS_Bridges")
	EndIf
	return b
EndFunction

Event OnOKRTaken(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnOKRTaken(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnOKRDodged(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnOKRDodged(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnOKREnd(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnOKREnd(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnODefStart(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefStart(eventName, strArg, numArg, sender)
	EndIf
EndEvent

; from OnOStimThreadEnd while a player defeat is in progress
Function ODefSceneEnded(string json)
	ODS_Bridges b = BridgeMod()
	If b
		b.ODefSceneEnded(json)
	EndIf
EndFunction

Event OnODefRobbery(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefRobbery(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnODefSafeWakeup(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefSafeWakeup(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnODefArrest(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefArrest(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnODefKill(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefKill(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnODefSlavery(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnODefSlavery(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnBakaSceneStart(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnBakaSceneStart(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnBakaSceneEnd(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnBakaSceneEnd(eventName, strArg, numArg, sender)
	EndIf
EndEvent

Event OnBakaPostAssault(string eventName, string strArg, float numArg, Form sender)
	ODS_Bridges b = BridgeMod()
	If b
		b.OnBakaPostAssault(eventName, strArg, numArg, sender)
	EndIf
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
; (the Baka Defeat bridge body is in ODS_Bridges; its three event handlers are the forwarders above)

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

; 1.2.0: the follower rescue body now lives in ODS_Rescue (same quest). These forwarders keep the
; names and signatures that ODS_AttackerAlias, OnActorBleedout, OnOStimThreadEnd and AbortAll use.
ODS_Rescue Function RescueMod()
	ODS_Rescue r = (Self as Quest) as ODS_Rescue
	If !r
		ModMissing("ODS_Rescue")
	EndIf
	return r
EndFunction

bool Function IsRescueAlias(ReferenceAlias r)
	ODS_Rescue m = RescueMod()
	If !m
		return false
	EndIf
	return m.IsRescueAlias(r)
EndFunction

; from OnActorBleedout for a downed follower. true = handled here (the full Defeat path is skipped)
bool Function TryFollowerRescue(Actor vic)
	ODS_Rescue m = RescueMod()
	If !m
		return false
	EndIf
	return m.TryFollowerRescue(vic)
EndFunction

; how: 1 = player hit / pulled the attacker away, 2 = attacker died, 0 = the scene ended on its own
Function RescueOutcome(int how)
	ODS_Rescue m = RescueMod()
	If m
		m.RescueOutcome(how)
	EndIf
EndFunction

; stop the side scene and give both actors back (also used by panic, master off and game load)
Function RescueRelease(bool fight)
	ODS_Rescue m = RescueMod()
	If m
		m.RescueRelease(fight)
	Else
		bRescueOn = false     ; module missing: at least drop the flag so nothing waits on it
		iRescueThread = -1
	EndIf
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

; =====================================================================================
; ======================= 1.0: join in, wild creatures, OStim Beast Form =======================
; Every 1.0 module is OFF by default, has its own MCM toggle and chance, needs the master
; switch, is stopped by the panic key, and refuses children for every role. Other mods are
; soft-detected only (never masters). New settings and runtime variables are declared here,
; at the end of the script, so a 0.9 save keeps every existing value.
; SkyrimNet text in this block is deliberately blunt so the AI is never left guessing.
; =====================================================================================

; ---------- 1.0 settings ----------
bool Property bJoinIn = false Auto Hidden            ; join in when you catch your spouse / a companion (consensual only)
float Property fJoinChance = 100.0 Auto Hidden       ; % the choice is offered
bool Property bJoinTakeOver = true Auto Hidden       ; no three-person scene installed: take over instead
bool Property bCrWild = false Auto Hidden            ; OCreatures: a creature takes someone in the wilderness
float Property fCrWildChance = 2.0 Auto Hidden       ; % per game hour / wait hour on a wilderness road
bool Property bCrWildTraveler = true Auto Hidden
bool Property bCrWildCompanion = true Auto Hidden
bool Property bCrWildPlayer = false Auto Hidden
bool Property bWolfNight = false Auto Hidden         ; OStim Beast Form: a werewolf at night in the wilderness
float Property fWolfNightChance = 3.0 Auto Hidden    ; % per night game hour / wait hour on a wilderness road
bool Property bWolfTraveler = true Auto Hidden
bool Property bWolfCompanion = true Auto Hidden
bool Property bWolfPlayer = false Auto Hidden
bool Property bBeastOffer = false Auto Hidden        ; OStim Beast Form: choices when the player transforms
float Property fBeastOfferChance = 50.0 Auto Hidden  ; % per transformation
bool Property bBeastPrey = true Auto Hidden          ; take a beaten bandit
bool Property bBeastPreySpawn = true Auto Hidden     ; nobody beaten nearby: a bandit who ambushed you (wilderness only)
bool Property bBeastClaim = true Auto Hidden         ; claim a willing spouse / companion
bool Property bForceBeastOffer = false Auto Hidden   ; debug: next transformation (or now) offers, no chance roll
Message Property ODS_JoinChoice Auto                 ; 1.0: Watch / Join in / Stop them
Message Property ODS_WildChoice Auto                 ; 1.0: Watch / Rescue
Message Property ODS_BeastPreyChoice Auto            ; 1.0: Take them / Let them go
Message Property ODS_BeastClaimChoice Auto           ; 1.0: Claim them / Not now

; ---------- 1.0 runtime ----------
int iJoinChoice = 0          ; 0 none, 1 watched, 2 joined (three-person scene), 3 took over
Actor kJoinOther             ; the partner pushed aside on a take-over
Actor kBeastTarget           ; picked before a beast-form event is staged
int iBeastTries = 0
bool bBeastOffered = false

; ---------- 1.0 soft detection ----------
bool Function BeastFormOK()
	return ModLoaded("OStim_Beast_Form_Merged.esp") || ModLoaded("OStim_Beast_Form_TWO.esp")
EndFunction

; OStim Beast Form's own start scene for a female werewolf and a man ships in every edition;
; without it (or without the plugin) none of the Beast Form options appear.
bool Function BFScenesOK()
	return BeastFormOK() && OStimOK() && OMetaData.GetActorCount("OBFWerewolfIdleMF") == 2
EndFunction

Race Function WerewolfRace()
	return Game.GetFormFromFile(0x000CDD84, "Skyrim.esm") as Race
EndFunction

Race Function VampireLordRace()
	If !ModLoaded("Dawnguard.esm")
		return None
	EndIf
	return Game.GetFormFromFile(0x0000283A, "Dawnguard.esm") as Race
EndFunction

bool Function IsWerewolfForm(Actor a)
	If a == None
		return false
	EndIf
	Race w = WerewolfRace()
	return w && a.GetRace() == w
EndFunction

bool Function IsVampireLordForm(Actor a)
	If a == None
		return false
	EndIf
	Race vl = VampireLordRace()
	return vl && a.GetRace() == vl
EndFunction

bool Function IsBeastForm(Actor a)
	return IsWerewolfForm(a) || IsVampireLordForm(a) || IsWerebearForm(a)      ; 1.1: werebears too
EndFunction

bool Function PlayerIsBeast()
	return IsBeastForm(PlayerRef)
EndFunction

string Function BeastWord(Actor a)
	If IsVampireLordForm(a)
		return "vampire lord"
	ElseIf IsWerebearForm(a)
		return "werebear"
	EndIf
	return "werewolf"
EndFunction

bool Function IsNight()
	GlobalVariable gh = Game.GetFormFromFile(0x00000038, "Skyrim.esm") as GlobalVariable
	If gh == None
		return true
	EndIf
	float h = gh.GetValue()
	return h >= 20.0 || h < 5.0
EndFunction

bool Function WolfNightOK()
	return BFScenesOK() && IsNight() && !PlayerIsBeast()
EndFunction

bool Function IsWitnessKind(int k)
	return k == K_SAVIOR || k == K_CRWILD || k == K_WEREWOLF
EndFunction

string Function SexLetter(Actor a)
	If a.GetLeveledActorBase().GetSex() == 1
		return "F"
	EndIf
	return "M"
EndFunction

; ---------- 1.0: OStim Beast Form scenes ----------
; Beast Form 0.8 start scenes, actor order as in its JSON (the beast first). "" = not installed.
string Function BFStartFor(Actor beast, Actor other)
	If beast == None || other == None || !BFScenesOK()
		return ""
	EndIf
	bool bm = beast.GetLeveledActorBase().GetSex() == 0
	bool om = other.GetLeveledActorBase().GetSex() == 0
	string id = ""
	string alt = ""
	If IsWerewolfForm(beast)
		If IsWerewolfForm(other)
			id = "OBFWerewolfIdleCC" + SexLetter(beast) + SexLetter(other)     ; werewolf couples
		ElseIf IsBeastForm(other)
			id = ""
		ElseIf bm && !om
			id = "OBFWerewolfIdleFM"       ; 1.1: Beast Form 1.0's own scene first, OCreatures' as the last resort
			alt = "OCrWerewolfIdleFM"
		ElseIf bm && om
			id = "OBFWerewolfIdleMM"
		ElseIf !bm && om
			id = "OBFWerewolfIdleMF"
		Else
			id = "OBFWerewolfIdleFF"       ; 1.1: Beast Form 1.0
			If OMetaData.GetActorCount(id) != 2
				id = "OBFWerewolfIdleFwF"  ; Beast Form 0.8
			EndIf
			alt = "OCrWerewolfIdleFF"
		EndIf
	ElseIf IsVampireLordForm(beast)
		If IsVampireLordForm(other)
			id = "OBFVampireLordIdleCC" + SexLetter(beast) + SexLetter(other)  ; vampire lord couples
		ElseIf bm && !om && !IsBeastForm(other)
			id = "OBFVampireLordIdleFM"    ; 1.1: Beast Form 1.0 first
			alt = "OCrVampireLordIdleFM"
		EndIf
	EndIf
	If id != "" && OMetaData.GetActorCount(id) == 2
		return id
	EndIf
	If alt != "" && OMetaData.GetActorCount(alt) == 2
		return alt
	EndIf
	return ""
EndFunction

; one beast + one partner. preferHub: open on Beast Form's start scene (the player picks from its
; menu); otherwise a fitting scene from the library first and the start scene as the fallback.
; Sets kSceneActs / sPreScene for StartEncounter. "" = nothing installed for this pair.
string Function BeastPairScene(Actor beast, Actor other, bool forced, bool preferHub)
	If beast == None || other == None || IsMinor(beast) || IsMinor(other)
		return ""
	EndIf
	string hub = BFStartFor(beast, other)
	string s = ""
	Actor[] outA = new Actor[2]
	If !preferHub || hub == ""
		Actor[] a1 = new Actor[1]
		a1[0] = beast
		Actor[] v1 = new Actor[1]
		v1[0] = other
		s = SceneForSet(a1, 1, v1, 1, forced, outA)
	EndIf
	If s == "" && hub != ""
		s = hub
		outA[0] = beast
		outA[1] = other
	EndIf
	If s != ""
		Actor[] acts = new Actor[2]
		acts[0] = outA[0]
		acts[1] = outA[1]
		kSceneActs = acts
		sPreScene = s
		kFurn = None
	EndIf
	return s
EndFunction

; ---------- 1.0: join in (consensual scenes with your spouse or a companion only) ----------
; Called by StageWithFade right after the scene started. Only for the cheating spouse, shared
; inn room and bathing modules, only when the scene is consensual and you are not in it.
Function MaybeOfferJoin(int ep)
	If !bJoinIn || !bMaster || iThread < 0 || bForcedScene || bPaired || nAtt != 1 || nVic != 1
		return
	EndIf
	If iKind != K_CHEAT && iKind != K_INNSHARE && iKind != K_BATH
		return
	EndIf
	If kAttacker == None || kVictim == None || kAttacker == PlayerRef || kVictim == PlayerRef
		return
	EndIf
	If kSceneActs && kSceneActs.Find(PlayerRef) >= 0
		return
	EndIf
	Actor lover = None
	Actor other = None
	If IsSpouse(kVictim) || IsFollowerActor(kVictim)
		lover = kVictim
		other = kAttacker
	ElseIf IsSpouse(kAttacker) || IsFollowerActor(kAttacker)
		lover = kAttacker
		other = kVictim
	EndIf
	If lover == None || other == None || IsMinor(lover) || IsMinor(other) || IsMinor(PlayerRef)
		return
	EndIf
	If Utility.RandomFloat(0.0, 100.0) >= fJoinChance
		return
	EndIf
	If !OThread.IsRunning(iThread) || !Alive(ep)
		return
	EndIf
	int choice = 0
	If ODS_JoinChoice
		choice = ODS_JoinChoice.Show()
	EndIf
	If !Alive(ep) || iThread < 0 || bAftermathDone
		return
	EndIf
	If choice == 1
		Log("join: player joins " + lover.GetDisplayName() + " and " + other.GetDisplayName())
		JoinIn(lover, other, ep)
	ElseIf choice == 2
		Log("join: player steps in")
		Intervene()
	Else
		iJoinChoice = 1
		Log("join: player watches")
	EndIf
EndFunction

Function JoinIn(Actor lover, Actor other, int ep)
	string pn = PlayerRef.GetDisplayName()
	string ln = lover.GetDisplayName()
	string on = other.GetDisplayName()
	string rel = "companion "
	If IsSpouse(lover)
		rel = "spouse "
	EndIf
	; find the new scene first, so nothing is stopped when no scene has room for the player
	Actor[] att = new Actor[2]
	att[0] = other
	att[1] = PlayerRef
	Actor[] vic = new Actor[1]
	vic[0] = lover
	Actor[] out3 = new Actor[3]
	string sc = SceneForSet(att, 2, vic, 1, false, out3)
	int mode = 2
	Actor[] acts = out3
	If sc == "" && bJoinTakeOver
		Actor[] a1 = new Actor[1]
		a1[0] = PlayerRef
		Actor[] out2 = new Actor[2]
		sc = SceneForSet(a1, 1, vic, 1, false, out2)
		mode = 3
		acts = out2
	EndIf
	If sc == ""
		iJoinChoice = 1
		ShowMsg(ODS_Text.T("join.no_room", "You stay and watch."))
		Log("join: no three-person or take-over scene for this cast")
		return
	EndIf
	If !Alive(ep) || iThread < 0 || !OThread.IsRunning(iThread)
		return
	EndIf
	bSaviorJoining = true          ; the stop below is not the end of the encounter
	int t = iThread
	iThread = -1
	OThread.Stop(t)
	Utility.Wait(0.6)
	bSaviorJoining = false
	If !Alive(ep)
		return
	EndIf
	kFurn = None
	sScene1 = sc
	kSceneActs = acts
	iJoinChoice = mode
	If mode == 3
		kJoinOther = other
	EndIf
	iThread = StartThread(acts, kNoActors, sc, "odangerous,cheating,joined", ep)
	If iThread < 0
		iJoinChoice = 1
		ShowMsg(ODS_Text.T("join.failed", "You could not join them."))
		bAftermathDone = false
		RegisterForSingleUpdate(5.0)
		return
	EndIf
	If mode == 3
		other.EvaluatePackage()
		ShowMsg(ODS_Text.T("join.takeover_msg", "You take over from {vn}.", pn, ln, on))
		TalkNet(ODS_Text.T("join.takeover", "{pn} takes over from {vn} with {x1}.", pn, ln, on, "", rel + ln), lover, PlayerRef, true, false)
	Else
		ShowMsg(ODS_Text.T("join.threesome_msg", "You join them."))
		TalkNet(ODS_Text.T("join.threesome", "{pn} joins {an} and {vn}.", pn, ln, on, "", rel + ln), lover, PlayerRef, true, false)
	EndIf
	bAftermathDone = false
	iCleanupTicks = 0
	RegisterForSingleUpdate(10.0)
EndFunction

string Function JoinMemoryText()
	string pn = PlayerRef.GetDisplayName()
	If iJoinChoice == 3 && kJoinOther
		return " " + pn + " walked in on them, shoved " + kJoinOther.GetDisplayName() + " aside and took over."
	ElseIf iJoinChoice == 2
		return " " + pn + " walked in on them and joined in for a threesome."
	EndIf
	return ""
EndFunction

; ---------- 1.0: wild creatures (OCreatures) and werewolves at night (OStim Beast Form) ----------
bool Function CrWildTypeOK(int t)
	If !bOCreatures || !iCrStatus || !bCrType
		return false
	EndIf
	If iCrStatus[t] != 2 || !bCrType[t]
		return false
	EndIf
	If t == 0 && BFScenesOK()
		return false      ; werewolves belong to the Beast Form module when Beast Form is installed
	EndIf
	return true
EndFunction

bool Function AnyCrWildOK()
	If !bCrWild || !OCreaturesInstalled()
		return false
	EndIf
	int t = 0
	While t < 7
		If CrWildTypeOK(t)
			return true
		EndIf
		t += 1
	EndWhile
	return false
EndFunction

int Function PickCrWildType()
	int[] cand = new int[7]
	int c = 0
	int t = 0
	While t < 7
		If CrWildTypeOK(t) && t != 1 && t != 3      ; outdoors: no draugr or falmer
			cand[c] = t
			c += 1
		EndIf
		t += 1
	EndWhile
	If c == 0
		t = 0
		While t < 7
			If CrWildTypeOK(t)
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

Actor Function SpawnCrWildFor(Actor vic, int ep)
	int tries = 0
	While tries < 3 && Alive(ep)
		int t = PickCrWildType()
		If t < 0
			return None
		EndIf
		Actor a = TrySpawn(CrPool(t), vic, true, ep)
		If a
			return a
		EndIf
		tries += 1
	EndWhile
	return None
EndFunction

Actor Function SpawnWerewolfFor(Actor vic, int ep)
	If ODS_PoolWerewolf == None || ODS_PoolWerewolf.GetSize() == 0 || !Alive(ep)
		return None
	EndIf
	Actor w = SpawnNear(ODS_PoolWerewolf.GetAt(Utility.RandomInt(0, ODS_PoolWerewolf.GetSize() - 1)), vic)
	If w == None
		return None
	EndIf
	If !Alive(ep) || !IsWerewolfForm(w) || IsMinor(w)
		DeleteSpawn(w)
		return None
	EndIf
	If BeastPairScene(w, vic, true, false) == ""
		Log("werewolf: no Beast Form / OStim scene for the pair")
		DeleteSpawn(w)
		return None
	EndIf
	return w
EndFunction

Actor Function SpawnTraveler(int ep)
	If ODS_PoolTraveler == None || ODS_PoolTraveler.GetSize() == 0
		return None
	EndIf
	int t = 0
	While t < 6 && Alive(ep)
		Actor c = SpawnFromPool(ODS_PoolTraveler, PlayerRef, 1)
		If c
			If GenderOK(c) && !IsMinor(c)
				return c
			EndIf
			DeleteSpawn(c)
		EndIf
		t += 1
	EndWhile
	return None
EndFunction

; the spouse first (when nearby), else a follower who can be a victim
Actor Function WildCompanion()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, true)
	Actor fol = None
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && a != PlayerRef && !a.IsDead() && !a.IsDisabled() && !a.IsInCombat() && !IsMinor(a) && !OActor.IsInOStim(a) && !IsStaged(a) && GenderOK(a) && !IsProtected(a)
			If IsSpouse(a)
				return a
			EndIf
			If fol == None && IsValidVictim(a, false, true)
				fol = a
			EndIf
		EndIf
		i += 1
	EndWhile
	return fol
EndFunction

string Function WildBeastName()
	If iKind == K_WEREWOLF
		return "a werewolf in full beast form"
	EndIf
	If kAttacker
		return "a " + kAttacker.GetDisplayName()
	EndIf
	return "a creature"
EndFunction

string Function WildVictimText()
	If kVictim == None
		return "someone"
	EndIf
	string pn = PlayerRef.GetDisplayName()
	If kVictim == PlayerRef
		return pn
	ElseIf IsSpouse(kVictim)
		return pn + "'s spouse " + kVictim.GetDisplayName()
	ElseIf IsFollowerActor(kVictim)
		return pn + "'s companion " + kVictim.GetDisplayName()
	EndIf
	return "the traveler " + kVictim.GetDisplayName()
EndFunction

string Function BondText(Actor a)
	If IsSpouse(a)
		return "their spouse "
	ElseIf IsFollowerActor(a)
		return "their companion "
	EndIf
	return ""
EndFunction

; K_CRWILD / K_WEREWOLF: a spawned traveler, your spouse / a companion, or you. No join-in:
; there are no one-creature, two-human scenes. Watch or rescue when it is not you.
bool Function StageWild(int kind, int ep)
	If !RoadEventPlaceOK() || !Alive(ep)
		return false
	EndIf
	bool wolf = kind == K_WEREWOLF
	If wolf && (!BFScenesOK() || PlayerIsBeast())
		Log("werewolf: Beast Form scenes missing or the player is in beast form")
		return false
	EndIf
	If !wolf && !AnyCrWildOK()
		Log("wild creature: OCreatures / creature scenes not available")
		return false
	EndIf
	bool wantTrav = bCrWildTraveler
	bool wantComp = bCrWildCompanion
	bool wantPlayer = bCrWildPlayer
	If wolf
		wantTrav = bWolfTraveler
		wantComp = bWolfCompanion
		wantPlayer = bWolfPlayer
	EndIf
	Actor comp = None
	If wantComp
		comp = WildCompanion()
	EndIf
	If wantPlayer && !IsValidVictim(PlayerRef, true, false)
		wantPlayer = false
	EndIf
	int[] opts = new int[3]
	int n = 0
	If wantTrav
		opts[n] = 0
		n += 1
	EndIf
	If comp
		opts[n] = 1
		n += 1
	EndIf
	If wantPlayer
		opts[n] = 2
		n += 1
	EndIf
	If n == 0
		Log("wild: no victim type enabled or available")
		return false
	EndIf
	int pick = opts[Utility.RandomInt(0, n - 1)]
	Actor vic = PlayerRef
	If pick == 0
		vic = SpawnTraveler(ep)
	ElseIf pick == 1
		vic = comp
	EndIf
	If vic == None || IsMinor(vic) || !Alive(ep)
		If vic && IsSpawned(vic)
			DeleteSpawn(vic)
		EndIf
		return false
	EndIf
	Actor att = None
	If wolf
		att = SpawnWerewolfFor(vic, ep)
	Else
		att = SpawnCrWildFor(vic, ep)
	EndIf
	If att == None || !Alive(ep)
		If IsSpawned(vic)
			DeleteSpawn(vic)
		EndIf
		If att && IsSpawned(att)
			DeleteSpawn(att)
		EndIf
		Log("wild: no beast with an installed scene for " + vic.GetDisplayName())
		return false
	EndIf
	AddAttacker(att)
	AddVictim(vic)
	iSaviorChoice = 0
	string meta = "odangerous,aggressive,creature,wild"
	If wolf
		meta = "odangerous,aggressive,werewolf,beastform"
	EndIf
	If !StartEncounter(true, meta, ep)
		Log("wild: StartEncounter failed")
		DeleteAllSpawned()
		return false
	EndIf
	If !Alive(ep) || vic == PlayerRef
		return true
	EndIf
	int choice = 0
	If ODS_WildChoice
		choice = ODS_WildChoice.Show()
	EndIf
	If !Alive(ep) || bAftermathDone
		return true
	EndIf
	WildChosen(choice, ep)
	return true
EndFunction

Function WildChosen(int choice, int ep)
	string pn = PlayerRef.GetDisplayName()
	string an = WildBeastName()
	string vn = WildVictimText()
	Log("wild: player chose " + choice + " (1 = rescue, else watch)")
	If choice == 1
		TalkNet(ODS_Text.T("wild.rescue", "{pn} steps in for {vn} against {an}.", pn, an, vn), kAttacker, kVictim, true, false)
		SaviorRescue(ep)
	Else
		iSaviorChoice = 1
		TalkNet(ODS_Text.T("wild.watch", "{pn} watches {an} and {vn}.", pn, an, vn), kAttacker, kVictim, true, false)
		ShowMsg(ODS_Text.T("wild.watch_msg", "You stand and watch."))
	EndIf
EndFunction

; ---------- 1.0: the player in beast form (OStim Beast Form) ----------
; ODS_PlayerAlias.OnRaceSwitchComplete -> here. Returns seconds until the first check, 0 = none.
float Function OnPlayerRaceSwitch()
	PathoSyncGlobals()          ; 1.1: SkyrimNet sees whether you can give the blood gift
	bBeastOffered = false
	iBeastTries = 0
	If !Ready() || !bBeastOffer || !PlayerIsBeast() || !BFScenesOK()
		return 0.0
	EndIf
	return 12.0
EndFunction

; ODS_PlayerAlias single update while transformed. Bounded: at most 12 checks (about two
; minutes), one offer per transformation, and only waits while you are still fighting.
float Function BeastOfferTick()
	If !Ready() || !bBeastOffer || bBeastOffered || !PlayerIsBeast() || !BFScenesOK()
		return 0.0
	EndIf
	iBeastTries += 1
	If iBeastTries > 12
		return 0.0
	EndIf
	If bBusy || OtherBusy(false)
		return 10.0
	EndIf
	bBeastOffered = true
	If !bForceBeastOffer
		If CooldownActive() || Utility.RandomFloat(0.0, 100.0) >= fBeastOfferChance
			return 0.0
		EndIf
	EndIf
	bForceBeastOffer = false
	OfferBeast()
	return 0.0
EndFunction

; debug: the next transformation offers (or right away, after the menu closes, if already transformed)
Function ForceBeastOffer()
	bForceBeastOffer = true
	If PlayerIsBeast()
		bBeastOffered = false
		iBeastTries = 0
		ODS_PlayerAlias pa = GetAliasByName("Player") as ODS_PlayerAlias
		If pa
			pa.StartBeastTick(2.0)
		EndIf
	EndIf
EndFunction

bool Function OfferBeast()
	If !Ready() || !PlayerIsBeast() || !BFScenesOK() || bBusy || OtherBusy(false)
		return false
	EndIf
	iBioAsked = 0
	Actor prey = None
	Actor mate = None
	If bBeastPrey
		prey = FindBeastPrey()
	EndIf
	If bBeastClaim
		mate = FindBeastMate()
	EndIf
	bool spawnPrey = prey == None && bBeastPrey && bBeastPreySpawn && RoadEventPlaceOK() && IsWerewolfForm(PlayerRef)
	bool canPrey = prey != None || spawnPrey
	int kind = 0
	If mate && (!canPrey || Utility.RandomInt(0, 1) == 0)
		kind = K_BEASTCLAIM
	ElseIf canPrey
		kind = K_BEASTPREY
	EndIf
	If kind == 0
		Log("beast form: nobody to take or claim here")
		return false
	EndIf
	int choice = 1
	If kind == K_BEASTPREY
		If prey
			ShowMsg(prey.GetDisplayName() + " lies beaten at your feet...")
		EndIf
		If ODS_BeastPreyChoice
			choice = ODS_BeastPreyChoice.Show()
		EndIf
		kBeastTarget = prey
	Else
		ShowMsg(mate.GetDisplayName() + " is close by, and willing...")
		If ODS_BeastClaimChoice
			choice = ODS_BeastClaimChoice.Show()
		EndIf
		kBeastTarget = mate
	EndIf
	If choice != 0 || !Ready() || !PlayerIsBeast() || bBusy || OtherBusy(false)
		kBeastTarget = None
		Log("beast form: declined or no longer possible")
		return false
	EndIf
	bBusy = true
	StageWithFade(kind, iEpoch, false)
	return true
EndFunction

bool Function BeastHasScene(Actor a, bool forced)
	If BFStartFor(PlayerRef, a) != ""
		return true
	EndIf
	return PairScene(PlayerRef, a, forced) != ""
EndFunction

; a hostile adult humanoid nearby who is down or badly hurt (a bandit you just beat)
Actor Function FindBeastPrey()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 2500.0, false, false, true)
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && BaseEligible(a, true) && IsHumanoid(a) && !IsBeastForm(a) && !IsFollowerActor(a) && GenderOK(a) && (bGuardVictims || !IsGuardActor(a))
			If a.IsHostileToActor(PlayerRef) && (a.IsBleedingOut() || a.GetActorValuePercentage("Health") < 0.5)
				If BeastHasScene(a, true)
					return a
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	return None
EndFunction

; the spouse first, else a follower; both must be willing
Actor Function FindBeastMate()
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, fVictimRange, false, false, true)
	Actor fol = None
	int i = 0
	While i < near.Length
		Actor a = near[i]
		If a && a != PlayerRef && !a.IsDead() && !a.IsDisabled() && !a.IsInCombat() && !IsMinor(a) && !OActor.IsInOStim(a) && !IsStaged(a) && !IsProtected(a)
			bool sp = IsSpouse(a)
			If (sp || (fol == None && IsFollowerActor(a))) && BeastHasScene(a, false) && BeastMateWilling(a)
				If sp
					return a
				EndIf
				fol = a
			EndIf
		EndIf
		i += 1
	EndWhile
	return fol
EndFunction

; spouse: yes. Companion: SkyrimNet's decision model from their bio when available, else
; relationship rank Confidant or better.
bool Function BeastMateWilling(Actor a)
	If IsSpouse(a)
		return true
	EndIf
	int r = AskConsent(a, ODS_Text.T("beastmate.consent", "{pn} is in beast form near {where}. {x1}.", PlayerRef.GetDisplayName(), "", "", WhereName(), BeastWord(PlayerRef)))
	If r == 1
		return true
	ElseIf r == 0
		Log(a.GetDisplayName() + ": SkyrimNet says not willing")
		return false
	EndIf
	return a.GetRelationshipRank(PlayerRef) >= 2
EndFunction

; 1 yes, 0 no, 2 unknown (same plumbing as AskBio, consent template)
int Function AskConsent(Actor a, string situation)
	If !bBioCheck || !SNetOK() || !DecisionsAvailable() || iBioAsked >= 2
		return 2
	EndIf
	iBioAsked += 1
	iBioAnswer = -1
	string ctx = "{\"actor_name\":\"" + JsonSafe(a.GetDisplayName()) + "\",\"target_name\":\"" + JsonSafe(PlayerRef.GetDisplayName()) + "\",\"situation\":\"" + JsonSafe(situation) + "\"}"
	int rc = SkyrimNetApi.SendCustomDecisionToLLM("odeadly/would_consent", ctx, self, "ODS_Main", "OnBioDecision")
	If rc != 1
		return 2
	EndIf
	int ep = iEpoch
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

bool Function StageBeastPrey(int ep)
	Actor prey = kBeastTarget
	kBeastTarget = None
	If !PlayerIsBeast() || !BFScenesOK() || !Alive(ep)
		return false
	EndIf
	If prey && (prey.IsDead() || IsMinor(prey) || OActor.IsInOStim(prey))
		prey = None
	EndIf
	If prey == None && bBeastPreySpawn && RoadEventPlaceOK()
		int t = 0
		While prey == None && t < 4 && Alive(ep)
			Actor c = SpawnFromPool(ODS_PoolBandit, PlayerRef, 1)
			If c
				If GenderOK(c) && !IsMinor(c)
					prey = c
				Else
					DeleteSpawn(c)
				EndIf
			EndIf
			t += 1
		EndWhile
	EndIf
	If prey == None || !Alive(ep)
		Log("beast prey: nobody to take")
		return false
	EndIf
	Pacify(prey)                     ; beaten: stops fighting until the next location change
	prey.StopCombat()
	PlayerRef.StopCombatAlarm()
	If BeastPairScene(PlayerRef, prey, true, true) == ""
		Log("beast prey: no Beast Form / OStim scene for the pair")
		If IsSpawned(prey)
			DeleteSpawn(prey)
		EndIf
		return false
	EndIf
	AddAttacker(PlayerRef)
	AddVictim(prey)
	return StartEncounter(true, "odangerous,aggressive,beastform,prey", ep)
EndFunction

bool Function StageBeastClaim(int ep)
	Actor mate = kBeastTarget
	kBeastTarget = None
	If mate == None || !PlayerIsBeast() || !BFScenesOK() || !Alive(ep)
		return false
	EndIf
	If mate.IsDead() || IsMinor(mate) || OActor.IsInOStim(mate)
		return false
	EndIf
	If BeastPairScene(PlayerRef, mate, false, true) == ""
		Log("beast claim: no Beast Form / OStim scene for the pair")
		return false
	EndIf
	AddAttacker(PlayerRef)
	AddVictim(mate)
	return StartEncounter(false, "odangerous,consensual,beastform,claim", ep)
EndFunction

; =====================================================================================
; ======================= 1.0: "Bitch in Heat" (OStim Beast Form) =======================
; When an OStim scene with the player starts between a male werewolf in beast form and a human
; adult, the howls and scent can draw 1-3 more werewolves. 1.1.5: also a werebear or a vampire
; lord in full beast form; see the 1.1.5 notes at HeatKindOf. OFF by default; master switch, panic
; key and the no-children rule apply. Summoned werewolves are vanilla EncWerewolf01-06 bases
; (WerewolfBeastRace in Skyrim.esm), checked for that race before they are used and again right
; before the scene starts; they are calmed BEFORE they are enabled, never hostile, then walk off
; and are deleted out of sight. Declared at the end of the script (save-safe).
; =====================================================================================
bool Property bHeat = false Auto Hidden
float Property fHeatChance = 25.0 Auto Hidden
bool Property bHeatAsk = true Auto Hidden          ; 1.1.6: retired (no in-game box any more), kept for old saves
int Property iHeatMax = 3 Auto Hidden              ; 1.1.6: retired (replaced by iHeatJoin), kept for old saves
int Property iHeatJoin = 0 Auto Hidden             ; 1.1.6: how many join: 1-3, 0 = random 1-3 (MCM, no in-game box)
int Property iHeatJoinKind = 0 Auto Hidden         ; 1.2.0: joining beasts: 0 match the first beast (1.1.8), 1 werewolves, 2 werebears, 3 mixed
bool Property bForceHeat = false Auto Hidden       ; debug: next eligible scene, no chance roll
FormList Property ODS_PoolHeatWolf Auto            ; EncWerewolf01-06 (Skyrim.esm, WerewolfBeastRace)
Faction Property ODS_HeatPackFaction Auto          ; friend (never ally) to the player and followers
Faction Property PlayerWerewolfFaction Auto
Faction Property PlayerFollowerFaction Auto
GlobalVariable Property ODS_HeatAllow1 Auto        ; MESG button conditions
GlobalVariable Property ODS_HeatAllow2 Auto
GlobalVariable Property ODS_HeatAllow3 Auto
Message Property ODS_HeatChoice Auto               ; 1.1.6: no longer shown (record kept, unused)
Quest Property ODS_HeatQuest Auto                  ; holds the summoned werewolves in guarded aliases
ReferenceAlias Property HeatWolf1Alias Auto
ReferenceAlias Property HeatWolf2Alias Auto
ReferenceAlias Property HeatWolf3Alias Auto

bool bHeatOn = false
int iHeatThread = -1
int iHeatEp = 0
int iHeatLeft = 0
bool bHeatOwnsBusy = false
Actor[] kHeatWolves
Actor kHeatHuman
Actor kHeatBeast
ObjectReference kHeatMarker
int iHeatCount = 0

; ---------- 1.1.5: which beast, and how they join ----------
; 1.1.5: any male beast in FULL beast form counts (werewolf, werebear, vampire lord); human-form
; werewolves and vampires never do. Werewolves (and werebears with OStim Beast Form's "werebears
; use werewolf scenes" toggle) join one group scene; vampire lords (no group scenes exist) and
; werebears without the toggle take turns, one pair scene after another.
bool bHeatTurns = false
bool bHeatFemale = true
int iHeatTurn = -1
int iHeatKind = 1          ; the beast already in the scene: 1 werewolf, 2 vampire lord, 3 werebear
int iHeatWW = 0            ; summoned, by kind (for the narration)
int iHeatVL = 0
int iHeatBear = 0

; 1.2.0: Bitch in Heat now lives in ODS_Heat (same quest). Its state variables stay declared here
; (save safety) and are reached by the module through the mv_ accessor properties at the end of
; this script. The forwarders below keep every name and signature other scripts call.
ODS_Heat Function HeatMod()
	ODS_Heat h = (Self as Quest) as ODS_Heat
	If !h
		ModMissing("ODS_Heat")
	EndIf
	return h
EndFunction

bool Function HeatBearAsWolf()
	ODS_Heat h = HeatMod()
	If !h
		return false
	EndIf
	return h.HeatBearAsWolf()
EndFunction

int Function HeatKindOf(Actor a)
	ODS_Heat h = HeatMod()
	If !h
		return 0
	EndIf
	return h.HeatKindOf(a)
EndFunction

string Function HeatJoinKindText()
	ODS_Heat h = HeatMod()
	If !h
		return ""
	EndIf
	return h.HeatJoinKindText()
EndFunction

string Function HeatJoinText()
	ODS_Heat h = HeatMod()
	If !h
		return ""
	EndIf
	return h.HeatJoinText()
EndFunction

Function HeatNote(string t)
	ODS_Heat h = HeatMod()
	If h
		h.HeatNote(t)
	EndIf
EndFunction

Function HeatCheck(int id)
	ODS_Heat h = HeatMod()
	If h
		h.HeatCheck(id)
	EndIf
EndFunction

bool Function HeatTurnNext(int id)
	ODS_Heat h = HeatMod()
	If !h
		return false
	EndIf
	return h.HeatTurnNext(id)
EndFunction

Function HeatSceneEnded()
	ODS_Heat h = HeatMod()
	If h
		h.HeatSceneEnded()
	EndIf
EndFunction

; alias events (ODS_HeatWolfAlias)
Function HeatCalmWolf(Actor w)
	ODS_Heat h = HeatMod()
	If h
		h.HeatCalmWolf(w)
	EndIf
EndFunction

Function HeatRaceChanged(Actor w)
	ODS_Heat h = HeatMod()
	If h
		h.HeatRaceChanged(w)
	EndIf
EndFunction

Function HeatWolfGone(ODS_HeatWolfAlias al, bool force)
	ODS_Heat h = HeatMod()
	If h
		h.HeatWolfGone(al, force)
	Else
		al.Clear()
	EndIf
EndFunction

; panic / master off: stop the scene, remove the werewolves at once
Function HeatAbort()
	ODS_Heat h = HeatMod()
	If h
		h.HeatAbort()
	EndIf
EndFunction

; game loaded: a heat event that is not in its scene any more is cleaned up at once
Function HeatOnLoad()
	ODS_Heat h = HeatMod()
	If h
		h.HeatOnLoad()
	EndIf
EndFunction




; =====================================================================================
; 1.0: Saturalia (soft: Saturalia Holiday Pack, ccvsvsse001-winter.esl). Off by default.
; Runs on the existing single game-time timer (ScheduleGameTime); no new polling.
; =====================================================================================
bool Property bSaturalia = false Auto Hidden
bool Property bSatCountdown = true Auto Hidden     ; 22-24 Evening Star: "Saturalia is N days away"
bool Property bSatGifts = true Auto Hidden         ; 25 Evening Star: Agrane Peryval hands out gifts
int Property iSatVisits = 3 Auto Hidden            ; gift visits on the day (1-5)
bool Property bForceSat = false Auto Hidden        ; debug: next check makes a visit, date ignored
Quest Property ODS_SatQuest Auto
ReferenceAlias Property SatAgraneAlias Auto

float fSatDue = -1.0
int iSatCountKey = 0
int iSatYear = -1
int iSatVisitsDone = 0
float fSatLastVisit = -1.0
bool bSatAway = false
bool bSatWalking = false
float fSatWalkStart = -1.0
Cell kSatHomeCell
float fSatHomeX = 0.0
float fSatHomeY = 0.0
float fSatHomeZ = 0.0

bool Function SatModOK()
	return ModLoaded("ccvsvsse001-winter.esl")
EndFunction

Actor Function Agrane()
	If !SatModOK()
		return None
	EndIf
	return Game.GetFormFromFile(0x00000826, "ccvsvsse001-winter.esl") as Actor
EndFunction

bool Function SatWanted()
	return bSaturalia && SatModOK() && (bSatCountdown || bSatGifts || bForceSat)
EndFunction

float Function GlobalNow(int fid)
	GlobalVariable g = Game.GetFormFromFile(fid, "Skyrim.esm") as GlobalVariable
	If g
		return g.GetValue()
	EndIf
	return -1.0
EndFunction

; GameMonth (0x36) is zero-based (Evening Star = 11), GameDay (0x37) is the day of the month
bool Function IsSatDay(int d)
	return (GlobalNow(0x36) as int) == 11 && (GlobalNow(0x37) as int) == d
EndFunction

Function SatWorldEvent(string t)
	If !SNetOK()
		return
	EndIf
	SkyrimNetApi.RegisterShortLivedEvent("odeadly_saturalia", "world_event", t, "", 4320000, None, None)
	If bSkyrimNetLog
		SkyrimNetApi.RegisterPersistentEvent(t, None, None)
	EndIf
EndFunction

Function SatTick()
	fSatDue = -1.0
	int m = GlobalNow(0x36) as int
	int d = GlobalNow(0x37) as int
	int y = GlobalNow(0x35) as int
	float h = GlobalNow(0x38)
	float now = Utility.GetCurrentGameTime()
	bool day25 = m == 11 && d == 25
	If bSatWalking && fSatWalkStart > 0.0 && now - fSatWalkStart > 1.5 / 24.0
		SatVisitDone()          ; a walk that never finished
	EndIf
	If bSatAway && (!SatWanted() || (!day25 && !bForceSat))
		Actor ag = Agrane()
		If ag && ag.Is3DLoaded() && PlayerRef.HasLOS(ag) && h < 4.0 && SatWanted()
			Log("saturalia: Agrane still in sight, sent home a little later")
		Else
			SatSendHome()
		EndIf
	EndIf
	If !SatWanted()
		return
	EndIf
	If bSatCountdown && m == 11 && d >= 22 && d <= 25
		int k = y * 100 + d
		If iSatCountKey != k
			iSatCountKey = k
			If d == 25
				SatWorldEvent("Today is Saturalia, the midwinter festival of gifts and good cheer.")
			ElseIf d == 24
				SatWorldEvent("Saturalia is 1 day away. Tomorrow is Saturalia.")
			Else
				SatWorldEvent("Saturalia is " + (25 - d) + " days away.")
			EndIf
		EndIf
	EndIf
	If day25 && iSatYear != y
		iSatYear = y
		iSatVisitsDone = 0
		fSatLastVisit = -1.0
	EndIf
	If bForceSat
		SatTryVisit()
	ElseIf day25 && bSatGifts && h >= 8.0 && h < 21.0 && iSatVisitsDone < iSatVisits
		If fSatLastVisit < 0.0 || now - fSatLastVisit >= 2.5 / 24.0
			SatTryVisit()
		EndIf
	EndIf
	SatScheduleNext()
EndFunction

Function SatScheduleNext()
	If !SatWanted() && !bSatAway
		fSatDue = -1.0
		return
	EndIf
	int m = GlobalNow(0x36) as int
	int d = GlobalNow(0x37) as int
	float h = GlobalNow(0x38)
	float hrs = 6.0
	If bSatAway && !(m == 11 && d == 25)
		hrs = 2.0
	ElseIf m == 11 && d == 25
		If h >= 21.0 || iSatVisitsDone >= iSatVisits || !bSatGifts
			hrs = 24.05 - h       ; just after midnight: he goes home
		ElseIf h < 8.0
			hrs = 8.0 - h + Utility.RandomFloat(0.0, 1.0)
		Else
			hrs = Utility.RandomFloat(1.5, 2.5)
		EndIf
	ElseIf m == 11 && d == 24
		hrs = 24.05 - h
		If hrs > 6.0
			hrs = 6.0
		EndIf
	ElseIf m < 11 || d < 21
		hrs = 12.0
	EndIf
	If hrs < 0.1
		hrs = 0.1
	EndIf
	fSatDue = Utility.GetCurrentGameTime() + hrs / 24.0
EndFunction

; town, city or settlement outdoors; an inn or shop indoors. Never jails, dungeons, castles or homes.
bool Function SatPlaceOK()
	If PlayerRef.IsInCombat() || bBusy || OtherBusy(false) || bHeatOn || InJailOrBarracks()
		return false
	EndIf
	Location loc = PlayerRef.GetCurrentLocation()
	If loc == None
		return false
	EndIf
	If HasKW(loc, "LocTypeJail") || HasKW(loc, "LocTypeDungeon") || HasKW(loc, "LocTypePlayerHouse") || HasKW(loc, "LocTypeCastle")
		return false
	EndIf
	If PlayerRef.IsInInterior()
		return HasKW(loc, "LocTypeInn") || HasKW(loc, "LocTypeStore")
	EndIf
	return TreeHasKW(loc, "LocTypeCity") || TreeHasKW(loc, "LocTypeTown") || TreeHasKW(loc, "LocTypeSettlement")
EndFunction

bool Function SatTargetOK(Actor a, Actor ag)
	If a == None || a == PlayerRef || a == ag || a.IsDead() || a.IsDisabled() || a.IsInCombat() || a.IsUnconscious()
		return false
	EndIf
	If a.IsHostileToActor(PlayerRef) || IsMinor(a) || !IsHumanoid(a) || IsBeastForm(a) || IsSpawned(a) || OActor.IsInOStim(a)
		return false
	EndIf
	return a.GetSleepState() < 3
EndFunction

bool Function SatStillOK(Actor ag, Actor t)
	return bMaster && bSaturalia && bSatWalking && ag && !ag.IsInCombat() && !PlayerRef.IsInCombat() && SatTargetOK(t, ag)
EndFunction

Form Function SatGift()
	int r = Utility.RandomInt(0, 3)
	Form f = None
	If r == 3
		f = Game.GetFormFromFile(0x00000806, "ccvsvsse001-winter.esl")     ; Saturalia hat
	ElseIf r == 2
		int g = Utility.RandomInt(0, 4)
		If g == 0
			f = Game.GetFormFromFile(0x00063B45, "Skyrim.esm")    ; garnet
		ElseIf g == 1
			f = Game.GetFormFromFile(0x00063B46, "Skyrim.esm")    ; amethyst
		ElseIf g == 2
			f = Game.GetFormFromFile(0x00063B42, "Skyrim.esm")    ; ruby
		ElseIf g == 3
			f = Game.GetFormFromFile(0x00063B44, "Skyrim.esm")    ; sapphire
		Else
			f = Game.GetFormFromFile(0x00063B43, "Skyrim.esm")    ; emerald
		EndIf
	ElseIf r == 1
		If Utility.RandomInt(0, 1) == 0
			f = Game.GetFormFromFile(0x00034C5D, "Skyrim.esm")    ; Nord mead
		Else
			f = Game.GetFormFromFile(0x0002C35A, "Skyrim.esm")    ; Black-Briar mead
		EndIf
	EndIf
	If f == None
		f = Game.GetFormFromFile(0x00064B3D, "Skyrim.esm")        ; sweetroll
	EndIf
	return f
EndFunction

Function SatTryVisit()
	Actor ag = Agrane()
	If ag == None || ag.IsDead() || ag.IsInCombat() || bSatWalking || ODS_SatQuest == None || SatAgraneAlias == None
		return
	EndIf
	If !Ready() || !SatPlaceOK()
		return
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 2000.0, false, false, false)
	If !near || near.Length == 0
		return
	EndIf
	Actor[] picks = new Actor[3]
	int want = Utility.RandomInt(1, 3)
	int n = 0
	int cnt = near.Length
	int start = Utility.RandomInt(0, cnt - 1)
	int i = 0
	While i < cnt && n < want
		Actor a = near[(start + i) % cnt]
		If SatTargetOK(a, ag)
			picks[n] = a
			n += 1
		EndIf
		i += 1
	EndWhile
	If n == 0
		return
	EndIf
	If !bSatAway
		kSatHomeCell = ag.GetParentCell()      ; recorded before the first move
		fSatHomeX = ag.GetPositionX()
		fSatHomeY = ag.GetPositionY()
		fSatHomeZ = ag.GetPositionZ()
		bSatAway = true
	EndIf
	SatPlaceOutOfSight(ag)
	If !ODS_SatQuest.IsRunning()
		ODS_SatQuest.Start()
	EndIf
	SatAgraneAlias.ForceRefTo(ag)
	bSatWalking = true
	bForceSat = false
	fSatWalkStart = Utility.GetCurrentGameTime()
	fSatLastVisit = fSatWalkStart
	iSatVisitsDone += 1
	Log("saturalia: Agrane visits " + n + " people")
	(SatAgraneAlias as ODS_SatAlias).Visit(picks)
EndFunction

; behind the player, just out of sight, snapped to the navmesh
Function SatPlaceOutOfSight(Actor ag)
	float dmin = 1200.0
	float dmax = 1800.0
	If PlayerRef.IsInInterior()
		dmin = 500.0
		dmax = 900.0
	EndIf
	int t = 0
	While t < 4
		float ang = PlayerRef.GetAngleZ() + 180.0 + Utility.RandomFloat(-60.0, 60.0) + (t * 45.0)
		float dist = Utility.RandomFloat(dmin, dmax)
		ag.MoveTo(PlayerRef, Math.sin(ang) * dist, Math.cos(ang) * dist, 0.0, false)
		PO3_SKSEFunctions.MoveToNearestNavmeshLocation(ag)
		If !PlayerRef.HasLOS(ag)
			return
		EndIf
		t += 1
	EndWhile
EndFunction

Function SatGive(Actor ag, Actor t)
	Form g = SatGift()
	If g == None || t == None
		return
	EndIf
	t.AddItem(g, 1, true)
	TalkNet("It is Saturalia. Agrane Peryval, the cheerful Breton merchant from the camp north of Windward Ruins, walks up to " + t.GetDisplayName() + " and hands them a Saturalia gift: " + g.GetName() + ".", ag, t, true, true)
EndFunction

Function SatVisitDone()
	bSatWalking = false
	fSatWalkStart = -1.0
	Actor ag = Agrane()
	If ag
		ag.EvaluatePackage()
	EndIf
EndFunction

; back to his camp: his editor location (the CC plugin's own placement)
Function SatSendHome()
	If !bSatAway && !bSatWalking
		return
	EndIf
	ODS_SatAlias al = SatAgraneAlias as ODS_SatAlias
	If al
		al.Halt()
	EndIf
	Actor ag = Agrane()
	If ag && !ag.IsDead()
		ag.StopCombat()
		ag.MoveToMyEditorLocation()
		ag.EvaluatePackage()
		Log("saturalia: Agrane back at camp (home cell " + kSatHomeCell + " @ " + fSatHomeX + "," + fSatHomeY + "," + fSatHomeZ + ")")
	EndIf
	If SatAgraneAlias
		SatAgraneAlias.Clear()
	EndIf
	If ODS_SatQuest && ODS_SatQuest.IsRunning()
		ODS_SatQuest.Stop()
	EndIf
	bSatAway = false
	bSatWalking = false
	fSatWalkStart = -1.0
EndFunction

Function SatOnLoad()
	If bSatAway && (bSatWalking || !IsSatDay(25) || !SatWanted())
		SatSendHome()
	EndIf
	If !SatWanted()
		fSatDue = -1.0
	EndIf
EndFunction

Function ForceSaturalia()
	bForceSat = true
	fSatDue = Utility.GetCurrentGameTime() + 0.02 / 24.0
	If bMaster
		ScheduleGameTime()
	EndIf
EndFunction

; =====================================================================================
; 1.0: Blood Born Pathogen. 1.1: anyone in an OStim scene with a werewolf, vampire lord or werebear
; (or a werewolf / vampire in human form) may catch it: you, your partners, and NPCs in scenes of
; their own. Off by default. Infected NPCs live in ODS_PathoQuest's ten aliases (event-only, no
; polling); incubation runs on the existing game-time timer. The world cap is checked first.
; Kinds: 1 lycanthropy (werewolf), 2 vampirism (vampire lord), 3 werebear lycanthropy.
; =====================================================================================
bool Property bPatho = false Auto Hidden
float Property fPathoChance = 10.0 Auto Hidden          ; % per partner per scene, carrier in human form
float Property fPathoBeastChance = 35.0 Auto Hidden     ; 1.0 only (kept for old saves; 1.1 uses the three per-form chances)
bool Property bPathoAnyNPC = false Auto Hidden          ; OFF: followers and spouses only
int Property iPathoCap = 10 Auto Hidden                 ; world cap: most NPCs infected by this mod at once (1-10). 1.1 default 10
bool Property bPathoTransform = true Auto Hidden        ; infected werewolves / werebears change in night fights
bool Property bForcePatho = false Auto Hidden           ; debug: next eligible partner is infected
bool Property bPathoNotify = true Auto Hidden          ; 1.0.1: on-screen note when someone is infected
bool Property bPathoProtectedOK = false Auto Hidden    ; 1.0.1: ON = the Protected followers list does not block infection
Quest Property ODS_PathoQuest Auto
; 1.1
float Property fPathoWWChance = 35.0 Auto Hidden        ; % per partner, werewolf in beast form
float Property fPathoVLChance = 35.0 Auto Hidden        ; % per partner, vampire lord form
float Property fPathoBearChance = 35.0 Auto Hidden      ; % per partner, werebear form
bool Property bPathoNPCs = true Auto Hidden             ; NPC-only scenes spread it too
bool Property bPathoPlayerCatch = true Auto Hidden      ; you can catch it from a partner
bool Property bPathoSNetForms = true Auto Hidden        ; SkyrimNet: infected NPCs may change at will
int Property iBloodGiftKey = 0 Auto Hidden              ; 0 = no key
Message Property ODS_BloodGiftChoice Auto

Actor[] kPatho
int[] iPathoKind          ; 1 lycanthropy, 2 vampirism, 3 werebear lycanthropy
int[] iPathoStage         ; 0-2 incubating, 3 turned
float[] fPathoStart
Race[] kPathoRace
bool[] bPathoFirst
bool[] bPathoChanged
bool[] bPathoBusy
float[] fPathoCD
int[] iPathoMode          ; 0 ours, 1 Growl's own follower beastblood
; 1.1
Actor[] kPathoSrc         ; who passed it on (None = unknown)
int[] iPathoWhy           ; beast form now: 0 no, 1 asked / chose to (stays until asked back), 2 for a fight (back after it)
int[] iPTId               ; tracked scenes: thread id + 1 (0 = free); 4 at once
Actor[] kPTActs           ; 5 actors per tracked scene
int[] iPTKind             ; carrier kind of each actor at the start
bool[] bPTBeast           ; in beast form at the start
int iPTNext = 0
int iPlayerPatho = 0      ; you: 1 / 3 lycanthropy incubating or turned by this mod (vampirism uses the vanilla disease)
int iPlayerPathoStage = 0
float fPlayerPathoStart = 0.0
Actor kPlayerPathoSrc
; 1.1.3: an NPC with its own skin (NPC worn armor, e.g. most custom followers) keeps that skin when its
; race changes, and that skin has no beast-race body, so the body was invisible (only the head showed).
; While changed by this mod the beast race's own skin is swapped in and the NPC's skin is given back after.
Armor[] kPathoSkin        ; the NPC's own skin, saved while the beast skin is swapped in
bool[] bPathoSkinSwap     ; true while the swap is in place
bool bPathoRaceSetting = false   ; 1.1.4: O'Deadly itself is changing a race right now (PathoSkinCheck leaves the flags alone)

Function PathoInitArrays()
	If !kPatho
		kPatho = new Actor[10]
		iPathoKind = new int[10]
		iPathoStage = new int[10]
		fPathoStart = new float[10]
		kPathoRace = new Race[10]
		bPathoFirst = new bool[10]
		bPathoChanged = new bool[10]
		bPathoBusy = new bool[10]
		fPathoCD = new float[10]
		iPathoMode = new int[10]
	EndIf
	If !kPathoSrc          ; 1.1 (also for 1.0.x saves)
		kPathoSrc = new Actor[10]
		iPathoWhy = new int[10]
		int i = 0
		While i < 10
			If bPathoChanged[i]
				iPathoWhy[i] = 2      ; a 1.0 fight change
			EndIf
			If kPatho[i]
				kPathoSrc[i] = PlayerRef     ; 1.0 only ever passed it on from you
			EndIf
			i += 1
		EndWhile
	EndIf
	If !kPathoSkin         ; 1.1.3 (also for 1.1.2 and older saves)
		kPathoSkin = new Armor[10]
		bPathoSkinSwap = new bool[10]
	EndIf
	If !iPTId
		iPTId = new int[4]
		kPTActs = new Actor[20]
		iPTKind = new int[20]
		bPTBeast = new bool[20]
	EndIf
	If bPathoLore.Length != 10
		bool[] tLore = new bool[10]
		bPathoLore = tLore
	EndIf
EndFunction

string Function PlayerName()
	string n = PlayerRef.GetDisplayName()
	If n == ""
		n = PlayerRef.GetActorBase().GetName()
	EndIf
	return n
EndFunction

string Function NameOf(Actor a)
	If a == None
		return "someone"
	ElseIf a == PlayerRef
		return PlayerName()
	EndIf
	return a.GetDisplayName()
EndFunction

bool Function PlayerHasLycanthropy()
	If IsWerewolfForm(PlayerRef) || IsWerebearForm(PlayerRef)
		return true
	EndIf
	If GlobalNow(0x000ED06C) >= 1.0          ; PlayerIsWerewolf (vanilla, Growl)
		return true
	EndIf
	If iPlayerPatho > 0 && iPlayerPathoStage >= 3
		return true
	EndIf
	Spell s = Game.GetFormFromFile(0x00092C48, "Skyrim.esm") as Spell     ; vanilla Beast Form power
	return s && PlayerRef.HasSpell(s)
EndFunction

bool Function PlayerHasVampirism()
	If IsVampireLordForm(PlayerRef)
		return true
	EndIf
	If GlobalNow(0x000ED06D) >= 1.0          ; PlayerIsVampire (vanilla, Sacrosanct)
		return true
	EndIf
	return IsVampire(PlayerRef)
EndFunction

int Function PlayerDiseaseKind()
	If IsWerebearForm(PlayerRef)
		return 3
	ElseIf IsWerewolfForm(PlayerRef)
		return 1
	ElseIf IsVampireLordForm(PlayerRef)
		return 2
	EndIf
	bool w = PlayerHasLycanthropy()
	bool v = PlayerHasVampirism()
	int wk = 1
	If iPlayerPatho == 3 && iPlayerPathoStage >= 3
		wk = 3
	EndIf
	If w && v
		If Utility.RandomInt(1, 2) == 1
			return wk
		EndIf
		return 2
	ElseIf w
		return wk
	ElseIf v
		return 2
	EndIf
	return 0
EndFunction

string Function DiseaseWord(int kind)
	If kind == 2
		return "vampirism"
	ElseIf kind == 3
		return "werebear lycanthropy"
	EndIf
	return "lycanthropy"
EndFunction

string Function FormWord(int kind)
	If kind == 2
		return "vampire lord"
	ElseIf kind == 3
		return "werebear"
	EndIf
	return "werewolf"
EndFunction

string Function BeingWord(int kind)
	If kind == 2
		return "a vampire"
	ElseIf kind == 3
		return "a werebear"
	EndIf
	return "a werewolf"
EndFunction

Race Function WerebearRace()
	If !ModLoaded("Dragonborn.esm")
		return None
	EndIf
	return Game.GetFormFromFile(0x0001E17B, "Dragonborn.esm") as Race      ; DLC2WerebearBeastRace
EndFunction

bool Function IsWerebearForm(Actor a)
	If a == None
		return false
	EndIf
	Race b = WerebearRace()
	return b && a.GetRace() == b
EndFunction

Race Function BeastRaceFor(int kind)
	If kind == 2
		return VampireLordRace()
	ElseIf kind == 3
		Race b = WerebearRace()
		If b
			return b
		EndIf
	EndIf
	return WerewolfRace()
EndFunction

ODS_PathoAlias Function PathoAlias(int i)
	If ODS_PathoQuest == None
		return None
	EndIf
	return ODS_PathoQuest.GetAlias(i) as ODS_PathoAlias
EndFunction

int Function PathoIndex(Actor a)
	PathoInitArrays()
	If a == None
		return -1
	EndIf
	return kPatho.Find(a)
EndFunction

int Function PathoCount()
	PathoInitArrays()
	int n = 0
	int i = 0
	While i < 10
		If kPatho[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	return n
EndFunction

int Function PathoCapNow()
	int cap = iPathoCap
	If cap > 10
		cap = 10
	ElseIf cap < 1
		cap = 1
	EndIf
	return cap
EndFunction

bool Function PathoFactionBlocked(Actor a)
	Faction f = Game.GetFormFromFile(0x000FF234, "Skyrim.esm") as Faction      ; CompanionsCircle
	If f && a.IsInFaction(f)
		return true
	EndIf
	f = Game.GetFormFromFile(0x00109C71, "Skyrim.esm") as Faction             ; CompanionsCirclePlusKodlak
	If f && a.IsInFaction(f)
		return true
	EndIf
	f = Game.GetFormFromFile(0x00043594, "Skyrim.esm") as Faction             ; WerewolfFaction (already one)
	If f && a.IsInFaction(f)
		return true
	EndIf
	f = Game.GetFormFromFile(0x00027242, "Skyrim.esm") as Faction             ; VampireFaction (already one)
	If f && a.IsInFaction(f)
		return true
	EndIf
	If ModLoaded("Dawnguard.esm")
		f = Game.GetFormFromFile(0x00003376, "Dawnguard.esm") as Faction      ; DLC1VampireFaction (Volkihar: Serana, Harkon...)
		If f && a.IsInFaction(f)
			return true
		EndIf
		f = Game.GetFormFromFile(0x00014217, "Dawnguard.esm") as Faction      ; DLC1DawnguardFaction
		If f && a.IsInFaction(f)
			return true
		EndIf
		f = Game.GetFormFromFile(0x00003375, "Dawnguard.esm") as Faction      ; DLC1HunterFaction
		If f && a.IsInFaction(f)
			return true
		EndIf
	EndIf
	return false
EndFunction

; human-form werewolves (the Circle, the werewolf faction)
bool Function IsLycanNPC(Actor a)
	Faction f = Game.GetFormFromFile(0x00043594, "Skyrim.esm") as Faction      ; WerewolfFaction
	If f && a.IsInFaction(f)
		return true
	EndIf
	f = Game.GetFormFromFile(0x000FF234, "Skyrim.esm") as Faction              ; CompanionsCircle
	If f && a.IsInFaction(f)
		return true
	EndIf
	f = Game.GetFormFromFile(0x00109C71, "Skyrim.esm") as Faction              ; CompanionsCirclePlusKodlak
	return f && a.IsInFaction(f)
EndFunction

Spell Function GrowlNPCSpell()
	If !ModLoaded("Growl - Werebeasts of Skyrim.esp")
		return None
	EndIf
	return Game.GetFormFromFile(0x0000AA06, "Growl - Werebeasts of Skyrim.esp") as Spell   ; HRI_Mortal_Spell_NPCCanMorph_Ab_Passives
EndFunction

; 1.1: what this actor can pass on in a scene (0 = nothing). Beast forms first.
int Function CarrierKind(Actor a)
	If a == None || a.IsDead()
		return 0
	EndIf
	If IsWerewolfForm(a)
		return 1
	ElseIf IsWerebearForm(a)
		return 3
	ElseIf IsVampireLordForm(a)
		return 2
	EndIf
	If a == PlayerRef
		return PlayerDiseaseKind()
	EndIf
	If IsMinor(a)
		return 0
	EndIf
	int i = PathoIndex(a)
	If i >= 0
		If iPathoStage[i] >= 3
			return iPathoKind[i]
		EndIf
		return 0
	EndIf
	If IsVampire(a)
		return 2
	EndIf
	If IsLycanNPC(a)
		return 1
	EndIf
	Spell gs = GrowlNPCSpell()
	If gs && a.HasSpell(gs)
		return 1
	EndIf
	return 0
EndFunction

float Function PathoChanceFor(int kind, bool beast)
	If !beast
		return fPathoChance
	ElseIf kind == 2
		return fPathoVLChance
	ElseIf kind == 3
		return fPathoBearChance
	EndIf
	return fPathoWWChance
EndFunction

bool Function PathoEligible(Actor a)
	return PathoWhyNot(a) == ""
EndFunction

string Function PathoWhyNot(Actor a)
	return PathoWhyNot2(a, false)
EndFunction

; 1.0.1: "" = can be infected, otherwise the reason. 1.1: deliberate = a blood gift (any adult NPC
; who agreed; the followers-only and essential checks do not apply). The cap is checked first.
string Function PathoWhyNot2(Actor a, bool deliberate)
	If a == None || a == PlayerRef
		return "not a partner"
	EndIf
	If PathoIndex(a) >= 0
		return "already infected by this mod"
	EndIf
	int cap = PathoCapNow()
	If PathoRegularCount() >= cap
		return "limit reached (" + cap + " infected)"
	EndIf
	If kPatho.Find(None) < 0
		return "no free slot (all 10 aliases in use, including lore beasts)"
	EndIf
	If a.IsDead()
		return "dead"
	EndIf
	If IsMinor(a)
		return "child"
	EndIf
	If !IsHumanoid(a)
		return "not a humanoid race"
	EndIf
	If IsBeastForm(a)
		return "in beast form"
	EndIf
	If IsSpawned(a)
		return "spawned by this mod"
	EndIf
	Keyword npc = Keyword.GetKeyword("ActorTypeNPC")
	If npc && !a.HasKeyword(npc)
		return "no ActorTypeNPC keyword"
	EndIf
	bool close = IsFollowerActor(a) || IsSpouse(a)
	If !deliberate && !bPathoAnyNPC && !close
		return "not detected as a follower or spouse (turn on 'Any eligible NPC' to skip this check)"
	EndIf
	If !deliberate && a.IsEssential() && !close
		return "essential"          ; 1.0.1: your own follower / spouse may be essential; sex never kills, so that no longer blocks it
	EndIf
	If IsProtected(a) && !((close || deliberate) && bPathoProtectedOK)
		return "on the Protected followers list (or Serana protection)"
	EndIf
	If IsVampire(a)
		return "already a vampire (Vampire keyword or vampire race)"
	EndIf
	If PathoFactionBlocked(a)
		return "Companions' Circle, Volkihar, Dawnguard, or already in the werewolf / vampire faction"
	EndIf
	Spell gs = GrowlNPCSpell()
	If gs && a.HasSpell(gs)
		return "already has Growl's beastblood"
	EndIf
	return ""
EndFunction

; 1.1: can you catch it now? "" = yes
string Function PathoPlayerWhyNot(bool deliberate)
	If !deliberate && !bPathoPlayerCatch
		return "'You can catch it' is off"
	EndIf
	If iPlayerPatho > 0
		return "you already carry " + DiseaseWord(iPlayerPatho)
	EndIf
	If PlayerHasLycanthropy() || PlayerHasVampirism()
		return "you are already a werewolf or a vampire"
	EndIf
	Spell sv = Game.GetFormFromFile(0x000B8780, "Skyrim.esm") as Spell      ; DiseaseSanguinareVampiris
	If sv && PlayerRef.HasSpell(sv)
		return "you already have Sanguinare Vampiris"
	EndIf
	return ""
EndFunction

; ---------- triggers: OnOStimThreadStart / OnOStimThreadEnd (any scene, 1.1) ----------
Function PathoSceneStart(int id)
	If id < 0
		return
	EndIf
	If !bPatho || !bMaster
		If bForcePatho
			PathoNote("pathogen: scene " + id + " not tracked: Blood Born Pathogen or the master switch is off")
		EndIf
		return
	EndIf
	Actor[] acts = OThread.GetActors(id)
	If !acts || acts.Length < 2
		return
	EndIf
	bool withYou = acts.Find(PlayerRef) >= 0
	If !withYou && !bPathoNPCs
		return
	EndIf
	; world cap first: with it reached only you can still catch it, so most scenes stop here
	If PathoCount() >= PathoCapNow() && !bForcePatho
		If !withYou || PathoPlayerWhyNot(false) != ""
			If withYou
				PathoNote("pathogen: scene " + id + " not tracked: limit reached (" + PathoCapNow() + " infected)")
			EndIf
			return
		EndIf
	EndIf
	PathoInitArrays()
	int n = acts.Length
	If n > 5
		n = 5
	EndIf
	int carriers = 0
	int j = 0
	While j < n
		If CarrierKind(acts[j]) > 0
			carriers += 1
		EndIf
		j += 1
	EndWhile
	If carriers == 0
		If withYou
			PathoNote("pathogen: scene " + id + " not tracked: nobody in it is a werewolf, vampire or werebear (PlayerIsWerewolf " + GlobalNow(0x000ED06C) + ", PlayerIsVampire " + GlobalNow(0x000ED06D) + ")")
		EndIf
		return
	EndIf
	int k = iPTId.Find(id + 1)
	If k < 0
		k = iPTId.Find(0)
	EndIf
	If k < 0
		k = iPTNext
		iPTNext = (iPTNext + 1) % 4
	EndIf
	iPTId[k] = id + 1
	j = 0
	While j < 5
		Actor a = None
		If j < n
			a = acts[j]
		EndIf
		kPTActs[k * 5 + j] = a
		iPTKind[k * 5 + j] = CarrierKind(a)
		bPTBeast[k * 5 + j] = IsBeastForm(a)
		j += 1
	EndWhile
	If withYou
		PathoNote("pathogen: scene " + id + " tracked (" + carriers + " carrier(s), " + n + " actors)")
	Else
		Log("pathogen: NPC scene " + id + " tracked (" + carriers + " carrier(s))")
	EndIf
EndFunction

Function PathoSceneEnd(int id)
	If id < 0 || !iPTId
		return
	EndIf
	int k = iPTId.Find(id + 1)
	If k < 0
		If bForcePatho && bPatho && bMaster
			Log("pathogen: scene " + id + " ended but was not tracked")
		EndIf
		return
	EndIf
	Actor[] acts = new Actor[5]
	int[] kinds = new int[5]
	bool[] beast = new bool[5]
	int j = 0
	While j < 5
		acts[j] = kPTActs[k * 5 + j]
		kinds[j] = iPTKind[k * 5 + j]
		beast[j] = bPTBeast[k * 5 + j]
		kPTActs[k * 5 + j] = None
		j += 1
	EndWhile
	iPTId[k] = 0
	If !bPatho || !bMaster
		return
	EndIf
	bool withYou = acts.Find(PlayerRef) >= 0
	; someone may have changed during the scene
	j = 0
	While j < 5
		If acts[j]
			int ck = CarrierKind(acts[j])
			If ck > 0 && (kinds[j] == 0 || IsBeastForm(acts[j]))
				kinds[j] = ck
			EndIf
			If IsBeastForm(acts[j])
				beast[j] = true
			EndIf
		EndIf
		j += 1
	EndWhile
	int t = 0
	While t < 5
		Actor a = acts[t]
		If a && kinds[t] == 0
			; the strongest carrier among the others
			int bk = 0
			float bch = -1.0
			Actor bsrc = None
			bool bbeast = false
			j = 0
			While j < 5
				If j != t && acts[j] && kinds[j] > 0
					float c = PathoChanceFor(kinds[j], beast[j])
					If c > bch
						bch = c
						bk = kinds[j]
						bsrc = acts[j]
						bbeast = beast[j]
					EndIf
				EndIf
				j += 1
			EndWhile
			If bk > 0
				PathoRollOne(a, bk, bsrc, bch, withYou, bbeast)
			EndIf
		EndIf
		t += 1
	EndWhile
EndFunction

; 1.1.1: srcBeast = the carrier was in beast form. Lycanthropy (werewolf, werebear) always turns at once;
; vampirism turns at once from a vampire lord, and stays the slow disease from a human-form vampire.
bool Function PathoInstant(int kind, bool srcBeast)
	return kind != 2 || srcBeast
EndFunction

Function PathoRollOne(Actor a, int kind, Actor src, float ch, bool withYou, bool srcBeast)
	string why
	If a == PlayerRef
		why = PathoPlayerWhyNot(false)
	Else
		why = PathoWhyNot(a)
	EndIf
	If why != ""
		If withYou
			string fs = ""
			If bForcePatho
				fs = " (debug force still armed)"
			EndIf
			PathoNote("pathogen: " + NameOf(a) + " can't be infected: " + why + fs)
		EndIf
		return
	EndIf
	float r = Utility.RandomFloat(0.0, 100.0)
	bool forced = bForcePatho && withYou
	bool always = bPathoAlways && PathoInstant(kind, srcBeast)     ; 1.1.1: no roll from a werewolf, werebear or vampire lord
	If forced || always || r < ch
		If always && !forced
			Log("pathogen: " + NameOf(a) + ": no roll ('Always infect' is on)")
		EndIf
		If forced
			bForcePatho = false
			Log("pathogen: " + NameOf(a) + ": roll skipped by the debug force")
		EndIf
		If a == PlayerRef
			PathoPlayerInfect2(kind, src, false, PathoInstant(kind, srcBeast))
		Else
			PathoInfect2(a, kind, src, false, PathoInstant(kind, srcBeast))
		EndIf
	ElseIf withYou
		PathoNote("pathogen: " + NameOf(a) + " not infected this time (rolled " + (r as int) + ", needed under " + (ch as int) + ")")
	EndIf
EndFunction

; gift: a deliberate blood gift (no roll; turns at once)
Function PathoInfect(Actor a, int kind, Actor src, bool gift)
	PathoInfect2(a, kind, src, gift, false)
EndFunction

; 1.1.1: instant = caught through sex and turns at once (no incubation)
Function PathoInfect2(Actor a, int kind, Actor src, bool gift, bool instant)
	PathoInitArrays()
	int i = kPatho.Find(None)
	If i < 0
		PathoNote("pathogen: " + a.GetDisplayName() + " NOT infected: no free slot (all 10 in use)")
		return
	EndIf
	If ODS_PathoQuest == None
		PathoNote("pathogen: " + a.GetDisplayName() + " NOT infected: ODS_PathoQuest missing (ODeadlySkyrim.esp not loaded or an old plugin)")
		return
	EndIf
	If !ODS_PathoQuest.IsRunning()
		ODS_PathoQuest.Start()
		If !ODS_PathoQuest.IsRunning()
			Log("pathogen: ODS_PathoQuest did not start (continuing; the alias only watches for Cure Disease)")
		EndIf
	EndIf
	ODS_PathoAlias al = PathoAlias(i)
	If al == None
		PathoNote("pathogen: " + a.GetDisplayName() + " NOT infected: alias Infected" + (i + 1) + " missing or without its ODS_PathoAlias script")
		return
	EndIf
	kPatho[i] = a
	iPathoKind[i] = kind
	iPathoStage[i] = 0
	fPathoStart[i] = Utility.GetCurrentGameTime()
	kPathoRace[i] = None
	kPathoSkin[i] = None
	bPathoSkinSwap[i] = false
	bPathoFirst[i] = false
	bPathoChanged[i] = false
	bPathoBusy[i] = false
	fPathoCD[i] = 0.0
	iPathoMode[i] = 0
	kPathoSrc[i] = src
	iPathoWhy[i] = 0
	al.ForceRefTo(a)
	al.Watch(CurePotion())
	string sn = NameOf(src)
	string an = a.GetDisplayName()
	StorageUtil.SetStringValue(a, "ODS_BeastFrom", sn)
	If gift
		StorageUtil.SetIntValue(a, "ODS_BloodGift", 1)
		iPathoStage[i] = 3
		PathoNote("pathogen: " + an + " took the blood gift (" + DiseaseWord(kind) + ") from " + sn)
		PathoTurn(i)
		If bPathoNotify && !bDebug
			Debug.Notification(ODS_Text.T("patho.note_gift", "{an} took your blood gift.", "", an))
		EndIf
		return
	EndIf
	If instant
		iPathoStage[i] = 3
		PathoNote("pathogen: " + an + " infected with " + DiseaseWord(kind) + " by " + sn + " and turned at once (no incubation)")
		PathoTurn2(i, true)
		If bPathoNotify && !bDebug
			If src == PlayerRef
				Debug.Notification(ODS_Text.T("patho.note_instant_you", "{an} took your {x1}.", "", an, "", "", DiseaseWord(kind), PronSubj(a), BeingWord(kind)))
			ElseIf src && (IsFollowerActor(a) || IsSpouse(a) || a.GetDistance(PlayerRef) < 3000.0)
				Debug.Notification(ODS_Text.T("patho.note_instant_npc", "{an} took {x1} from {x2}.", "", an, "", "", DiseaseWord(kind), sn, BeingWord(kind)))
			EndIf
		EndIf
		If bMaster
			ScheduleGameTime()
		EndIf
		return
	EndIf
	StorageUtil.SetIntValue(a, "ODS_PathoIn", kind)
	string t
	If kind == 2
		t = ODS_Text.T("patho.infect_vampire", "{x1} infected {an} with vampirism.", "", an, "", "", sn)
	Else
		t = ODS_Text.T("patho.infect_beast", "{x1} infected {an} with {x3}.", "", an, "", "", sn, BeingWord(kind), DiseaseWord(kind))
	EndIf
	TalkNet(t, a, src, true, true)
	PathoNote("pathogen: " + an + " infected with " + DiseaseWord(kind) + " by " + sn + " (incubating; turns in about 3 game days)")
	If bPathoNotify && !bDebug
		If src == PlayerRef
			Debug.Notification(ODS_Text.T("patho.note_caught_you", "{an} caught {x1} from you.", "", an, "", "", DiseaseWord(kind)))
		ElseIf src && (IsFollowerActor(a) || IsSpouse(a) || a.GetDistance(PlayerRef) < 3000.0)
			Debug.Notification(ODS_Text.T("patho.note_caught_npc", "{an} caught {x1} from {x2}.", "", an, "", "", DiseaseWord(kind), sn))
		EndIf
	EndIf
	If bMaster
		ScheduleGameTime()
	EndIf
EndFunction

Potion Function CurePotion()
	return Game.GetFormFromFile(0x000AE723, "Skyrim.esm") as Potion      ; Potion of Cure Disease
EndFunction

float Function PathoNextDue()
	If !kPatho || !bMaster
		return -1.0
	EndIf
	float due = -1.0
	int i = 0
	While i < 10
		If kPatho[i] && iPathoStage[i] < 3
			float d = fPathoStart[i] + (iPathoStage[i] + 1) as float
			If due < 0.0 || d < due
				due = d
			EndIf
		EndIf
		i += 1
	EndWhile
	If iPlayerPatho > 0 && iPlayerPathoStage < 3
		float pd = fPlayerPathoStart + (iPlayerPathoStage + 1) as float
		If due < 0.0 || pd < due
			due = pd
		EndIf
	EndIf
	return due
EndFunction

Function PathoTick()
	PathoInitArrays()
	float now = Utility.GetCurrentGameTime()
	Potion cure = CurePotion()
	int i = 0
	While i < 10
		Actor a = kPatho[i]
		If a && iPathoStage[i] < 3
			If a.IsDeleted() || a.IsDead()
				PathoClear(i)
			ElseIf cure && a.GetItemCount(cure) > 0
				a.RemoveItem(cure, 1, true)
				PathoCure(i)
			ElseIf now >= fPathoStart[i] + (iPathoStage[i] + 1) as float
				int s = iPathoStage[i]
				While s < 3 && now >= fPathoStart[i] + (s + 1) as float
					s += 1
				EndWhile
				iPathoStage[i] = s
				If s >= 3
					PathoTurn(i)
				Else
					PathoSymptom(i)
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	If iPlayerPatho > 0 && iPlayerPathoStage < 3 && now >= fPlayerPathoStart + (iPlayerPathoStage + 1) as float
		int ps = iPlayerPathoStage
		While ps < 3 && now >= fPlayerPathoStart + (ps + 1) as float
			ps += 1
		EndWhile
		iPlayerPathoStage = ps
		If ps >= 3
			PathoPlayerTurn()
		Else
			PathoPlayerSymptom()
		EndIf
	EndIf
	PathoSyncGlobals()
EndFunction

Function PathoSymptom(int i)
	Actor a = kPatho[i]
	string pn = NameOf(kPathoSrc[i])
	string an = a.GetDisplayName()
	string t
	If iPathoKind[i] == 2
		If iPathoStage[i] == 1
			t = an + " feels weak and cold, daylight stings their eyes and food tastes of ash. It is the vampirism " + pn + " gave " + an + " through sex, taking hold."
		Else
			t = an + " cannot keep food down, the sun burns their skin and they keep staring at people's throats. The vampirism " + pn + " passed to " + an + " through sex has nearly turned them."
		EndIf
	ElseIf iPathoKind[i] == 3
		If iPathoStage[i] == 1
			t = an + " has a fever, sleeps like a stone and wakes ravenous, smelling honey, fish and blood. It is the werebear blood " + pn + " gave " + an + " through sex, taking hold."
		Else
			t = an + " dreamed of a huge, heavy body crashing through the snow, and feels something enormous stirring inside. The werebear blood " + pn + " passed to " + an + " through sex has nearly finished with them."
		EndIf
	Else
		If iPathoStage[i] == 1
			t = an + " has a fever, sweats through the night and keeps smelling blood and raw meat. It is the lycanthropy " + pn + " gave " + an + " through sex, taking hold."
		Else
			t = an + " dreamed of running on all fours and tearing into prey, and feels something wild clawing inside. The lycanthropy " + pn + " passed to " + an + " through sex has nearly finished with them."
		EndIf
	EndIf
	TalkNet(t, a, kPathoSrc[i], true, true)
EndFunction

Function PathoTurn(int i)
	PathoTurn2(i, false)
EndFunction

string Function PronSubj(Actor a)
	If a && a.GetActorBase().GetSex() == 1
		return "She"
	EndIf
	return "He"
EndFunction

string Function PronObj(Actor a)
	If a && a.GetActorBase().GetSex() == 1
		return "her"
	EndIf
	return "him"
EndFunction

string Function PronPoss(Actor a)
	If a && a.GetActorBase().GetSex() == 1
		return "her"
	EndIf
	return "his"
EndFunction

; 1.1.1: what the one who caught it through sex feels, in plain words (SkyrimNet event + memory)
string Function PathoSexTurnText(Actor a, Actor src, int kind)
	string an = NameOf(a)
	string pn = NameOf(src)
	string t = ODS_Text.T("patho.sex_turn", "{an} became {vn}", "", an, BeingWord(kind), "", pn, PronPoss(a), PronObj(a))
	If kind == 2
		t += " " + ODS_Text.T("patho.sex_turn_vl", "(a vampire lord)")
	EndIf
	t += ". " + ODS_Text.T("patho.sex_turn_end", "{x1} was {x2}; {an} is {vn} now.", "", an, BeingWord(kind), "", pn, PathoCarrierWord(kind))
	If kind == 2
		t += " " + ODS_Text.T("patho.sex_turn_vl_sun", "Sunlight burns {x1}.", "", "", "", "", PronObj(a), PronSubj(a))
	EndIf
	return t
EndFunction

string Function PathoCarrierWord(int kind)
	If kind == 2
		return "a vampire lord"
	EndIf
	return BeingWord(kind)
EndFunction

Function PathoTurn2(int i, bool sexNow)
	Actor a = kPatho[i]
	Actor src = kPathoSrc[i]
	string pn = NameOf(src)
	string an = a.GetDisplayName()
	int kind = iPathoKind[i]
	bool gift = StorageUtil.GetIntValue(a, "ODS_BloodGift", 0) > 0
	string how = "through sex"
	If gift
		how = "with a blood gift " + an + " accepted"
	EndIf
	string t
	If kind == 2
		Faction vf = Game.GetFormFromFile(0x00027242, "Skyrim.esm") as Faction
		If vf
			a.AddToFaction(vf)
		EndIf
		Spell sun = Game.GetFormFromFile(0x000F5B5D, "Skyrim.esm") as Spell    ; crVampireSunDamage (NPC vampires)
		If sun
			a.AddSpell(sun, false)
		EndIf
		PathoVampirize(a)              ; 1.1.5: VampireVampirism; Sacrosanct-style extras when it is installed
		t = an + " is now a vampire. " + pn + " gave " + an + " vampirism " + how + ", and " + an + " knows it was " + pn + ". Sunlight burns " + an + " now and they hunger for blood."
	Else
		Faction wf = Game.GetFormFromFile(0x00043594, "Skyrim.esm") as Faction
		If wf
			a.AddToFaction(wf)
		EndIf
		Spell gs = GrowlNPCSpell()
		bool given = false
		If gs && (gift || (sexNow && (IsFollowerActor(a) || IsSpouse(a))) || (a.IsInFaction(CurrentFollowerFaction) && a.GetFactionRank(CurrentFollowerFaction) >= 0))
			a.AddSpell(gs, false)          ; Growl's own companion beastblood: Growl handles its fight changes
			iPathoMode[i] = 1
			given = true
		EndIf
		PathoGrowlDecision(a, kind, given)     ; 1.1.5: log who owns what (Growl follows its werebear totem)
		t = an + " is now " + BeingWord(kind) + ". " + pn + " gave " + an + " the beast blood " + how + ", and " + an + " knows it was " + pn + "."
	EndIf
	If sexNow
		t = PathoSexTurnText(a, src, kind)
	EndIf
	If bPathoSNetForms
		t += " " + an + " can change into a " + FormWord(kind) + " in full beast form at will, and back."
	EndIf
	StorageUtil.UnsetIntValue(a, "ODS_PathoIn")
	StorageUtil.SetIntValue(a, "ODS_BeastKind", kind)
	TalkNet(t, a, src, true, true)
	If SNetOK()
		SkyrimNetApi.UpdateActorDynamicBio(a)
	EndIf
	PathoNote("pathogen: " + an + " turned (" + DiseaseWord(kind) + ", mode " + iPathoMode[i] + ")")
EndFunction

Function PathoCure(int i)
	Actor a = kPatho[i]
	If a
		TalkNet(a.GetDisplayName() + " drank a Cure Disease potion. The " + DiseaseWord(iPathoKind[i]) + " " + NameOf(kPathoSrc[i]) + " gave " + a.GetDisplayName() + " through sex is gone before it could take hold.", a, kPathoSrc[i], true, true)
	EndIf
	PathoClear(i)
EndFunction

Function PathoSetKeys(int i)
	Actor a = kPatho[i]
	If a == None
		return
	EndIf
	If iPathoStage[i] >= 3
		StorageUtil.UnsetIntValue(a, "ODS_PathoIn")
		StorageUtil.SetIntValue(a, "ODS_BeastKind", iPathoKind[i])
	Else
		StorageUtil.SetIntValue(a, "ODS_PathoIn", iPathoKind[i])
	EndIf
	If bPathoChanged[i] && IsBeastForm(a)
		StorageUtil.SetIntValue(a, "ODS_BeastForm", 1)
	Else
		StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
	EndIf
	If kPathoSrc[i]
		StorageUtil.SetStringValue(a, "ODS_BeastFrom", NameOf(kPathoSrc[i]))
	EndIf
	StorageUtil.UnsetIntValue(a, "ODS_GrowlOwned")      ; 1.1.4: retired (1.1.3 key), O'Deadly handles Growl followers too
EndFunction

Function PathoUnsetKeys(Actor a)
	If a
		StorageUtil.UnsetIntValue(a, "ODS_PathoIn")
		StorageUtil.UnsetIntValue(a, "ODS_BeastKind")
		StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
		StorageUtil.UnsetIntValue(a, "ODS_BloodGift")
		StorageUtil.UnsetStringValue(a, "ODS_BeastFrom")
		StorageUtil.UnsetIntValue(a, "ODS_GrowlOwned")
	EndIf
EndFunction

Function PathoClear(int i)
	ODS_PathoAlias al = PathoAlias(i)
	If al
		al.Halt()
		al.Clear()
	EndIf
	If kPatho[i] && kPatho[i].IsDead() && IsBeastForm(kPatho[i]) && bPathoSkinSwap[i]
		bPathoSkinSwap[i] = false      ; 1.1.3: died in beast form, the body keeps the beast skin
		kPathoSkin[i] = None
		Log("skin: " + NameOf(kPatho[i]) + ": died in beast form, beast skin kept on the body")
	Else
		PathoSkinRestore(i, kPatho[i], "cleared")      ; 1.1.3: give the NPC its own skin back
	EndIf
	PathoUnsetKeys(kPatho[i])
	kPatho[i] = None
	iPathoKind[i] = 0
	iPathoStage[i] = 0
	kPathoRace[i] = None
	bPathoFirst[i] = false
	bPathoChanged[i] = false
	bPathoBusy[i] = false
	iPathoMode[i] = 0
	kPathoSrc[i] = None
	iPathoWhy[i] = 0
	If bPathoLore.Length == 10
		bPathoLore[i] = false
	EndIf
EndFunction

; alias: a Cure Disease potion was handed over during incubation
Function PathoItem(int i, Actor a, Form item)
	If i < 0 || i >= 10 || !kPatho || kPatho[i] != a || a == None || iPathoStage[i] >= 3
		return
	EndIf
	Potion cure = CurePotion()
	If cure && item == cure && a.GetItemCount(cure) > 0
		a.RemoveItem(cure, 1, true)
		PathoCure(i)
	EndIf
EndFunction

Function PathoDied(int i, Actor a)
	If i >= 0 && i < 10 && kPatho && kPatho[i] == a
		PathoClear(i)
	EndIf
EndFunction

; ---------- beast form of infected NPCs (1.1) ----------
; why: 1 asked / chose to (stays until asked back), 2 for a fight (back once the fight is over)
bool Function PathoChangeTo(int i, int why)
	Actor a = kPatho[i]
	If a == None || iPathoStage[i] < 3 || bPathoChanged[i] || IsBeastForm(a)
		return false
	EndIf
	Race r = BeastRaceFor(iPathoKind[i])
	If r == None
		return false
	EndIf
	If a.GetSitState() != 0
		Debug.SendAnimationEvent(a, "IdleForceDefaultState")
	EndIf
	bPathoBusy[i] = true
	kPathoRace[i] = a.GetRace()
	bPathoChanged[i] = true
	iPathoWhy[i] = why
	PathoSkinSwap(i, a, r, "change")       ; 1.1.3: before SetRace, so the new 3D uses the beast skin
	bPathoRaceSetting = true
	a.SetRace(r)
	bPathoRaceSetting = false
	a.QueueNiNodeUpdate()
	StorageUtil.SetIntValue(a, "ODS_BeastForm", 1)
	Log("pathogen: " + a.GetDisplayName() + " changed into a " + FormWord(iPathoKind[i]) + " (reason " + why + ")")
	return true
EndFunction

; alias: combat state changed. Night fights: an infected werewolf / werebear may change by itself.
; 1.1: no timer. Changed for this fight: back once it is over (the alias waits a few seconds and
; checks again). Changed because asked: stays until asked back.
Function PathoCombat(int i, Actor a, int st)
	If i < 0 || i >= 10 || !kPatho || a == None || kPatho[i] != a
		return
	EndIf
	If iPathoStage[i] >= 3 && iPathoKind[i] != 2
		ODS_PathoAlias alc = PathoAlias(i)
		If alc
			alc.RevertIn(6.0)      ; 1.1.4: one look a few seconds later (a Growl change takes a moment); also the old after-fight revert
		EndIf
	EndIf
	If st == 0
		If bPathoChanged[i] && iPathoWhy[i] == 2
			ODS_PathoAlias al0 = PathoAlias(i)
			If al0
				al0.RevertIn(4.0)
			EndIf
		EndIf
		return
	EndIf
	If bPathoChanged[i]
		return
	EndIf
	If bPathoLore.Length == 10 && bPathoLore[i]
		return            ; 1.1.8: lore beasts only change when asked, never mid-fight on their own
	EndIf
	If !bPatho || !bMaster || !bPathoTransform || iPathoKind[i] == 2 || iPathoStage[i] < 3 || iPathoMode[i] != 0
		return
	EndIf
	If bPathoBusy[i] || IsBeastForm(a) || !IsNight()
		return
	EndIf
	If Utility.GetCurrentRealTime() < fPathoCD[i]
		return
	EndIf
	If a.IsDead() || a.IsBleedingOut() || a.GetSitState() != 0 || a.GetSleepState() != 0 || a.IsOnMount() || OActor.IsInOStim(a) || IsStaged(a)
		return
	EndIf
	Spell gs = GrowlNPCSpell()
	If gs && a.HasSpell(gs)
		return            ; Growl owns this one
	EndIf
	If PathoAlias(i) == None || !PathoChangeTo(i, 2)
		return
	EndIf
	If !bPathoFirst[i]
		bPathoFirst[i] = true
		string pn = NameOf(kPathoSrc[i])
		string an = a.GetDisplayName()
		TalkNet(an + " just turned into a " + FormWord(iPathoKind[i]) + " for the first time, in full beast form, in the middle of a fight. The beast blood came from " + pn + ", and " + an + " knows it.", a, kPathoSrc[i], true, true)
	EndIf
EndFunction

; alias single update (only after a fight ended): back if still out of combat
Function PathoAliasUpdate(int i)
	If i < 0 || i >= 10 || !kPatho
		return
	EndIf
	Actor a = kPatho[i]
	PathoSkinCheck(i, a, "check")       ; 1.1.4: a Growl change during / after the fight
	If a && bPathoChanged[i] && iPathoWhy[i] == 2 && !a.IsInCombat()
		PathoRevert(i)
	EndIf
EndFunction

Function PathoRevert(int i)
	If i < 0 || i >= 10 || !kPatho
		return
	EndIf
	Actor a = kPatho[i]
	bool fight = iPathoWhy[i] == 2
	If a && bPathoChanged[i]
		Race r = kPathoRace[i]
		PathoSkinRestore(i, a, "change back")      ; 1.1.3: own skin back before the race, so the new 3D uses it
		If r && IsBeastForm(a)
			bPathoRaceSetting = true
			a.SetRace(r)
			bPathoRaceSetting = false
			a.QueueNiNodeUpdate()
			a.EvaluatePackage()
		EndIf
		StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
	EndIf
	bPathoChanged[i] = false
	bPathoBusy[i] = false
	iPathoWhy[i] = 0
	If fight
		fPathoCD[i] = Utility.GetCurrentRealTime() + 90.0
	Else
		fPathoCD[i] = 0.0
	EndIf
EndFunction

Function PathoRevertAll()
	VLFRevertAll()           ; 1.1.5: vampire followers changed into vampire lords
	If !kPatho
		return
	EndIf
	PathoInitArrays()
	int i = 0
	While i < 10
		If bPathoChanged[i]
			PathoRevert(i)
		ElseIf bPathoSkinSwap[i]
			PathoSkinRestore(i, kPatho[i], "revert all")
		EndIf
		bPathoBusy[i] = false
		fPathoCD[i] = 0.0
		i += 1
	EndWhile
EndFunction

; ---------- SkyrimNet actions (YAML in coronerra.odeadly/actions; run on the Papyrus VM, short) ----------
Function SNTransformToBeast(Actor akSpeaker)
	int i = PathoIndex(akSpeaker)
	bool loreOK = i >= 0 && bPathoLore.Length == 10 && bPathoLore[i] && bLoreBeasts && BeastFormOK()
	If i < 0 || iPathoStage[i] < 3 || !bMaster || !bPathoSNetForms || (!bPatho && !loreOK)
		Log("SkyrimNet action TransformToBeast (" + NameOf(akSpeaker) + ") ignored: not turned by this mod, or pathogen / master / 'change at will' off")
		return
	EndIf
	Log("SkyrimNet action TransformToBeast: " + NameOf(akSpeaker) + PathoGrowlTag(i) + " -> " + FormWord(iPathoKind[i]) + " " + FormText(BeastRaceFor(iPathoKind[i])) + " (O'Deadly owns SkyrimNet changes; Growl " + GrowlTotemText() + ")")
	If akSpeaker.IsDead() || akSpeaker.IsOnMount() || OActor.IsInOStim(akSpeaker) || IsStaged(akSpeaker)
		Log("pathogen: " + akSpeaker.GetDisplayName() + " could not change now (mount, scene or staged)")
		return
	EndIf
	int why = 1
	If akSpeaker.IsInCombat()
		why = 2
	EndIf
	PathoChangeTo(i, why)
EndFunction

Function SNTransformBack(Actor akSpeaker)
	int i = PathoIndex(akSpeaker)
	If i < 0 && VLFBack(akSpeaker)
		return             ; 1.1.5: an existing vampire follower back from vampire lord
	EndIf
	; 1.1.4: changed by Growl (or anything else) with a known normal race: O'Deadly takes it over and changes them back
	If i >= 0 && !bPathoChanged[i] && IsBeastForm(akSpeaker) && kPathoRace[i] && !IsBeastRace(kPathoRace[i]) && !OActor.IsInOStim(akSpeaker)
		bPathoChanged[i] = true
		iPathoWhy[i] = 1
		Log("SkyrimNet action TransformBack: " + NameOf(akSpeaker) + " is in beast form from another mod" + PathoGrowlTag(i) + ", back to " + FormText(kPathoRace[i]))
	EndIf
	If i >= 0 && bPathoChanged[i] && !OActor.IsInOStim(akSpeaker)
		Log("SkyrimNet action TransformBack: " + NameOf(akSpeaker))
		PathoRevert(i)
	Else
		Log("SkyrimNet action TransformBack (" + NameOf(akSpeaker) + ") ignored: not changed by this mod, or in a scene")
	EndIf
EndFunction

; the speaker accepts YOUR blood gift
Function SNAcceptBloodGift(Actor akSpeaker)
	Log("SkyrimNet action AcceptBloodGift: " + NameOf(akSpeaker))
	PathoGiftTo(akSpeaker, true)
EndFunction

; an infected NPC gives YOU their blood gift
Function SNGiveBloodGift(Actor akSpeaker)
	If !bPatho || !bMaster || akSpeaker == None
		Log("SkyrimNet action GiveBloodGift ignored: pathogen or master off")
		return
	EndIf
	int i = PathoIndex(akSpeaker)
	If i < 0 || iPathoStage[i] < 3
		Log("SkyrimNet action GiveBloodGift (" + NameOf(akSpeaker) + ") ignored: not turned by this mod yet")
		return
	EndIf
	Log("SkyrimNet action GiveBloodGift: " + NameOf(akSpeaker))
	string why = PathoPlayerWhyNot(true)
	If why != ""
		PathoNote("pathogen: blood gift from " + akSpeaker.GetDisplayName() + " not taken: " + why)
		return
	EndIf
	PathoPlayerInfect(iPathoKind[i], akSpeaker, true)
EndFunction

bool Function PathoGiftTo(Actor a, bool viaNet)
	If !bPatho || !bMaster || a == None
		return false
	EndIf
	int kind = PlayerDiseaseKind()
	If kind == 0
		PathoNote("pathogen: no blood gift: you are not a werewolf, vampire or werebear")
		return false
	EndIf
	string why = PathoWhyNot2(a, true)
	If why != ""
		PathoNote("pathogen: " + a.GetDisplayName() + " can't take the blood gift: " + why)
		If !viaNet
			Debug.Notification(a.GetDisplayName() + " can't take your blood gift: " + why)
		EndIf
		return false
	EndIf
	PathoInfect(a, kind, PlayerRef, true)
	return true
EndFunction

; blood gift key: the adult in your crosshair, after a yes / no box
Function BloodGiftKey()
	If !bPatho || !bMaster || Utility.IsInMenuMode()
		return
	EndIf
	Actor a = Game.GetCurrentCrosshairRef() as Actor
	If a == None || a == PlayerRef
		Debug.Notification("Blood gift: look at the person first.")
		return
	EndIf
	If PlayerDiseaseKind() == 0
		Debug.Notification("Blood gift: you are not a werewolf, vampire or werebear.")
		return
	EndIf
	string why = PathoWhyNot2(a, true)
	If why != ""
		Debug.Notification(a.GetDisplayName() + " can't take your blood gift: " + why)
		return
	EndIf
	If ODS_BloodGiftChoice && ODS_BloodGiftChoice.Show() != 0
		return
	EndIf
	PathoGiftTo(a, false)
EndFunction

; ---------- you (1.1) ----------
Function PathoPlayerInfect(int kind, Actor src, bool gift)
	PathoPlayerInfect2(kind, src, gift, false)
EndFunction

; 1.1.1: instant = caught through sex from a werewolf / werebear (any form) or a vampire lord: no incubation
Function PathoPlayerInfect2(int kind, Actor src, bool gift, bool instant)
	string sn = NameOf(src)
	string pn = PlayerName()
	If kind == 2 && instant && !gift
		PathoNote("pathogen: you caught vampirism from " + sn + " (a vampire lord) and turned at once")
		ODS_Vamp.TurnPlayerLord(PlayerRef)
		TalkNet(PathoSexTurnText(PlayerRef, src, 2), PlayerRef, src, true, true)
		If bPathoNotify
			Debug.Notification("Burning blood. You are a vampire now - " + sn + " gave it to you.")
		EndIf
		UpdateWatchers()
		PathoSyncGlobals()
		return
	EndIf
	If kind == 2
		Spell sv = Game.GetFormFromFile(0x000B8780, "Skyrim.esm") as Spell      ; DiseaseSanguinareVampiris: vanilla three days
		If sv
			PlayerRef.AddSpell(sv, false)
		EndIf
		TalkNet(sn + " is a vampire and gave " + pn + " Sanguinare Vampiris " + PathoHow(gift) + ". " + pn + " will turn into a vampire in about three days unless it is cured.", PlayerRef, src, true, true)
		PathoNote("pathogen: you caught vampirism from " + sn)
		If bPathoNotify
			Debug.Notification("You caught Sanguinare Vampiris from " + sn + ".")
		EndIf
		PathoSyncGlobals()
		return
	EndIf
	iPlayerPatho = kind
	iPlayerPathoStage = 0
	fPlayerPathoStart = Utility.GetCurrentGameTime()
	kPlayerPathoSrc = src
	If gift
		iPlayerPathoStage = 3
		PathoNote("pathogen: you took the blood gift (" + DiseaseWord(kind) + ") from " + sn)
		PathoPlayerTurn()
		return
	EndIf
	If instant
		iPlayerPathoStage = 3
		PathoNote("pathogen: you caught " + DiseaseWord(kind) + " from " + sn + " and turned at once (no incubation)")
		PathoPlayerTurn2(true)
		return
	EndIf
	TalkNet(sn + " is " + BeingWord(kind) + ", and during sex " + sn + " infected " + pn + " with " + DiseaseWord(kind) + ". The beast blood is in " + pn + " now.", PlayerRef, src, true, true)
	PathoNote("pathogen: you caught " + DiseaseWord(kind) + " from " + sn + " (turns in about 3 game days; a Cure Disease potion stops it)")
	If bPathoNotify
		Debug.Notification("You caught " + DiseaseWord(kind) + " from " + sn + ".")
	EndIf
	UpdateWatchers()
	If bMaster
		ScheduleGameTime()
	EndIf
EndFunction

string Function PathoHow(bool gift)
	If gift
		return "with a blood gift"
	EndIf
	return "through sex"
EndFunction

Function PathoPlayerSymptom()
	string pn = PlayerName()
	string t
	If iPlayerPatho == 3
		t = pn + " has a fever, sleeps like a stone and wakes ravenous. The werebear blood from " + NameOf(kPlayerPathoSrc) + " is taking hold."
		Debug.Notification("You feel feverish and ravenous.")
	Else
		t = pn + " has a fever and keeps smelling blood and raw meat. The lycanthropy from " + NameOf(kPlayerPathoSrc) + " is taking hold."
		Debug.Notification("You feel feverish. You smell blood everywhere.")
	EndIf
	TalkNet(t, PlayerRef, kPlayerPathoSrc, true, true)
EndFunction

; vanilla Beast Form power + PlayerIsWerewolf. With Growl a werebear is chosen in Growl itself.
Function PathoPlayerTurn()
	PathoPlayerTurn2(false)
EndFunction

Function PathoPlayerTurn2(bool sexNow)
	Spell bf = Game.GetFormFromFile(0x00092C48, "Skyrim.esm") as Spell
	If bf && !PlayerRef.HasSpell(bf)
		PlayerRef.AddSpell(bf, false)
	EndIf
	GlobalVariable g = Game.GetFormFromFile(0x000ED06C, "Skyrim.esm") as GlobalVariable
	If g
		g.SetValue(1.0)
	EndIf
	string pn = PlayerName()
	string sn = NameOf(kPlayerPathoSrc)
	If sexNow
		TalkNet(PathoSexTurnText(PlayerRef, kPlayerPathoSrc, iPlayerPatho), PlayerRef, kPlayerPathoSrc, true, true)
	Else
		TalkNet(pn + " is now " + BeingWord(iPlayerPatho) + ". The beast blood came from " + sn + ".", PlayerRef, kPlayerPathoSrc, true, true)
	EndIf
	If iPlayerPatho == 3 && ModLoaded("Growl - Werebeasts of Skyrim.esp")
		Debug.Notification("The beast blood has taken you. (Growl: choose the werebear path there.)")
	Else
		Debug.Notification("The beast blood has taken you. You can change into a werewolf.")
	EndIf
	PathoNote("pathogen: you turned (" + DiseaseWord(iPlayerPatho) + ")")
	UpdateWatchers()
	PathoSyncGlobals()
EndFunction

; ODS_PlayerAlias: you drank something while incubating
bool Function PathoPlayerDrank(Form f)
	If iPlayerPatho <= 0 || iPlayerPathoStage >= 3 || f == None || f != CurePotion()
		return false
	EndIf
	TalkNet(PlayerName() + " drank a Cure Disease potion. The " + DiseaseWord(iPlayerPatho) + " from " + NameOf(kPlayerPathoSrc) + " is gone before it could take hold.", PlayerRef, kPlayerPathoSrc, true, true)
	Debug.Notification("The fever breaks. The beast blood is gone.")
	PathoNote("pathogen: your incubating " + DiseaseWord(iPlayerPatho) + " was cured")
	iPlayerPatho = 0
	iPlayerPathoStage = 0
	kPlayerPathoSrc = None
	UpdateWatchers()
	PathoSyncGlobals()
	return true
EndFunction

bool Function PathoPlayerIncubating()
	return iPlayerPatho > 0 && iPlayerPathoStage < 3
EndFunction

; StorageUtil values SkyrimNet reads with papyrus_util (no Papyrus runs while a prompt renders)
Function PathoSyncGlobals()
	If bVLFollowers && bMaster && VampireLordRace() != None
		StorageUtil.SetIntValue(None, "ODS_VLFOn", 1)       ; 1.1.5: SkyrimNet BecomeVampireLord
	Else
		StorageUtil.UnsetIntValue(None, "ODS_VLFOn")
	EndIf
	; 1.1.8: lore beasts can use TransformToBeast even when Blood Born Pathogen is off
	If bMaster && bPathoSNetForms && (bPatho || (bLoreBeasts && BeastFormOK()))
		StorageUtil.SetIntValue(None, "ODS_FormsOn", 1)
	Else
		StorageUtil.UnsetIntValue(None, "ODS_FormsOn")
	EndIf
	If bPatho && bMaster
		StorageUtil.SetIntValue(None, "ODS_PathoOn", 1)
		int k = 0
		If PlayerHasLycanthropy() || PlayerHasVampirism()
			k = PlayerDiseaseKind()
		EndIf
		If k > 0
			StorageUtil.SetIntValue(None, "ODS_PlayerBlood", k)
		Else
			StorageUtil.UnsetIntValue(None, "ODS_PlayerBlood")
		EndIf
	Else
		StorageUtil.UnsetIntValue(None, "ODS_PathoOn")
		StorageUtil.UnsetIntValue(None, "ODS_PlayerBlood")
	EndIf
EndFunction

; game loaded: beasts who changed for a fight that is over change back; asked-for forms stay
; ---------- 1.1.3: beast skin swap for NPCs with their own skin ----------
; Uses the leveled base (what the game draws for templated NPCs; the same base for unique ones).
; SKSE ActorBase.SetSkin is not written to the save, so PathoSkinOnLoad redoes it after a load.
ActorBase Function PathoSkinBase(Actor a)
	If a == None
		return None
	EndIf
	ActorBase ab = a.GetLeveledActorBase()
	If ab == None
		ab = a.GetActorBase()
	EndIf
	return ab
EndFunction

string Function FormText(Form f)
	If f == None
		return "none"
	EndIf
	return "" + f
EndFunction

Function PathoSkinSwap(int i, Actor a, Race r, string why)
	If a == None || r == None || i < 0 || i >= 10
		return
	EndIf
	PathoInitArrays()
	ActorBase ab = PathoSkinBase(a)
	If ab == None
		Log("skin: " + NameOf(a) + ": no actor base, skin left alone (" + why + ")")
		return
	EndIf
	Armor beast = r.GetSkin()
	Armor own = ab.GetSkin()
	If bPathoSkinSwap[i]
		If own != beast
			ab.SetSkin(beast)
			Log("skin: " + NameOf(a) + ": beast skin " + FormText(beast) + " put back on (" + why + ")")
		EndIf
		return
	EndIf
	If own == None || own == beast
		If why != "check"
			Log("skin: " + NameOf(a) + ": no own skin (uses the race skin), nothing to swap (" + why + ")")
		EndIf
		return
	EndIf
	kPathoSkin[i] = own
	bPathoSkinSwap[i] = true
	ab.SetSkin(beast)
	Log("skin: " + NameOf(a) + ": own skin " + FormText(own) + " saved, beast race " + FormText(r) + " skin " + FormText(beast) + " swapped in (" + why + ")")
EndFunction

Function PathoSkinRestore(int i, Actor a, string why)
	If i < 0 || i >= 10
		return
	EndIf
	PathoInitArrays()
	If !bPathoSkinSwap[i]
		return
	EndIf
	Armor own = kPathoSkin[i]
	bPathoSkinSwap[i] = false
	kPathoSkin[i] = None
	ActorBase ab = PathoSkinBase(a)
	If ab && own
		ab.SetSkin(own)
		Log("skin: " + NameOf(a) + ": own skin " + FormText(own) + " given back (" + why + ")")
	Else
		Log("skin: " + NameOf(a) + ": swap flag cleared, nothing to give back (" + why + ")")
	EndIf
EndFunction

; 1.1.4: called on game load, on the alias's race switch / 3D load, and once a few seconds after a combat
; change. Beast race by any path (O'Deadly, Growl's beastblood, vanilla change) + own skin: beast skin on.
; Normal race again: own skin back and the normal race remembered (so TransformBack can undo a Growl change).
Function PathoSkinCheck(int i, Actor a, string why)
	If i < 0 || i >= 10 || a == None
		return
	EndIf
	PathoInitArrays()
	If kPatho[i] != a || a.IsDead()
		return
	EndIf
	If IsBeastForm(a)
		bool had = bPathoSkinSwap[i]
		PathoSkinSwap(i, a, a.GetRace(), why)
		If bPathoSkinSwap[i] && (!had || why == "game load")
			a.QueueNiNodeUpdate()
		EndIf
		If !bPathoChanged[i] && !had && bPathoSkinSwap[i]
			Log("skin: " + NameOf(a) + " is in beast form from another mod" + PathoGrowlTag(i) + " (" + why + ")")
		EndIf
		StorageUtil.SetIntValue(a, "ODS_BeastForm", 1)
	Else
		If !bPathoChanged[i]
			kPathoRace[i] = a.GetRace()
		EndIf
		If bPathoSkinSwap[i]
			PathoSkinRestore(i, a, why + ", normal race again")
			a.QueueNiNodeUpdate()
		EndIf
		If bPathoChanged[i] && !bPathoRaceSetting
			bPathoChanged[i] = false      ; changed back by something else (Growl, a spell)
			bPathoBusy[i] = false
			iPathoWhy[i] = 0
			Log("skin: " + NameOf(a) + ": changed back by another mod (" + why + ")")
		EndIf
		StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
	EndIf
EndFunction

string Function PathoGrowlTag(int i)
	If iPathoMode[i] == 1
		return " (Growl beastblood)"
	EndIf
	return ""
EndFunction

bool Function IsBeastRace(Race r)
	If r == None
		return false
	EndIf
	return r == WerewolfRace() || r == VampireLordRace() || r == WerebearRace()
EndFunction

Function PathoSkinOnLoad()
	PathoInitArrays()
	If !kPatho
		return
	EndIf
	int i = 0
	While i < 10
		If kPatho[i]
			PathoSkinCheck(i, kPatho[i], "game load")   ; 1.1.4: any beast form (O'Deadly, Growl or other), also 1.1.2 saves
		ElseIf bPathoSkinSwap[i]
			bPathoSkinSwap[i] = false
			kPathoSkin[i] = None
		EndIf
		i += 1
	EndWhile
EndFunction

Function PathoOnLoad()
	PathoInitArrays()
	int t = 0
	While t < 4
		iPTId[t] = 0
		t += 1
	EndWhile
	PathoSyncGlobals()
	If !kPatho
		return
	EndIf
	Potion cure = CurePotion()
	bool any = false
	int i = 0
	While i < 10
		If kPatho[i]
			any = true
			PathoSetKeys(i)          ; 1.1: SkyrimNet values (also for NPCs infected under 1.0.x)
			If bPathoChanged[i] && (iPathoWhy[i] != 1 || !IsBeastForm(kPatho[i]))
				If !kPatho[i].IsInCombat() || !IsBeastForm(kPatho[i])
					PathoRevert(i)
				EndIf
			EndIf
		ElseIf bPathoChanged[i]
			bPathoChanged[i] = false
		EndIf
		bPathoBusy[i] = bPathoChanged[i]
		i += 1
	EndWhile
	If any && ODS_PathoQuest
		If !ODS_PathoQuest.IsRunning()
			ODS_PathoQuest.Start()
		EndIf
		i = 0
		While i < 10
			ODS_PathoAlias al = PathoAlias(i)
			If kPatho[i] && al
				If al.GetActorReference() != kPatho[i]
					al.ForceRefTo(kPatho[i])
				EndIf
				al.Watch(cure)
			EndIf
			i += 1
		EndWhile
	EndIf
EndFunction

; MCM: take everything this mod gave back (also before uninstalling)
Function PathoCureAll()
	If !kPatho
		return
	EndIf
	PathoRevertAll()
	Faction wf = Game.GetFormFromFile(0x00043594, "Skyrim.esm") as Faction
	Faction vf = Game.GetFormFromFile(0x00027242, "Skyrim.esm") as Faction
	Spell sun = Game.GetFormFromFile(0x000F5B5D, "Skyrim.esm") as Spell
	Spell gs = GrowlNPCSpell()
	int i = 0
	While i < 10
		Actor a = kPatho[i]
		If a && iPathoStage[i] >= 3 && !(bPathoLore.Length == 10 && bPathoLore[i])
			If iPathoKind[i] != 2
				If wf
					a.RemoveFromFaction(wf)
				EndIf
				If gs && iPathoMode[i] == 1
					a.RemoveSpell(gs)
				EndIf
			Else
				If vf
					a.RemoveFromFaction(vf)
				EndIf
				If sun
					a.RemoveSpell(sun)
				EndIf
				PathoUnvampirize(a)        ; 1.1.5
			EndIf
		EndIf
		If a
			PathoClear(i)
		EndIf
		i += 1
	EndWhile
	If iPlayerPatho > 0 && iPlayerPathoStage < 3
		iPlayerPatho = 0
		kPlayerPathoSrc = None
		UpdateWatchers()
	EndIf
	If ODS_PathoQuest && ODS_PathoQuest.IsRunning()
		ODS_PathoQuest.Stop()
	EndIf
	PathoSyncGlobals()
EndFunction

string Function PathoListText()
	If !kPatho
		return "nobody"
	EndIf
	string s = ""
	int i = 0
	While i < 10
		If kPatho[i]
			If s != ""
				s += ", "
			EndIf
			string st = "turned"
			If iPathoStage[i] < 3
				st = "incubating"
			ElseIf bPathoChanged[i]
				st = "turned, in beast form"
			EndIf
			If bPathoLore.Length == 10 && bPathoLore[i]
				st = "lore, " + st
			EndIf
			s += kPatho[i].GetDisplayName() + " (" + DiseaseWord(iPathoKind[i]) + ", " + st + ")"
		EndIf
		i += 1
	EndWhile
	If iPlayerPatho > 0 && iPlayerPathoStage < 3
		If s != ""
			s += ", "
		EndIf
		s += "you (" + DiseaseWord(iPlayerPatho) + ", incubating)"
	EndIf
	If s == ""
		return "nobody"
	EndIf
	return s
EndFunction

; =====================================================================================
; 1.0.2: pathogen diagnostics. Every result also goes to the MCM Debug page; while the debug
; force is armed it is shown on screen even without Debug notifications.
bool Property bLogFile = true Auto Hidden                ; 1.0.2: write Data/SKSE/Plugins/ODeadlySkyrim.log (PapyrusUtil MiscUtil)
string Property sPathoLast = "" Auto Hidden              ; 1.0.2: last pathogen result (MCM > Debug)
string Property LOG_FILE = "Data/SKSE/Plugins/ODeadlySkyrim.log" AutoReadOnly
bool Property bPathoAlways = false Auto Hidden           ; 1.1.1: always infect from a werewolf / werebear / vampire lord (no chance roll)

Function PathoNote(string s)
	Log(s)
	sPathoLast = s
	If bForcePatho && !(bDebug && bMaster)
		Debug.Notification("[ODS] " + s)
	EndIf
EndFunction

; =====================================================================================
; 1.1.2: own log file for bug reports (Data/SKSE/Plugins/ODeadlySkyrim.log, MO2: overwrite).
; PapyrusUtil soft dependency: without it nothing is written and nothing errors. Light: a header
; per game load, one line per event, no polling. The file restarts after LOG_SESSIONS game loads
; (counter in StorageUtilData/ODeadlySkyrim_log.json) and each session stops at LOG_LINES_MAX lines.
string Property ODS_VERSION = "1.2.0" AutoReadOnly
string Property LOG_STATE = "ODeadlySkyrim_log" AutoReadOnly
int Property LOG_SESSIONS = 10 AutoReadOnly
int Property LOG_LINES_MAX = 3000 AutoReadOnly
bool bLogPU = false
int iLogLines = 0

bool Function PapyrusUtilOK()
	return SKSE.GetPluginVersion("papyrusutil plugin") > 0
EndFunction

Function LogSessionStart()
	bLogPU = PapyrusUtilOK()
	iLogLines = 0
	If !bLogPU || !bLogFile
		return
	EndIf
	int n = JsonUtil.GetIntValue(LOG_STATE, "session", 0) + 1
	bool fresh = n > LOG_SESSIONS || !MiscUtil.FileExists(LOG_FILE)
	If fresh
		n = 1
	EndIf
	JsonUtil.SetIntValue(LOG_STATE, "session", n)
	JsonUtil.Save(LOG_STATE)
	string h = "===== O'Deadly Skyrim " + ODS_VERSION + " | game load " + n + " of " + LOG_SESSIONS + " in this file | game time " + Utility.GameTimeToString(Utility.GetCurrentGameTime()) + " ====="
	MiscUtil.WriteToFile(LOG_FILE, h + "\n", !fresh, true)
EndFunction

Function LogFileLine(string s)
	If !bLogPU || !bLogFile || iLogLines >= LOG_LINES_MAX
		return
	EndIf
	iLogLines += 1
	If iLogLines == LOG_LINES_MAX
		s += "\n[ODS] (" + LOG_LINES_MAX + " lines this game load: the rest only goes to Papyrus.0.log)"
	EndIf
	MiscUtil.WriteToFile(LOG_FILE, "[ODS] " + s + "\n", true, true)
EndFunction

; MCM toggle turned on mid-game: start writing now
Function LogToggled()
	bLogPU = PapyrusUtilOK()
	If bLogFile
		LogSessionStart()
		LogStartup()
	EndIf
EndFunction

string Function KindName(int k)
	If k == K_ATTACK
		return "night attack"
	ElseIf k == K_CHEAT
		return "cheating spouse"
	ElseIf k == K_JAIL
		return "jail / barracks"
	ElseIf k == K_INN
		return "inn patrons"
	ElseIf k == K_SPIKED
		return "spiked drink"
	ElseIf k == K_DEFEAT
		return "defeat"
	ElseIf k == K_TRESPASS
		return "trespass"
	ElseIf k == K_ROAD
		return "road robbery"
	ElseIf k == K_CREATURE
		return "creature (camp)"
	ElseIf k == K_BETRAYAL
		return "follower betrayal"
	ElseIf k == K_VAMPIRE
		return "vampire seduction"
	ElseIf k == K_MORNING
		return "morning after"
	ElseIf k == K_BATH
		return "bathing"
	ElseIf k == K_INNSHARE
		return "inn share"
	ElseIf k == K_DARKGIFT
		return "dark gift"
	ElseIf k == K_SAVIOR
		return "savior complex"
	ElseIf k == K_BUNNYFIGHT
		return "killer rabbit fight"
	ElseIf k == K_CRWILD
		return "wild creature"
	ElseIf k == K_WEREWOLF
		return "werewolf at night"
	ElseIf k == K_BEASTPREY
		return "beast form prey"
	ElseIf k == K_BEASTCLAIM
		return "beast form claim"
	EndIf
	return "kind " + k
EndFunction

string Function OnOff(bool b)
	If b
		return "ON"
	EndIf
	return "off"
EndFunction

string Function YesNo(bool b)
	If b
		return "yes"
	EndIf
	return "no"
EndFunction

; once per game load (ODS_PlayerAlias, a few seconds after loading): what was found and what is on
Function LogStartup()
	If !bLogFile
		return
	EndIf
	Log("startup: O'Deadly Skyrim " + ODS_VERSION + " | master switch " + OnOff(bMaster) + " | panic key " + iPanicKey + " | blood gift key " + iBloodGiftKey + " | SKSE " + SKSE.GetVersion() + "." + SKSE.GetVersionMinor() + "." + SKSE.GetVersionBeta() + " | PapyrusUtil " + YesNo(PapyrusUtilOK()))
	Log("startup: needed: OStim " + YesNo(OStimOK()) + " | powerofthree's Papyrus Extender " + YesNo(PO3OK()) + " | JContainers " + YesNo(JCOK()))
	Log("startup: found: SkyrimNet " + YesNo(SNetOK()) + " | OCreatures " + YesNo(OCreaturesInstalled()) + " | OCum " + YesNo(OCumOK()) + " | ZaZ " + YesNo(ZaZOK()) + " | ODangerous Nights " + YesNo(ODNLoaded()) + " | OStim Beast Form " + YesNo(BeastFormOK()) + " (scenes " + YesNo(BFScenesOK()) + ") | Growl " + YesNo(ModLoaded("Growl - Werebeasts of Skyrim.esp")) + " | Dawnguard " + YesNo(ModLoaded("Dawnguard.esm")) + " | Dragonborn " + YesNo(ModLoaded("Dragonborn.esm")))
	Log("startup: found: Dirt and Blood " + YesNo(DnBOK()) + " | Bathing in Skyrim " + YesNo(BiSOK()) + " | iActions " + YesNo(IActionsOK()) + " | Blood and OStim " + YesNo(BaOOK()) + " | Sacrosanct " + YesNo(SacrosanctOK()) + " | Kidnapped Redux " + YesNo(OKROK()) + " | ODefeat " + YesNo(ODefeatOK()) + " | Baka Defeat " + YesNo(BakaDefeatOK()) + " | Killer Rabbit " + YesNo(KillerBunnyOK()))
	Log("startup: on: sleep " + OnOff(bSleepEnabled) + " | cheating " + OnOff(bCheatEnabled) + " | jail " + OnOff(bJailEnabled) + " | inn " + OnOff(bInnPlayer) + " | spiked " + OnOff(bSpiked) + " | defeat " + OnOff(bDefeatEnabled) + " | trespass " + OnOff(bTrespassEnabled) + " | road " + OnOff(bTravelEnabled) + " | savior " + OnOff(bSavior) + " | rabbit fight " + OnOff(bBunnyFight) + " | betrayal " + OnOff(bBetrayal) + " | vampire " + OnOff(bVampire))
	Log("startup: on: creatures " + OnOff(bCrEnabled) + " | wild creatures " + OnOff(bCrWild) + " | werewolf at night " + OnOff(bWolfNight) + " | beast form offers " + OnOff(bBeastOffer) + " | Bitch in Heat " + OnOff(bHeat) + " (how many join " + HeatJoinText() + ", no in-game box)" + " | Saturalia " + OnOff(bSaturalia) + " | follower rescue " + OnOff(bRescue) + " | join in " + OnOff(bJoinIn) + " | morning after " + OnOff(bMorningAfter) + " | bathing " + OnOff(bBath) + " | inn share " + OnOff(bInnShare) + " | watched " + OnOff(bWatched) + " | dark gift " + OnOff(bDarkGift))
	Log("startup: pathogen " + OnOff(bPatho) + " | always infect " + OnOff(bPathoAlways) + " | chances WW " + fPathoWWChance + " VL " + fPathoVLChance + " bear " + fPathoBearChance + " human-form " + fPathoChance + " | any NPC " + OnOff(bPathoAnyNPC) + " | NPC scenes " + OnOff(bPathoNPCs) + " | you can catch it " + OnOff(bPathoPlayerCatch) + " | SkyrimNet change at will " + OnOff(bPathoSNetForms) + " | cap " + iPathoCap)
	Log("startup: 1.1.5 soft: Growl " + YesNo(GrowlOK()) + " (" + GrowlTotemText() + ") | Sacrosanct " + YesNo(SacrosanctOK()) + " (race change " + OnOff(bSacRace) + ") | Beast Form werebears use werewolf scenes " + YesNo(HeatBearAsWolf()) + " | werebear pool " + YesNo(WerebearRace() != None) + " | vampire lord race " + YesNo(VampireLordRace() != None) + " | vampire followers can become vampire lords " + OnOff(bVLFollowers))
	Log("startup: 1.1.8 lore beasts " + OnOff(bLoreBeasts) + " (needs OStim Beast Form " + YesNo(BeastFormOK()) + "; Serana = vampire lord, Kodlak / Skjor / Aela / Farkas / Vilkas = werewolf; dead skipped; Harkon never touched)")
	Log("startup: SkyrimNet narration " + OnOff(bSkyrimNetStart) + " | memories " + OnOff(bSkyrimNetLog) + " | bio check " + OnOff(bBioCheck) + " | morality filter " + OnOff(bMoralityFilter) + " | cooldown " + fCooldownHours + " h | player can be a victim " + OnOff(bPlayerVictim) + " | debug notifications " + OnOff(bDebug))
EndFunction

; =====================================================================================
; 1.1.5: Growl / Sacrosanct soft detection (neither is needed), Sacrosanct-style NPC vampires,
; and existing vampire followers as vampire lords through SkyrimNet. Declared at the end (save-safe).
; =====================================================================================
bool Property bSacRace = false Auto Hidden        ; Sacrosanct found: turned NPCs also get its vampire race
bool Property bVLFollowers = false Auto Hidden    ; existing vampire followers can become vampire lords
bool Property bLoreBeasts = true Auto Hidden      ; 1.1.8: Serana / Companions start transform-capable (needs Beast Form)

Actor[] kVLF
Race[] kVLFRace
Armor[] kVLFSkin
bool[] bVLFChanged

bool Function GrowlOK()
	return ModLoaded("Growl - Werebeasts of Skyrim.esp")
EndFunction

; Growl's werebear totem (HRI_Lycan_Global_WerebearTotem): 1 = Growl's beastblood NPCs change into werebears
int Function GrowlTotem()
	If !GrowlOK()
		return -1
	EndIf
	GlobalVariable g = Game.GetFormFromFile(0x0003D478, "Growl - Werebeasts of Skyrim.esp") as GlobalVariable
	If g == None
		return -1
	EndIf
	return g.GetValue() as int
EndFunction

string Function GrowlTotemText()
	int t = GrowlTotem()
	If t < 0
		return "not found"
	ElseIf t == 1
		return "werebear totem (Growl NPC changes: werebear)"
	EndIf
	return "no werebear totem (" + t + ", Growl NPC changes: werewolf)"
EndFunction

; who owns what for one newly turned werewolf / werebear (logged every time)
Function PathoGrowlDecision(Actor a, int kind, bool given)
	string nm = NameOf(a)
	If !GrowlOK()
		Log("pathogen: " + nm + ": Growl not found - O'Deadly owns the " + FormWord(kind) + " night-fight changes, SkyrimNet changes and the beast body")
		return
	EndIf
	If !given
		Log("pathogen: " + nm + ": no Growl beastblood (not a gift, follower or spouse) - O'Deadly owns the " + FormWord(kind) + " night-fight changes, SkyrimNet changes and the beast body")
		return
	EndIf
	int t = GrowlTotem()
	string gw = "werewolf"
	If t == 1
		gw = "werebear"
	EndIf
	Log("pathogen: " + nm + ": Growl beastblood given - Growl owns the fight changes and follows its totem (" + GrowlTotemText() + ", Circle members stay werewolves), so Growl makes " + nm + " a " + gw + "; O'Deadly still owns SkyrimNet changes (as a " + FormWord(kind) + ") and the beast body")
	If gw != FormWord(kind)
		Log("pathogen: " + nm + ": note - caught " + DiseaseWord(kind) + " as a " + FormWord(kind) + ", Growl's totem makes its fight form a " + gw)
	EndIf
EndFunction

; does this skin have a body for that race (SKSE: additional races of its armor addons)?
bool Function SkinFitsRace(Armor sk, Race r)
	If sk == None || r == None
		return true
	EndIf
	int n = sk.GetNumArmorAddons()
	int i = 0
	While i < n
		ArmorAddon aa = sk.GetNthArmorAddon(i)
		If aa
			int m = aa.GetNumAdditionalRaces()
			int j = 0
			While j < m
				If aa.GetNthAdditionalRace(j) == r
					return true
				EndIf
				j += 1
			EndWhile
		EndIf
		i += 1
	EndWhile
	return false
EndFunction

; a newly turned NPC vampire: VampireVampirism always; with Sacrosanct also what its Foster Childe
; gives NPCs (NPC resistances, poison resistance, drain by level), never the Foster Childe message
Function PathoVampirize(Actor a)
	string nm = NameOf(a)
	Spell vv = Game.GetFormFromFile(0x000ED0A8, "Skyrim.esm") as Spell      ; VampireVampirism
	If vv
		a.AddSpell(vv, false)
	EndIf
	If !SacrosanctOK()
		Log("pathogen: " + nm + ": vampire, standard (VampireFaction, NPC sun damage, VampireVampirism) - Sacrosanct not found")
		return
	EndIf
	string p = "Sacrosanct - Vampires of Skyrim.esp"
	Spell res = Game.GetFormFromFile(0x000F5B5C, "Skyrim.esm") as Spell     ; NPC vampire resistances
	If res
		a.AddSpell(res, false)
	EndIf
	Spell poi = Game.GetFormFromFile(0x0010FB30, "Skyrim.esm") as Spell     ; VampirePoisonResist
	If poi
		a.AddSpell(poi, false)
	EndIf
	int idx = a.GetLevel() / 10
	If idx > 3
		idx = 3
	ElseIf idx < 0
		idx = 0
	EndIf
	Spell dr = None
	If idx == 0
		dr = Game.GetFormFromFile(0x0008D5BF, "Skyrim.esm") as Spell
	ElseIf idx == 1
		dr = Game.GetFormFromFile(0x0015DD41, p) as Spell
	ElseIf idx == 2
		dr = Game.GetFormFromFile(0x0015DD43, p) as Spell
	Else
		dr = Game.GetFormFromFile(0x0015DD45, p) as Spell
	EndIf
	If dr
		a.AddSpell(dr, false)
		StorageUtil.SetFormValue(a, "ODS_SacDrain", dr)
	EndIf
	StorageUtil.SetIntValue(a, "ODS_SacVamp", 1)
	string rt = "race unchanged (MCM toggle off)"
	If bSacRace
		rt = PathoSacRace(a)
	EndIf
	Log("pathogen: " + nm + ": vampire, Sacrosanct style (VampireVampirism, NPC sun damage, resistances " + YesNo(res != None) + ", poison resistance " + YesNo(poi != None) + ", drain tier " + idx + " " + FormText(dr) + "), " + rt)
EndFunction

string Function PathoSacRace(Actor a)
	string p = "Sacrosanct - Vampires of Skyrim.esp"
	FormList rl = Game.GetFormFromFile(0x000D5929, p) as FormList           ; SCS races
	FormList vl = Game.GetFormFromFile(0x000D592A, p) as FormList           ; SCS vampire races (same order)
	If rl == None || vl == None
		return "race unchanged (Sacrosanct race lists not found)"
	EndIf
	Race cur = a.GetRace()
	int i = rl.Find(cur)
	If i < 0 || i >= vl.GetSize()
		return "race unchanged (" + FormText(cur) + " is not in Sacrosanct's race list)"
	EndIf
	Race vr = vl.GetAt(i) as Race
	If vr == None || vr == cur
		return "race unchanged (no vampire race for " + FormText(cur) + ")"
	EndIf
	ActorBase ab = PathoSkinBase(a)
	Armor own = None
	If ab
		own = ab.GetSkin()
	EndIf
	If own && !SkinFitsRace(own, vr)
		return "race unchanged (" + NameOf(a) + "'s own skin " + FormText(own) + " has no body for " + FormText(vr) + ")"
	EndIf
	StorageUtil.SetFormValue(a, "ODS_SacRaceFrom", cur)
	a.SetRace(vr)
	a.QueueNiNodeUpdate()
	return "race " + FormText(cur) + " -> " + FormText(vr)
EndFunction

; cure: take back what PathoVampirize gave
Function PathoUnvampirize(Actor a)
	If a == None
		return
	EndIf
	Spell vv = Game.GetFormFromFile(0x000ED0A8, "Skyrim.esm") as Spell
	If vv
		a.RemoveSpell(vv)
	EndIf
	If StorageUtil.GetIntValue(a, "ODS_SacVamp", 0) > 0
		Spell res = Game.GetFormFromFile(0x000F5B5C, "Skyrim.esm") as Spell
		Spell poi = Game.GetFormFromFile(0x0010FB30, "Skyrim.esm") as Spell
		Spell dr = StorageUtil.GetFormValue(a, "ODS_SacDrain") as Spell
		If res
			a.RemoveSpell(res)
		EndIf
		If poi
			a.RemoveSpell(poi)
		EndIf
		If dr
			a.RemoveSpell(dr)
		EndIf
	EndIf
	Race from = StorageUtil.GetFormValue(a, "ODS_SacRaceFrom") as Race
	If from && !IsBeastForm(a)
		a.SetRace(from)
		a.QueueNiNodeUpdate()
		Log("pathogen: " + NameOf(a) + ": cured, race back to " + FormText(from))
	EndIf
	StorageUtil.UnsetIntValue(a, "ODS_SacVamp")
	StorageUtil.UnsetFormValue(a, "ODS_SacDrain")
	StorageUtil.UnsetFormValue(a, "ODS_SacRaceFrom")
EndFunction

; ---------- existing vampire followers (Serana and others) as vampire lords ----------
bool Function IsVampireNPC(Actor a)
	If a == None || a == PlayerRef
		return false
	EndIf
	Keyword kv = Game.GetFormFromFile(0x000A82BB, "Skyrim.esm") as Keyword  ; Vampire
	Faction vf = Game.GetFormFromFile(0x00027242, "Skyrim.esm") as Faction  ; VampireFaction
	return (kv && a.HasKeyword(kv)) || (vf && a.IsInFaction(vf))
EndFunction

Function VLFInit()
	If !kVLF || kVLF.Length != 5
		kVLF = new Actor[5]
		kVLFRace = new Race[5]
		kVLFSkin = new Armor[5]
		bVLFChanged = new bool[5]
	EndIf
EndFunction

bool Function VLFEligible(Actor a)
	return a && !a.IsDead() && IsFollowerActor(a) && !IsMinor(a) && IsVampireNPC(a) && PathoIndex(a) < 0
EndFunction

; follower refresh (game load, location change, MCM): mark vampire followers for SkyrimNet
Function VLFScan()
	VLFInit()
	bool on = bVLFollowers && bMaster && VampireLordRace() != None
	If on
		StorageUtil.SetIntValue(None, "ODS_VLFOn", 1)
	Else
		StorageUtil.UnsetIntValue(None, "ODS_VLFOn")
	EndIf
	int i = 0
	While i < 5
		Actor a = kVLF[i]
		If a && !bVLFChanged[i] && (!on || !VLFEligible(a))
			StorageUtil.UnsetIntValue(a, "ODS_VLF")
			Log("vampire followers: " + NameOf(a) + " unmarked")
			kVLF[i] = None
		EndIf
		i += 1
	EndWhile
	If !on
		return
	EndIf
	Actor[] near = OActorUtil.GetActorsInRangeV2(PlayerRef, 4000.0, false, false, false)
	i = 0
	While i < near.Length
		Actor a = near[i]
		If VLFEligible(a) && kVLF.Find(a) < 0
			int s = kVLF.Find(None)
			If s >= 0
				kVLF[s] = a
				bVLFChanged[s] = false
				StorageUtil.SetIntValue(a, "ODS_VLF", 1)
				Log("vampire followers: " + NameOf(a) + " can become a vampire lord (SkyrimNet)")
			EndIf
		EndIf
		i += 1
	EndWhile
EndFunction

Function SNBecomeVampireLord(Actor a)
	VLFInit()
	Race vl = VampireLordRace()
	If a == None || !bVLFollowers || !bMaster || vl == None
		Log("SkyrimNet action BecomeVampireLord (" + NameOf(a) + ") ignored: toggle / master off or no Dawnguard")
		return
	EndIf
	If !VLFEligible(a) || IsBeastForm(a)
		Log("SkyrimNet action BecomeVampireLord (" + NameOf(a) + ") ignored: not an adult vampire follower, turned by the pathogen, or already in beast form")
		return
	EndIf
	If a.IsOnMount() || OActor.IsInOStim(a) || IsStaged(a)
		Log("SkyrimNet action BecomeVampireLord: " + NameOf(a) + " could not change now (mount, scene or staged)")
		return
	EndIf
	int s = kVLF.Find(a)
	If s < 0
		s = kVLF.Find(None)
		If s < 0
			Log("SkyrimNet action BecomeVampireLord (" + NameOf(a) + ") ignored: five vampire followers already tracked")
			return
		EndIf
		kVLF[s] = a
		StorageUtil.SetIntValue(a, "ODS_VLF", 1)
	EndIf
	If a.GetSitState() != 0
		Debug.SendAnimationEvent(a, "IdleForceDefaultState")
	EndIf
	kVLFRace[s] = a.GetRace()
	kVLFSkin[s] = VLFSkinSwap(a, vl, "change")
	bVLFChanged[s] = true
	a.SetRace(vl)
	a.QueueNiNodeUpdate()
	StorageUtil.SetIntValue(a, "ODS_BeastForm", 1)
	Log("SkyrimNet action BecomeVampireLord: " + NameOf(a) + " changed into a vampire lord (from " + FormText(kVLFRace[s]) + ")")
EndFunction

; own skin (WNAM) would hide the vampire lord body: wear the race's skin while changed
Armor Function VLFSkinSwap(Actor a, Race r, string why)
	ActorBase ab = PathoSkinBase(a)
	If ab == None || r == None
		return None
	EndIf
	Armor own = ab.GetSkin()
	Armor beast = r.GetSkin()
	If own && beast && own != beast
		ab.SetSkin(beast)
		Log("skin: " + NameOf(a) + ": own skin " + FormText(own) + " -> " + FormText(beast) + " (vampire follower, " + why + ")")
		return own
	EndIf
	Log("skin: " + NameOf(a) + ": no own skin to swap (vampire follower, " + why + ")")
	return None
EndFunction

bool Function VLFBack(Actor a)
	If !kVLF || a == None
		return false
	EndIf
	int s = kVLF.Find(a)
	If s < 0 || !bVLFChanged[s]
		return false
	EndIf
	VLFRevert(s, "SkyrimNet")
	return true
EndFunction

Function VLFRevert(int s, string why)
	Actor a = kVLF[s]
	bVLFChanged[s] = false
	If a == None
		return
	EndIf
	If kVLFSkin[s] && !(a.IsDead() && IsBeastForm(a))
		ActorBase ab = PathoSkinBase(a)
		If ab
			ab.SetSkin(kVLFSkin[s])
			Log("skin: " + NameOf(a) + ": own skin " + FormText(kVLFSkin[s]) + " back (vampire follower, " + why + ")")
		EndIf
	EndIf
	kVLFSkin[s] = None
	If kVLFRace[s] && IsBeastForm(a) && !a.IsDead()
		a.SetRace(kVLFRace[s])
		a.QueueNiNodeUpdate()
	EndIf
	StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
	Log("vampire followers: " + NameOf(a) + " back to " + FormText(kVLFRace[s]) + " (" + why + ")")
EndFunction

Function VLFRevertAll()
	If !kVLF
		return
	EndIf
	int i = 0
	While i < kVLF.Length
		If bVLFChanged[i]
			VLFRevert(i, "revert all")
		EndIf
		i += 1
	EndWhile
EndFunction

; game load: SetSkin is not saved; a vampire lord follower gets the beast skin again
Function VLFOnLoad()
	VLFInit()
	int i = 0
	While i < 5
		Actor a = kVLF[i]
		If bVLFChanged[i]
			If a && IsVampireLordForm(a)
				If kVLFSkin[i]
					VLFSkinSwap(a, a.GetRace(), "game load")
				EndIf
			Else
				bVLFChanged[i] = false
				kVLFSkin[i] = None
				If a
					StorageUtil.UnsetIntValue(a, "ODS_BeastForm")
					Log("vampire followers: " + NameOf(a) + " is not a vampire lord any more after the load")
				EndIf
			EndIf
		EndIf
		i += 1
	EndWhile
	VLFScan()
EndFunction

; OnRaceSwitchComplete is not watched for these; a change from another mod is caught on the next action/load

; =====================================================================================
; 1.1.8: lore beasts. When OStim Beast Form is present, Serana and the living Companions
; Circle leaders get O'Deadly's own transform data only (carrier, immunity, SkyrimNet
; change at will, beast skin swap). No quest factions, no permanent race change, no
; vanilla spells or scripts, and Harkon is never touched.
; =====================================================================================
bool[] bPathoLore          ; true = this slot is a lore starter (Cure everyone must not undo vanilla state)

int Function PathoRegularCount()
	PathoInitArrays()
	int n = 0
	int i = 0
	While i < 10
		If kPatho[i]
			If bPathoLore.Length != 10 || !bPathoLore[i]
				n += 1
			EndIf
		EndIf
		i += 1
	EndWhile
	return n
EndFunction

; persistent unique refs: Serana is DLC1SeranaRef 0x2B74 (base DLC1Serana 0x2B6C).
; Companions use their Skyrim.esm placed refs, not the actor bases.
Actor Function LoreActorOf(string plugin, int refId, int baseId)
	If !ModLoaded(plugin)
		return None
	EndIf
	Actor a = Game.GetFormFromFile(refId, plugin) as Actor
	If a
		return a
	EndIf
	return Game.GetFormFromFile(baseId, plugin) as Actor
EndFunction

bool Function LoreBeastRegister(Actor a, int kind, string label)
	PathoInitArrays()
	int i = kPatho.Find(None)
	If i < 0
		Log("lore beasts: " + label + " (" + NameOf(a) + ") not added: no free slot (all 10 in use)")
		return false
	EndIf
	If ODS_PathoQuest == None
		Log("lore beasts: " + label + " (" + NameOf(a) + ") not added: ODS_PathoQuest missing")
		return false
	EndIf
	If !ODS_PathoQuest.IsRunning()
		ODS_PathoQuest.Start()
		If !ODS_PathoQuest.IsRunning()
			Log("lore beasts: ODS_PathoQuest did not start (continuing; the alias only watches for Cure Disease)")
		EndIf
	EndIf
	ODS_PathoAlias al = PathoAlias(i)
	If al == None
		Log("lore beasts: " + label + " (" + NameOf(a) + ") not added: alias Infected" + (i + 1) + " missing or without its ODS_PathoAlias script")
		return false
	EndIf
	; If this actor is mid vampire-lord change through the follower path, leave that path alone.
	VLFInit()
	If kVLF.Length == 5
		int s = kVLF.Find(a)
		If s >= 0 && bVLFChanged[s]
			Log("lore beasts: " + NameOf(a) + " is already a vampire lord through the follower path - skipped this load")
			return false
		EndIf
	EndIf
	kPatho[i] = a
	iPathoKind[i] = kind
	iPathoStage[i] = 3
	fPathoStart[i] = Utility.GetCurrentGameTime()
	kPathoRace[i] = None
	kPathoSkin[i] = None
	bPathoSkinSwap[i] = false
	bPathoFirst[i] = false
	bPathoChanged[i] = false
	bPathoBusy[i] = false
	fPathoCD[i] = 0.0
	iPathoMode[i] = 0
	kPathoSrc[i] = None
	iPathoWhy[i] = 0
	bPathoLore[i] = true
	al.ForceRefTo(a)
	al.Watch(CurePotion())
	PathoSetKeys(i)
	If SNetOK()
		SkyrimNetApi.UpdateActorDynamicBio(a)
	EndIf
	Log("lore beasts: " + NameOf(a) + " given O'Deadly " + FormWord(kind) + " transform data (carrier, immune, SkyrimNet change at will; no faction, race or vanilla script changes)")
	return true
EndFunction

Function LoreBeastTry(string label, string plugin, int refId, int baseId, int kind)
	Actor a = LoreActorOf(plugin, refId, baseId)
	If a == None
		Log("lore beasts: " + label + " not found in " + plugin + " - skipped")
		return
	EndIf
	If a.IsDead()
		int d = PathoIndex(a)
		If d >= 0 && bPathoLore.Length == 10 && bPathoLore[d]
			PathoClear(d)
			Log("lore beasts: " + NameOf(a) + " is dead - O'Deadly data cleared")
		Else
			Log("lore beasts: " + NameOf(a) + " is dead - skipped")
		EndIf
		return
	EndIf
	int i = PathoIndex(a)
	If i >= 0
		If bPathoLore.Length == 10 && bPathoLore[i]
			PathoSetKeys(i)
			Log("lore beasts: " + NameOf(a) + " already has O'Deadly " + FormWord(iPathoKind[i]) + " data - left as is")
		Else
			Log("lore beasts: " + NameOf(a) + " already tracked by the pathogen - left as is")
		EndIf
		return
	EndIf
	LoreBeastRegister(a, kind, label)
EndFunction

Function LoreBeastsClear()
	PathoInitArrays()
	If bPathoLore.Length != 10
		return
	EndIf
	int i = 0
	While i < 10
		If bPathoLore[i]
			Actor a = kPatho[i]
			string nm = NameOf(a)
			If a && bPathoChanged[i]
				PathoRevert(i)
			EndIf
			PathoClear(i)
			Log("lore beasts: " + nm + " O'Deadly transform data removed (toggle off or no Beast Form)")
		EndIf
		i += 1
	EndWhile
EndFunction

; game load and MCM: idempotent. Only O'Deadly data; never Harkon.
Function LoreBeastsSync()
	PathoInitArrays()
	If !bLoreBeasts || !BeastFormOK()
		LoreBeastsClear()
		PathoSyncGlobals()
		return
	EndIf
	LoreBeastTry("Serana", "Dawnguard.esm", 0x00002B74, 0x00002B6C, 2)
	LoreBeastTry("Kodlak Whitemane", "Skyrim.esm", 0x0001A68F, 0x0001A68E, 1)
	LoreBeastTry("Skjor", "Skyrim.esm", 0x0001A691, 0x0001A690, 1)
	LoreBeastTry("Aela the Huntress", "Skyrim.esm", 0x0001A697, 0x0001A696, 1)
	LoreBeastTry("Farkas", "Skyrim.esm", 0x0001A693, 0x0001A692, 1)
	LoreBeastTry("Vilkas", "Skyrim.esm", 0x0001A695, 0x0001A694, 1)
	PathoSyncGlobals()
	VLFScan()
EndFunction

; =====================================================================================
; 1.2.0: module split support. ODS_Heat, ODS_Rescue, ODS_Bridges (and any later module) are extra
; scripts on this same quest. The state they work on still lives in the variables declared above
; (same names, types and defaults, so every save keeps them). The mv_ properties below are FULL
; properties (Get / Set only, no Auto): they add no saved storage and no existing variable became
; a property. Modules reach this script with (Self as Quest) as ODS_Main.
; =====================================================================================
string sModWarned = ""      ; 1.2.0 (new): module scripts already reported as missing

Function ModMissing(string n)
	If StringUtil.Find(sModWarned, n) < 0
		sModWarned += n + " "
		Log("module script " + n + " is missing from the main quest (mismatched ESP?) - that module does nothing")
	EndIf
EndFunction

int Property mv_iEpoch
	int Function Get()
		return iEpoch
	EndFunction
	Function Set(int v)
		iEpoch = v
	EndFunction
EndProperty

int Property mv_iThread
	int Function Get()
		return iThread
	EndFunction
	Function Set(int v)
		iThread = v
	EndFunction
EndProperty

Actor[] Property mv_kSceneActs
	Actor[] Function Get()
		return kSceneActs
	EndFunction
	Function Set(Actor[] v)
		kSceneActs = v
	EndFunction
EndProperty

string Property mv_sScene1
	string Function Get()
		return sScene1
	EndFunction
	Function Set(string v)
		sScene1 = v
	EndFunction
EndProperty

bool Property mv_bSaviorJoining
	bool Function Get()
		return bSaviorJoining
	EndFunction
	Function Set(bool v)
		bSaviorJoining = v
	EndFunction
EndProperty

bool Property mv_bAftermathDone
	bool Function Get()
		return bAftermathDone
	EndFunction
	Function Set(bool v)
		bAftermathDone = v
	EndFunction
EndProperty

; ---- Bitch in Heat (ODS_Heat) ----
bool Property mv_bHeatOn
	bool Function Get()
		return bHeatOn
	EndFunction
	Function Set(bool v)
		bHeatOn = v
	EndFunction
EndProperty

int Property mv_iHeatThread
	int Function Get()
		return iHeatThread
	EndFunction
	Function Set(int v)
		iHeatThread = v
	EndFunction
EndProperty

int Property mv_iHeatEp
	int Function Get()
		return iHeatEp
	EndFunction
	Function Set(int v)
		iHeatEp = v
	EndFunction
EndProperty

int Property mv_iHeatLeft
	int Function Get()
		return iHeatLeft
	EndFunction
	Function Set(int v)
		iHeatLeft = v
	EndFunction
EndProperty

bool Property mv_bHeatOwnsBusy
	bool Function Get()
		return bHeatOwnsBusy
	EndFunction
	Function Set(bool v)
		bHeatOwnsBusy = v
	EndFunction
EndProperty

Actor[] Property mv_kHeatWolves
	Actor[] Function Get()
		return kHeatWolves
	EndFunction
	Function Set(Actor[] v)
		kHeatWolves = v
	EndFunction
EndProperty

Actor Property mv_kHeatHuman
	Actor Function Get()
		return kHeatHuman
	EndFunction
	Function Set(Actor v)
		kHeatHuman = v
	EndFunction
EndProperty

Actor Property mv_kHeatBeast
	Actor Function Get()
		return kHeatBeast
	EndFunction
	Function Set(Actor v)
		kHeatBeast = v
	EndFunction
EndProperty

ObjectReference Property mv_kHeatMarker
	ObjectReference Function Get()
		return kHeatMarker
	EndFunction
	Function Set(ObjectReference v)
		kHeatMarker = v
	EndFunction
EndProperty

int Property mv_iHeatCount
	int Function Get()
		return iHeatCount
	EndFunction
	Function Set(int v)
		iHeatCount = v
	EndFunction
EndProperty

bool Property mv_bHeatTurns
	bool Function Get()
		return bHeatTurns
	EndFunction
	Function Set(bool v)
		bHeatTurns = v
	EndFunction
EndProperty

bool Property mv_bHeatFemale
	bool Function Get()
		return bHeatFemale
	EndFunction
	Function Set(bool v)
		bHeatFemale = v
	EndFunction
EndProperty

int Property mv_iHeatTurn
	int Function Get()
		return iHeatTurn
	EndFunction
	Function Set(int v)
		iHeatTurn = v
	EndFunction
EndProperty

int Property mv_iHeatKind
	int Function Get()
		return iHeatKind
	EndFunction
	Function Set(int v)
		iHeatKind = v
	EndFunction
EndProperty

int Property mv_iHeatWW
	int Function Get()
		return iHeatWW
	EndFunction
	Function Set(int v)
		iHeatWW = v
	EndFunction
EndProperty

int Property mv_iHeatVL
	int Function Get()
		return iHeatVL
	EndFunction
	Function Set(int v)
		iHeatVL = v
	EndFunction
EndProperty

int Property mv_iHeatBear
	int Function Get()
		return iHeatBear
	EndFunction
	Function Set(int v)
		iHeatBear = v
	EndFunction
EndProperty

; ---- follower rescue (ODS_Rescue) ----
bool Property mv_bRescueOn
	bool Function Get()
		return bRescueOn
	EndFunction
	Function Set(bool v)
		bRescueOn = v
	EndFunction
EndProperty

bool Property mv_bRescueDone
	bool Function Get()
		return bRescueDone
	EndFunction
	Function Set(bool v)
		bRescueDone = v
	EndFunction
EndProperty

int Property mv_iRescueThread
	int Function Get()
		return iRescueThread
	EndFunction
	Function Set(int v)
		iRescueThread = v
	EndFunction
EndProperty

Actor Property mv_kRescueVic
	Actor Function Get()
		return kRescueVic
	EndFunction
	Function Set(Actor v)
		kRescueVic = v
	EndFunction
EndProperty

Actor Property mv_kRescueAtt
	Actor Function Get()
		return kRescueAtt
	EndFunction
	Function Set(Actor v)
		kRescueAtt = v
	EndFunction
EndProperty

float Property mv_fRescueAgg
	float Function Get()
		return fRescueAgg
	EndFunction
	Function Set(float v)
		fRescueAgg = v
	EndFunction
EndProperty

bool Property mv_bRescueFac
	bool Function Get()
		return bRescueFac
	EndFunction
	Function Set(bool v)
		bRescueFac = v
	EndFunction
EndProperty

bool Property mv_bRescueProt
	bool Function Get()
		return bRescueProt
	EndFunction
	Function Set(bool v)
		bRescueProt = v
	EndFunction
EndProperty

string Property mv_sRescueWhere
	string Function Get()
		return sRescueWhere
	EndFunction
	Function Set(string v)
		sRescueWhere = v
	EndFunction
EndProperty

float Property mv_fLastRescue
	float Function Get()
		return fLastRescue
	EndFunction
	Function Set(float v)
		fLastRescue = v
	EndFunction
EndProperty

; ---- SkyrimNet bridges (ODS_Bridges; also read by ODS_Rescue) ----
float Property mv_fOKRHeldUntil
	float Function Get()
		return fOKRHeldUntil
	EndFunction
	Function Set(float v)
		fOKRHeldUntil = v
	EndFunction
EndProperty

string Property mv_sOKRWhere
	string Function Get()
		return sOKRWhere
	EndFunction
	Function Set(string v)
		sOKRWhere = v
	EndFunction
EndProperty

float Property mv_fODefUntil
	float Function Get()
		return fODefUntil
	EndFunction
	Function Set(float v)
		fODefUntil = v
	EndFunction
EndProperty

bool Property mv_bODefAwait
	bool Function Get()
		return bODefAwait
	EndFunction
	Function Set(bool v)
		bODefAwait = v
	EndFunction
EndProperty

string Property mv_sODefWhere
	string Function Get()
		return sODefWhere
	EndFunction
	Function Set(string v)
		sODefWhere = v
	EndFunction
EndProperty

string Property mv_sODefBy
	string Function Get()
		return sODefBy
	EndFunction
	Function Set(string v)
		sODefBy = v
	EndFunction
EndProperty

float Property mv_fBakaUntil
	float Function Get()
		return fBakaUntil
	EndFunction
	Function Set(float v)
		fBakaUntil = v
	EndFunction
EndProperty

string Property mv_sBakaWhere
	string Function Get()
		return sBakaWhere
	EndFunction
	Function Set(string v)
		sBakaWhere = v
	EndFunction
EndProperty

string Property mv_sBakaBy
	string Function Get()
		return sBakaBy
	EndFunction
	Function Set(string v)
		sBakaBy = v
	EndFunction
EndProperty

bool Property mv_bBakaMemDone
	bool Function Get()
		return bBakaMemDone
	EndFunction
	Function Set(bool v)
		bBakaMemDone = v
	EndFunction
EndProperty

int[] Property mv_iBakaTid
	int[] Function Get()
		return iBakaTid
	EndFunction
	Function Set(int[] v)
		iBakaTid = v
	EndFunction
EndProperty

int[] Property mv_iBakaKind
	int[] Function Get()
		return iBakaKind
	EndFunction
	Function Set(int[] v)
		iBakaKind = v
	EndFunction
EndProperty

Actor[] Property mv_kBakaVic
	Actor[] Function Get()
		return kBakaVic
	EndFunction
	Function Set(Actor[] v)
		kBakaVic = v
	EndFunction
EndProperty

Actor[] Property mv_kBakaAgg
	Actor[] Function Get()
		return kBakaAgg
	EndFunction
	Function Set(Actor[] v)
		kBakaAgg = v
	EndFunction
EndProperty
