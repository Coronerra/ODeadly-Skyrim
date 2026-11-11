Scriptname ODS_MCM extends SKI_ConfigBase
{O'Deadly Skyrim v0.1 MCM (SkyUI). By That Guy (Coronerra).}

ODS_Main Property Main Auto

; generic option registry: id -> key
int[] tIds
string[] tKeys
int nT = 0
int[] sIds
string[] sKeys
int nS = 0

int oMaster
int oPanicKey
int oMsg
int oGender
int oRecheck
int oForceAttack
int oForceCreature
int oForceCheat
int oForceJail
int oForceInn
int oForceSpiked
int oForceTrespass
int oForceRoad
int oForceBetrayal
int oForceVampire
int oForceDefeat
int oForceClear
int oOvrClear
int oJailHere
int oUsePlaces
int oPlaceCat
int oPlaceName
int oPlaceUntag
int oPlaceRename
int oPlaceApplyRadius
int oPlaceDelete
int oSerana
int[] oFollower
Actor[] kFollower
string sNewPlaceName = "Rest spot"
string[] genderOpts
string[] msgOpts
string[] catOpts
string[] jailOpts

int Function GetVersion()
	return 1
EndFunction

Event OnConfigInit()
	SetupPages()
EndEvent

Function SetupPages()
	ModName = "O'Deadly Skyrim"
	Pages = new string[9]
	Pages[0] = "General"
	Pages[1] = "Night attacks"
	Pages[2] = "Relationships"
	Pages[3] = "Jail & inns"
	Pages[4] = "Danger"
	Pages[5] = "Creatures"
	Pages[6] = "This location"
	Pages[7] = "Protected followers"
	Pages[8] = "Debug"
	genderOpts = new string[3]
	genderOpts[0] = "Any"
	genderOpts[1] = "Female only"
	genderOpts[2] = "Male only"
	msgOpts = new string[3]
	msgOpts[0] = "Message box"
	msgOpts[1] = "Notification"
	msgOpts[2] = "None"
	jailOpts = new string[3]
	jailOpts[0] = "Auto-detect"
	jailOpts[1] = "Yes, jail / barracks"
	jailOpts[2] = "Never"
EndFunction

int Function Flag(bool on)
	If on
		return OPTION_FLAG_NONE
	EndIf
	return OPTION_FLAG_DISABLED
EndFunction

string Function StatusText(int s)
	If s == 2
		return "Available"
	ElseIf s == 1
		return "No scenes found"
	ElseIf s == 3
		return "Not checked yet"
	EndIf
	return "Not installed"
EndFunction

string Function YesNo(bool b)
	If b
		return "Detected"
	EndIf
	return "Not found"
EndFunction

; ---------------- bool settings by key ----------------
bool Function GetB(string k)
	If k == "sleep"
		return Main.bSleepEnabled
	ElseIf k == "pvsleep"
		return Main.bPlayerVictim
	ElseIf k == "waitsleep"
		return Main.bWaitAsSleep
	ElseIf k == "nearby"
		return Main.bAllowNearby
	ElseIf k == "bandit"
		return Main.bAllowBandit
	ElseIf k == "guards"
		return Main.bGuardsBlock
	ElseIf k == "guardatk"
		return Main.bGuardAttackers
	ElseIf k == "guardvic"
		return Main.bGuardVictims
	ElseIf k == "fallback"
		return Main.bFallbackAnyScene
	ElseIf k == "named"
		return Main.bAllowNamed
	ElseIf k == "group"
		return Main.bGroupScenes
	ElseIf k == "groupboth"
		return Main.bGroupBoth
	ElseIf k == "morality"
		return Main.bMoralityFilter
	ElseIf k == "snstart"
		return Main.bSkyrimNetStart
	ElseIf k == "snlog"
		return Main.bSkyrimNetLog
	ElseIf k == "rumors"
		return Main.bRumors
	ElseIf k == "bio"
		return Main.bBioCheck
	ElseIf k == "drunkmod"
		return Main.bDrunkMod
	ElseIf k == "notice"
		return Main.bPanicNotice
	ElseIf k == "cheat"
		return Main.bCheatEnabled
	ElseIf k == "patrons"
		return Main.bPartnerPatronsOnly
	ElseIf k == "pfol"
		return Main.bPartnerFollowers
	ElseIf k == "pgrd"
		return Main.bPartnerGuards
	ElseIf k == "psame"
		return Main.bPartnerSameGender
	ElseIf k == "lover"
		return Main.bLoverIsSpouse
	ElseIf k == "drunkevent"
		return Main.bDrunkEvent
	ElseIf k == "caught"
		return Main.bCaught
	ElseIf k == "betrayal"
		return Main.bBetrayal
	ElseIf k == "jail"
		return Main.bJailEnabled
	ElseIf k == "jailplayer"
		return Main.bJailPlayer
	ElseIf k == "jailfol"
		return Main.bJailFollowers
	ElseIf k == "jailspawn"
		return Main.bJailSpawnExtras
	ElseIf k == "arrest"
		return Main.bArrestAlt
	ElseIf k == "zaz"
		return Main.bZaZ
	ElseIf k == "innplayer"
		return Main.bInnPlayer
	ElseIf k == "spiked"
		return Main.bSpiked
	ElseIf k == "spikedplayer"
		return Main.bSpikedPlayer
	ElseIf k == "spikedfol"
		return Main.bSpikedFollowers
	ElseIf k == "defeat"
		return Main.bDefeatEnabled
	ElseIf k == "defeatplayer"
		return Main.bDefeatPlayer
	ElseIf k == "defeatfol"
		return Main.bDefeatFollowers
	ElseIf k == "essential"
		return Main.bDefeatEssential
	ElseIf k == "trespass"
		return Main.bTrespassEnabled
	ElseIf k == "trespassplayer"
		return Main.bTrespassPlayer
	ElseIf k == "trespassfol"
		return Main.bTrespassFollowers
	ElseIf k == "travel"
		return Main.bTravelEnabled
	ElseIf k == "travelplayer"
		return Main.bTravelPlayer
	ElseIf k == "travelfol"
		return Main.bTravelFollowers
	ElseIf k == "vampire"
		return Main.bVampire
	ElseIf k == "blackmail"
		return Main.bBlackmail
	ElseIf k == "leftover"
		return Main.bLeftover
	ElseIf k == "ocum"
		return Main.bOCumMemory
	ElseIf k == "cr"
		return Main.bCrEnabled
	ElseIf k == "crplayer"
		return Main.bCrPlayer
	ElseIf k == "crfol"
		return Main.bCrFollowers
	ElseIf k == "places"
		return Main.bUsePlaces
	ElseIf k == "debug"
		return Main.bDebug
	ElseIf k == "debugtools"
		return Main.bDebugTools
	ElseIf StringUtil.Substring(k, 0, 2) == "ct"
		return Main.bCrType[StringUtil.Substring(k, 2) as int]
	EndIf
	return false
EndFunction

Function SetB(string k, bool v)
	If k == "sleep"
		Main.bSleepEnabled = v
	ElseIf k == "pvsleep"
		Main.bPlayerVictim = v
	ElseIf k == "waitsleep"
		Main.bWaitAsSleep = v
	ElseIf k == "nearby"
		Main.bAllowNearby = v
	ElseIf k == "bandit"
		Main.bAllowBandit = v
	ElseIf k == "guards"
		Main.bGuardsBlock = v
	ElseIf k == "guardatk"
		Main.bGuardAttackers = v
	ElseIf k == "guardvic"
		Main.bGuardVictims = v
	ElseIf k == "fallback"
		Main.bFallbackAnyScene = v
	ElseIf k == "named"
		Main.bAllowNamed = v
	ElseIf k == "group"
		Main.bGroupScenes = v
	ElseIf k == "groupboth"
		Main.bGroupBoth = v
	ElseIf k == "morality"
		Main.bMoralityFilter = v
	ElseIf k == "snstart"
		Main.bSkyrimNetStart = v
	ElseIf k == "snlog"
		Main.bSkyrimNetLog = v
	ElseIf k == "rumors"
		Main.bRumors = v
	ElseIf k == "bio"
		Main.bBioCheck = v
	ElseIf k == "drunkmod"
		Main.bDrunkMod = v
	ElseIf k == "notice"
		Main.bPanicNotice = v
	ElseIf k == "cheat"
		Main.bCheatEnabled = v
	ElseIf k == "patrons"
		Main.bPartnerPatronsOnly = v
	ElseIf k == "pfol"
		Main.bPartnerFollowers = v
	ElseIf k == "pgrd"
		Main.bPartnerGuards = v
	ElseIf k == "psame"
		Main.bPartnerSameGender = v
	ElseIf k == "lover"
		Main.bLoverIsSpouse = v
	ElseIf k == "drunkevent"
		Main.bDrunkEvent = v
	ElseIf k == "caught"
		Main.bCaught = v
	ElseIf k == "betrayal"
		Main.bBetrayal = v
	ElseIf k == "jail"
		Main.bJailEnabled = v
	ElseIf k == "jailplayer"
		Main.bJailPlayer = v
	ElseIf k == "jailfol"
		Main.bJailFollowers = v
	ElseIf k == "jailspawn"
		Main.bJailSpawnExtras = v
	ElseIf k == "arrest"
		Main.bArrestAlt = v
	ElseIf k == "zaz"
		Main.bZaZ = v
	ElseIf k == "innplayer"
		Main.bInnPlayer = v
	ElseIf k == "spiked"
		Main.bSpiked = v
	ElseIf k == "spikedplayer"
		Main.bSpikedPlayer = v
	ElseIf k == "spikedfol"
		Main.bSpikedFollowers = v
	ElseIf k == "defeat"
		Main.bDefeatEnabled = v
	ElseIf k == "defeatplayer"
		Main.bDefeatPlayer = v
	ElseIf k == "defeatfol"
		Main.bDefeatFollowers = v
	ElseIf k == "essential"
		Main.bDefeatEssential = v
	ElseIf k == "trespass"
		Main.bTrespassEnabled = v
	ElseIf k == "trespassplayer"
		Main.bTrespassPlayer = v
	ElseIf k == "trespassfol"
		Main.bTrespassFollowers = v
	ElseIf k == "travel"
		Main.bTravelEnabled = v
	ElseIf k == "travelplayer"
		Main.bTravelPlayer = v
	ElseIf k == "travelfol"
		Main.bTravelFollowers = v
	ElseIf k == "vampire"
		Main.bVampire = v
	ElseIf k == "blackmail"
		Main.bBlackmail = v
	ElseIf k == "leftover"
		Main.bLeftover = v
	ElseIf k == "ocum"
		Main.bOCumMemory = v
	ElseIf k == "cr"
		Main.bCrEnabled = v
	ElseIf k == "crplayer"
		Main.bCrPlayer = v
	ElseIf k == "crfol"
		Main.bCrFollowers = v
	ElseIf k == "places"
		Main.bUsePlaces = v
	ElseIf k == "debug"
		Main.bDebug = v
	ElseIf k == "debugtools"
		Main.bDebugTools = v
	ElseIf StringUtil.Substring(k, 0, 2) == "ct"
		Main.bCrType[StringUtil.Substring(k, 2) as int] = v
	EndIf
EndFunction

; ---------------- float settings by key ----------------
float Function GetF(string k)
	If StringUtil.Substring(k, 0, 3) == "atk"
		return Main.CatAttack(StringUtil.Substring(k, 3) as int)
	ElseIf StringUtil.Substring(k, 0, 3) == "cht"
		return Main.CatCheat(StringUtil.Substring(k, 3) as int)
	ElseIf k == "cooldown"
		return Main.fCooldownHours
	ElseIf k == "mindur"
		return Main.fMinDuration
	ElseIf k == "maxdur"
		return Main.fMaxDuration
	ElseIf k == "groupmax"
		return Main.iGroupMax as float
	ElseIf k == "biotimeout"
		return Main.fBioTimeout
	ElseIf k == "drunkmult"
		return Main.fDrunkMult
	ElseIf k == "range"
		return Main.fVictimRange
	ElseIf k == "guardrange"
		return Main.fGuardRange
	ElseIf k == "beast"
		return Main.iBeastChance as float
	ElseIf k == "caughtch"
		return Main.fCaughtChance
	ElseIf k == "betrayalch"
		return Main.fBetrayalChance
	ElseIf k == "jailch"
		return Main.fJailChance
	ElseIf k == "lingerch"
		return Main.fJailLingerChance
	ElseIf k == "lingerh"
		return Main.fLingerHours
	ElseIf k == "innch"
		return Main.fInnPlayerChance
	ElseIf k == "spikedch"
		return Main.fSpikedChance
	ElseIf k == "defeatch"
		return Main.fDefeatChance
	ElseIf k == "trespassch"
		return Main.fTrespassChance
	ElseIf k == "roadch"
		return Main.fRoadChance
	ElseIf k == "roadwaitch"
		return Main.fRoadWaitChance
	ElseIf k == "robpct"
		return Main.iRobberyPct as float
	ElseIf k == "robscene"
		return Main.fRobberySceneChance
	ElseIf k == "vampirech"
		return Main.fVampireChance
	ElseIf k == "blackmailch"
		return Main.fBlackmailChance
	ElseIf k == "crcamp"
		return Main.fCrCampChance
	ElseIf k == "crroam"
		return Main.fCrRoamChance
	ElseIf k == "ovratk"
		return Main.GetOverride(false)
	ElseIf k == "ovrcht"
		return Main.GetOverride(true)
	ElseIf k == "radius"
		return Main.fPlaceRadius
	EndIf
	return 0.0
EndFunction

Function SetF(string k, float v)
	If StringUtil.Substring(k, 0, 3) == "atk"
		CatSet(false, StringUtil.Substring(k, 3) as int, v)
	ElseIf StringUtil.Substring(k, 0, 3) == "cht"
		CatSet(true, StringUtil.Substring(k, 3) as int, v)
	ElseIf k == "cooldown"
		Main.fCooldownHours = v
	ElseIf k == "mindur"
		Main.fMinDuration = v
	ElseIf k == "maxdur"
		Main.fMaxDuration = v
	ElseIf k == "groupmax"
		Main.iGroupMax = v as int
	ElseIf k == "biotimeout"
		Main.fBioTimeout = v
	ElseIf k == "drunkmult"
		Main.fDrunkMult = v
	ElseIf k == "range"
		Main.fVictimRange = v
	ElseIf k == "guardrange"
		Main.fGuardRange = v
	ElseIf k == "beast"
		Main.iBeastChance = v as int
	ElseIf k == "caughtch"
		Main.fCaughtChance = v
	ElseIf k == "betrayalch"
		Main.fBetrayalChance = v
	ElseIf k == "jailch"
		Main.fJailChance = v
	ElseIf k == "lingerch"
		Main.fJailLingerChance = v
	ElseIf k == "lingerh"
		Main.fLingerHours = v
	ElseIf k == "innch"
		Main.fInnPlayerChance = v
	ElseIf k == "spikedch"
		Main.fSpikedChance = v
	ElseIf k == "defeatch"
		Main.fDefeatChance = v
	ElseIf k == "trespassch"
		Main.fTrespassChance = v
	ElseIf k == "roadch"
		Main.fRoadChance = v
	ElseIf k == "roadwaitch"
		Main.fRoadWaitChance = v
	ElseIf k == "robpct"
		Main.iRobberyPct = v as int
	ElseIf k == "robscene"
		Main.fRobberySceneChance = v
	ElseIf k == "vampirech"
		Main.fVampireChance = v
	ElseIf k == "blackmailch"
		Main.fBlackmailChance = v
	ElseIf k == "crcamp"
		Main.fCrCampChance = v
	ElseIf k == "crroam"
		Main.fCrRoamChance = v
	ElseIf k == "ovratk"
		Main.SetOverride(false, v)
	ElseIf k == "ovrcht"
		Main.SetOverride(true, v)
	ElseIf k == "radius"
		Main.fPlaceRadius = v
	EndIf
EndFunction

Function CatSet(bool cheat, int c, float v)
	If cheat
		If c == 0
			Main.fCheatWalledHome = v
		ElseIf c == 1
			Main.fCheatOtherHome = v
		ElseIf c == 2
			Main.fCheatInn = v
		ElseIf c == 3
			Main.fCheatCity = v
		ElseIf c == 4
			Main.fCheatSettlement = v
		ElseIf c == 5
			Main.fCheatWilderness = v
		ElseIf c == 6
			Main.fCheatCamp = v
		Else
			Main.fCheatDungeon = v
		EndIf
	Else
		If c == 0
			Main.fAtkWalledHome = v
		ElseIf c == 1
			Main.fAtkOtherHome = v
		ElseIf c == 2
			Main.fAtkInn = v
		ElseIf c == 3
			Main.fAtkCity = v
		ElseIf c == 4
			Main.fAtkSettlement = v
		ElseIf c == 5
			Main.fAtkWilderness = v
		ElseIf c == 6
			Main.fAtkCamp = v
		Else
			Main.fAtkDungeon = v
		EndIf
	EndIf
EndFunction

float Function CatDefault(bool cheat, int c)
	If cheat
		If c == 2
			return 8.0
		ElseIf c == 3 || c == 4
			return 3.0
		ElseIf c >= 6
			return 0.5
		EndIf
		return 1.0
	EndIf
	If c == 0
		return 0.0
	ElseIf c == 1 || c == 3
		return 1.0
	ElseIf c == 2
		return 1.5
	ElseIf c == 4
		return 3.0
	ElseIf c == 5
		return 6.0
	EndIf
	return 7.0
EndFunction

string Function FmtOf(string k)
	If k == "cooldown" || k == "lingerh"
		return "{1} h"
	ElseIf k == "mindur" || k == "maxdur" || k == "biotimeout"
		return "{0} s"
	ElseIf k == "range" || k == "guardrange" || k == "radius"
		return "{0} units"
	ElseIf k == "groupmax"
		return "{0}"
	ElseIf k == "drunkmult"
		return "x{1}"
	ElseIf k == "ovratk" || k == "ovrcht"
		return "{1}"
	ElseIf k == "beast" || k == "robpct" || k == "caughtch" || k == "defeatch" || k == "robscene" || k == "blackmailch"
		return "{0}%"
	EndIf
	return "{1}%"
EndFunction

; min, max, step, default
Function SliderSpec(string k)
	float v = GetF(k)
	float mn = 0.0
	float mx = 50.0
	float st = 0.1
	float df = 0.0
	If StringUtil.Substring(k, 0, 3) == "atk"
		df = CatDefault(false, StringUtil.Substring(k, 3) as int)
	ElseIf StringUtil.Substring(k, 0, 3) == "cht"
		df = CatDefault(true, StringUtil.Substring(k, 3) as int)
	ElseIf k == "cooldown"
		mx = 72.0
		st = 0.5
		df = 4.0
	ElseIf k == "mindur" || k == "maxdur"
		mn = 30.0
		mx = 300.0
		st = 5.0
		df = 60.0
		If k == "maxdur"
			df = 120.0
		EndIf
	ElseIf k == "groupmax"
		mn = 1.0
		mx = 3.0
		st = 1.0
		df = 2.0
	ElseIf k == "biotimeout"
		mn = 2.0
		mx = 20.0
		st = 1.0
		df = 8.0
	ElseIf k == "drunkmult"
		mn = 1.0
		mx = 5.0
		st = 0.1
		df = 2.0
	ElseIf k == "range"
		mn = 500.0
		mx = 4000.0
		st = 100.0
		df = 2000.0
	ElseIf k == "guardrange"
		mn = 500.0
		mx = 6000.0
		st = 100.0
		df = 3000.0
	ElseIf k == "radius"
		mx = 5000.0
		st = 50.0
	ElseIf k == "lingerh"
		mn = 0.1
		mx = 6.0
		df = 0.5
	ElseIf k == "ovratk" || k == "ovrcht"
		mn = -1.0
		df = -1.0
	ElseIf k == "beast" || k == "robpct" || k == "caughtch" || k == "defeatch" || k == "robscene" || k == "blackmailch"
		mx = 100.0
		st = 5.0
		If k == "beast"
			df = 40.0
		ElseIf k == "robpct"
			df = 25.0
		ElseIf k == "blackmailch"
			df = 25.0
		Else
			df = 50.0
		EndIf
	ElseIf k == "jailch"
		df = 10.0
	ElseIf k == "lingerch"
		mx = 100.0
		df = 15.0
	ElseIf k == "innch" || k == "spikedch" || k == "roadch"
		df = 3.0
	ElseIf k == "trespassch"
		df = 8.0
	ElseIf k == "roadwaitch" || k == "vampirech" || k == "crcamp"
		df = 5.0
	ElseIf k == "crroam"
		df = 1.0
	ElseIf k == "betrayalch"
		df = 2.0
	EndIf
	SetSliderDialogStartValue(v)
	SetSliderDialogRange(mn, mx)
	SetSliderDialogInterval(st)
	SetSliderDialogDefaultValue(df)
EndFunction

; ---------------- option helpers ----------------
int Function AddT(string label, string k, int flags = 0)
	int id = AddToggleOption(label, GetB(k), flags)
	If nT < 128
		tIds[nT] = id
		tKeys[nT] = k
		nT += 1
	EndIf
	return id
EndFunction

int Function AddS(string label, string k, int flags = 0)
	int id = AddSliderOption(label, GetF(k), FmtOf(k), flags)
	If nS < 128
		sIds[nS] = id
		sKeys[nS] = k
		nS += 1
	EndIf
	return id
EndFunction

string Function KeyOfT(int o)
	int i = tIds.Find(o)
	If i >= 0 && i < nT
		return tKeys[i]
	EndIf
	return ""
EndFunction

string Function KeyOfS(int o)
	int i = sIds.Find(o)
	If i >= 0 && i < nS
		return sKeys[i]
	EndIf
	return ""
EndFunction

Function ResetIds()
	tIds = new int[128]
	tKeys = new string[128]
	sIds = new int[128]
	sKeys = new string[128]
	int i = 0
	While i < 128
		tIds[i] = -100
		sIds[i] = -100
		i += 1
	EndWhile
	nT = 0
	nS = 0
	oMaster = -100
	oPanicKey = -100
	oMsg = -100
	oGender = -100
	oRecheck = -100
	oForceAttack = -100
	oForceCreature = -100
	oForceCheat = -100
	oForceJail = -100
	oForceInn = -100
	oForceSpiked = -100
	oForceTrespass = -100
	oForceRoad = -100
	oForceBetrayal = -100
	oForceVampire = -100
	oForceDefeat = -100
	oForceClear = -100
	oOvrClear = -100
	oJailHere = -100
	oUsePlaces = -100
	oPlaceCat = -100
	oPlaceName = -100
	oPlaceUntag = -100
	oPlaceRename = -100
	oPlaceApplyRadius = -100
	oPlaceDelete = -100
	oSerana = -100
	oFollower = None
EndFunction

; ---------------- pages ----------------
Event OnPageReset(string page)
	ResetIds()
	If genderOpts == None || jailOpts == None
		SetupPages()
	EndIf
	Main.InitArrays()
	SetCursorFillMode(TOP_TO_BOTTOM)
	If page == "" || page == "General"
		PageGeneral()
	ElseIf page == "Night attacks"
		PageNight()
	ElseIf page == "Relationships"
		PageRelationships()
	ElseIf page == "Jail & inns"
		PageJail()
	ElseIf page == "Danger"
		PageDanger()
	ElseIf page == "Creatures"
		PageCreatures()
	ElseIf page == "This location"
		PageLocation()
	ElseIf page == "Protected followers"
		PageProtected()
	ElseIf page == "Debug"
		PageDebug()
	EndIf
EndEvent

Function PageGeneral()
	AddHeaderOption("Master switch")
	oMaster = AddToggleOption("O'Deadly Skyrim enabled", Main.bMaster)
	oPanicKey = AddKeyMapOption("Panic key", Main.iPanicKey, OPTION_FLAG_WITH_UNMAP)
	AddT("Show 'O'Deadly Skyrim is off' after panic", "notice")
	If Main.iPanicKey <= 0
		AddTextOption("No panic key bound yet", "", OPTION_FLAG_DISABLED)
	EndIf
	If !Main.OStimOK()
		AddTextOption("OStim not found: nothing will run", "", OPTION_FLAG_DISABLED)
	EndIf
	AddHeaderOption("Installed mods")
	AddTextOption("OStim Standalone", YesNo(Main.OStimOK()), OPTION_FLAG_DISABLED)
	AddTextOption("powerofthree's Papyrus Extender", YesNo(Main.PO3OK()), OPTION_FLAG_DISABLED)
	AddTextOption("SkyrimNet", YesNo(Main.SNetOK()), OPTION_FLAG_DISABLED)
	AddTextOption("OCreatures", YesNo(Main.OCreaturesInstalled()), OPTION_FLAG_DISABLED)
	AddTextOption("OCum", YesNo(Main.OCumOK()), OPTION_FLAG_DISABLED)
	AddTextOption("ZaZ Animation Pack", YesNo(Main.ZaZOK()), OPTION_FLAG_DISABLED)
	AddTextOption("ODangerousNights", YesNo(Main.ODNLoaded()), OPTION_FLAG_DISABLED)
	AddHeaderOption("Victims")
	oGender = AddMenuOption("Victim gender", genderOpts[Main.iVictimGender])
	AddS("Victim search range", "range")
	SetCursorPosition(1)
	AddHeaderOption("Scenes")
	oMsg = AddMenuOption("Message style", msgOpts[Main.iMsgStyle])
	AddS("Cooldown between events", "cooldown")
	AddS("Min duration", "mindur")
	AddS("Max duration", "maxdur")
	AddT("Fallback to any scene", "fallback")
	AddT("Named / essential NPCs can take part", "named")
	AddT("Allow group scenes", "group")
	AddS("Group: extra participants", "groupmax", Flag(Main.bGroupScenes))
	AddT("Group: two victims together", "groupboth", Flag(Main.bGroupScenes))
	AddT("NPC character filter", "morality")
	AddHeaderOption("SkyrimNet")
	AddT("Narration when it starts", "snstart")
	AddT("Memory afterwards", "snlog")
	AddT("Rumours", "rumors")
	AddT("Ask SkyrimNet if the NPC would", "bio", Flag(Main.SNetOK()))
	AddS("SkyrimNet answer timeout", "biotimeout", Flag(Main.SNetOK() && Main.bBioCheck))
	AddHeaderOption("Modifiers")
	AddT("Drunk / skooma raises chances", "drunkmod")
	AddS("Drunk multiplier", "drunkmult", Flag(Main.bDrunkMod))
EndFunction

Function PageNight()
	AddHeaderOption("Night attacks")
	AddT("Enable night attacks", "sleep")
	int f = Flag(Main.bSleepEnabled)
	AddT("Player can be a victim", "pvsleep", f)
	AddT("Waiting counts as sleeping", "waitsleep", f)
	AddHeaderOption("Attackers")
	AddT("Use nearby hostiles first", "nearby", f)
	AddT("Bandits", "bandit", f)
	AddS("Creature chance", "beast", Flag(Main.bSleepEnabled && Main.AnyCreatureOK()))
	If !Main.AnyCreatureOK()
		AddTextOption("  Creatures: see Creatures page", "", OPTION_FLAG_DISABLED)
	EndIf
	AddHeaderOption("Guards")
	AddT("Nearby guards prevent attacks", "guards")
	AddS("Guard range", "guardrange", Flag(Main.bGuardsBlock))
	AddT("Guards can be attackers", "guardatk")
	AddT("Guards can be victims", "guardvic")
	SetCursorPosition(1)
	AddHeaderOption("Attack chance per hour slept (0 = never)")
	int c = 0
	While c < 8
		AddS(Main.CategoryName(c), "atk" + c, f)
		c += 1
	EndWhile
	AddTextOption("Current place: " + Main.CategoryName(Main.GetLocCategory()), "", OPTION_FLAG_DISABLED)
EndFunction

Function PageRelationships()
	AddHeaderOption("Cheating spouse")
	AddT("Enable cheating spouse", "cheat")
	int f = Flag(Main.bCheatEnabled)
	AddT("Partners: locals / patrons only", "patrons", f)
	AddT("Partners: followers allowed", "pfol", f)
	AddT("Partners: guards allowed", "pgrd", f)
	AddT("Partners: same gender allowed", "psame", f)
	AddT("Treat Lover-rank followers as spouse", "lover", f)
	AddT("Inns: 'patrons drunk' SkyrimNet event", "drunkevent")
	AddHeaderOption("Caught in the act")
	AddT("Spouse / follower can catch you", "caught")
	AddS("Chance", "caughtch", Flag(Main.bCaught))
	AddHeaderOption("Follower betrayal")
	AddT("Followers can take advantage of you", "betrayal")
	AddS("Chance per hour (asleep or drunk)", "betrayalch", Flag(Main.bBetrayal))
	SetCursorPosition(1)
	AddHeaderOption("Cheating chance per hour slept")
	int c = 0
	While c < 8
		AddS(Main.CategoryName(c), "cht" + c, f)
		c += 1
	EndWhile
EndFunction

Function PageJail()
	AddHeaderOption("Imprisonment & barracks")
	AddT("Enable", "jail")
	int f = Flag(Main.bJailEnabled)
	AddT("Player can be taken", "jailplayer", f)
	AddT("Followers can be taken", "jailfol", f)
	AddS("Chance per hour slept / waited", "jailch", f)
	AddS("Chance per linger check", "lingerch", f)
	AddS("Linger before a check", "lingerh", f)
	AddT("Copy extra guards for group scenes", "jailspawn", Flag(Main.bJailEnabled && Main.bGroupScenes))
	AddT("Pay your bounty with your body", "arrest", f)
	AddT("ZaZ: restraints / made to watch", "zaz", Flag(Main.bJailEnabled && Main.ZaZOK()))
	If !Main.ZaZOK()
		AddTextOption("  ZaZ not installed", "", OPTION_FLAG_DISABLED)
	EndIf
	string here = "No"
	If Main.InJail()
		here = "Jail"
	ElseIf Main.InBarracks()
		here = "Barracks"
	EndIf
	AddTextOption("Jail / barracks here", here, OPTION_FLAG_DISABLED)
	SetCursorPosition(1)
	AddHeaderOption("Inns")
	AddT("Drunk patrons can take the player", "innplayer")
	AddS("Chance per hour slept / waited", "innch", Flag(Main.bInnPlayer))
	AddT("Spiked drinks", "spiked")
	int g = Flag(Main.bSpiked)
	AddS("Spiked drink chance per hour", "spikedch", g)
	AddT("Spiked: player", "spikedplayer", g)
	AddT("Spiked: followers", "spikedfol", g)
EndFunction

Function PageDanger()
	AddHeaderOption("Defeat")
	AddT("Enable defeat", "defeat")
	int f = Flag(Main.bDefeatEnabled)
	AddS("Chance when downed", "defeatch", f)
	AddT("Player can be taken", "defeatplayer", f)
	AddT("Keep the player alive for defeat", "essential", Flag(Main.bDefeatEnabled && Main.bDefeatPlayer))
	AddT("Downed followers can be taken", "defeatfol", f)
	AddHeaderOption("Trespass")
	AddT("Enable trespass", "trespass")
	int t = Flag(Main.bTrespassEnabled)
	AddS("Chance per hour", "trespassch", t)
	AddT("Player can be taken", "trespassplayer", t)
	AddT("Followers can be taken", "trespassfol", t)
	AddHeaderOption("Travel & roads")
	AddT("Enable road encounters", "travel")
	int r = Flag(Main.bTravelEnabled)
	AddS("Chance per game hour outdoors", "roadch", r)
	AddS("Chance per hour waited outdoors", "roadwaitch", r)
	AddS("Gold taken", "robpct", r)
	AddS("Robbery turns into a scene", "robscene", r)
	AddT("Player can be taken", "travelplayer", r)
	AddT("Followers can be taken", "travelfol", r)
	SetCursorPosition(1)
	AddHeaderOption("Vampires")
	AddT("Vampire seduction in lairs / dungeons", "vampire")
	AddS("Chance per hour slept", "vampirech", Flag(Main.bVampire))
	AddHeaderOption("Aftermath")
	AddT("Blackmail later", "blackmail", Flag(Main.SNetOK()))
	AddS("Blackmail chance", "blackmailch", Flag(Main.SNetOK() && Main.bBlackmail))
	AddT("Public rumours after jail / defeat", "leftover", Flag(Main.SNetOK()))
	AddT("OCum: messy aftermath in memories", "ocum", Flag(Main.OCumOK()))
	If !Main.OCumOK()
		AddTextOption("  OCum not installed", "", OPTION_FLAG_DISABLED)
	EndIf
	AddHeaderOption("Not available in 0.1")
	AddTextOption("Failed pickpocket / brawl escalation", "Locked", OPTION_FLAG_DISABLED)
EndFunction

Function PageCreatures()
	bool ocr = Main.OCreaturesInstalled()
	AddHeaderOption("OCreatures encounters")
	If !ocr
		AddTextOption("OCreatures not installed: locked off", "", OPTION_FLAG_DISABLED)
	EndIf
	AddT("Enable creature encounters", "cr", Flag(ocr))
	bool on = ocr && Main.bCrEnabled
	AddT("Creatures can take followers", "crfol", Flag(on))
	AddT("Creatures can take the player", "crplayer", Flag(on))
	AddS("Chance per hour camping outdoors", "crcamp", Flag(on))
	AddS("Chance per game hour in the wild", "crroam", Flag(on))
	oRecheck = AddTextOption("Re-check creature support", "", Flag(on))
	SetCursorPosition(1)
	AddHeaderOption("Creature types")
	int t = 0
	While t < 7
		int st = Main.iCrStatus[t]
		If !ocr
			st = 0
		EndIf
		AddT(Main.CrName(t), "ct" + t, Flag(on && st == 2))
		AddTextOption("  " + StatusText(st), "", OPTION_FLAG_DISABLED)
		t += 1
	EndWhile
EndFunction

Function PageLocation()
	AddHeaderOption("Current location")
	AddTextOption(Main.CurrentLocName(), "", OPTION_FLAG_DISABLED)
	AddTextOption("Category", Main.CategoryName(Main.GetLocCategory()), OPTION_FLAG_DISABLED)
	AddTextOption("Category attack chance", Main.CatAttack(Main.GetLocCategory()) + "%", OPTION_FLAG_DISABLED)
	AddTextOption("Category cheating chance", Main.CatCheat(Main.GetLocCategory()) + "%", OPTION_FLAG_DISABLED)
	SetCursorPosition(1)
	AddHeaderOption("Override for this place (-1 = use category)")
	AddS("Attack chance here", "ovratk")
	AddS("Cheating chance here", "ovrcht")
	oJailHere = AddMenuOption("Jail / barracks here", jailOpts[Main.GetJailOverride()])
	oOvrClear = AddTextOption("Clear overrides here", "")
	AddHeaderOption("SkyrimNet places")
	If !Main.PlacesAvailable()
		AddTextOption("Needs SkyrimNet beta29 or newer", "", OPTION_FLAG_DISABLED)
		return
	EndIf
	AddT("Use SkyrimNet places", "places")
	int pf = Flag(Main.bUsePlaces)
	string pn = Main.CurrentPlaceName()
	int ptag = Main.PlaceCategory()
	string tagTxt = "(none)"
	If ptag >= 0
		tagTxt = Main.CategoryName(ptag)
	EndIf
	If pn == ""
		AddTextOption("Place here", "(none)", OPTION_FLAG_DISABLED)
		oPlaceName = AddInputOption("Name for a new place", sNewPlaceName, pf)
	Else
		AddTextOption("Place here", pn, OPTION_FLAG_DISABLED)
	EndIf
	oPlaceCat = AddMenuOption("Mark this spot as...", tagTxt, pf)
	If pn != ""
		oPlaceUntag = AddTextOption("Forget category here", "", pf)
		oPlaceRename = AddInputOption("Rename this place", pn, pf)
		oPlaceApplyRadius = AddTextOption("Apply radius to this place", "", pf)
		oPlaceDelete = AddTextOption("Delete this SkyrimNet place", "", pf)
	EndIf
	AddS("Radius for marks (0 = default)", "radius", pf)
EndFunction

Function PageProtected()
	AddHeaderOption("Followers nearby (checked = never a victim)")
	oFollower = new int[32]
	kFollower = new Actor[32]
	Actor[] near = OActorUtil.GetActorsInRangeV2(Game.GetPlayer(), 6000.0, false, false, false)
	int c = 0
	int i = 0
	While i < near.Length && c < 32
		Actor a = near[i]
		If a && Main.IsFollowerActor(a)
			kFollower[c] = a
			bool prot = Main.Protected && Main.Protected.Find(a.GetActorBase()) >= 0
			oFollower[c] = AddToggleOption(a.GetDisplayName(), prot)
			c += 1
		EndIf
		i += 1
	EndWhile
	If c == 0
		AddTextOption("No followers nearby", "", OPTION_FLAG_DISABLED)
	EndIf
	SetCursorPosition(1)
	AddHeaderOption("Always protected")
	oSerana = AddToggleOption("Protect Serana", Main.bProtectSerana)
	AddTextOption("Children are always excluded", "", OPTION_FLAG_DISABLED)
EndFunction

Function PageDebug()
	AddHeaderOption("Debug")
	AddT("Enable debug tools", "debugtools")
	AddT("Debug notifications", "debug")
	AddTextOption("Pending force", ForceName(), OPTION_FLAG_DISABLED)
	oForceClear = AddTextOption("Clear pending force", "", Flag(Main.iForceMode > 0))
	SetCursorPosition(1)
	AddHeaderOption("Force on next sleep / wait (1h+)")
	int f = Flag(Main.bDebugTools && Main.bMaster)
	oForceAttack = AddTextOption("Night attack", "", f)
	oForceCreature = AddTextOption("Creature encounter", "", Flag(Main.bDebugTools && Main.bMaster && Main.AnyCreatureOK()))
	oForceCheat = AddTextOption("Cheating spouse", "", Flag(Main.bDebugTools && Main.bMaster && Main.bCheatEnabled))
	oForceJail = AddTextOption("Jail / barracks", "", f)
	oForceInn = AddTextOption("Inn patrons", "", f)
	oForceSpiked = AddTextOption("Spiked drink", "", f)
	oForceTrespass = AddTextOption("Trespass", "", f)
	oForceRoad = AddTextOption("Road robbery (wait outdoors)", "", f)
	oForceBetrayal = AddTextOption("Follower betrayal", "", f)
	oForceVampire = AddTextOption("Vampire", "", f)
	oForceDefeat = AddTextOption("Defeat (next bleedout)", "", f)
	If !Main.bMaster
		AddTextOption("  Turn the master switch on first", "", OPTION_FLAG_DISABLED)
	EndIf
EndFunction

string Function ForceName()
	int m = Main.iForceMode
	If m == 0
		return "None"
	ElseIf m == Main.K_ATTACK
		return "Night attack"
	ElseIf m == Main.K_CHEAT
		return "Cheating"
	ElseIf m == Main.K_JAIL
		return "Jail"
	ElseIf m == Main.K_INN
		return "Inn patrons"
	ElseIf m == Main.K_SPIKED
		return "Spiked drink"
	ElseIf m == Main.K_DEFEAT
		return "Defeat"
	ElseIf m == Main.K_TRESPASS
		return "Trespass"
	ElseIf m == Main.K_ROAD
		return "Road"
	ElseIf m == Main.K_CREATURE
		return "Creature"
	ElseIf m == Main.K_BETRAYAL
		return "Betrayal"
	EndIf
	return "Vampire"
EndFunction

; ---------------- events ----------------
Function SetForce(int k, string label)
	Main.iForceMode = k
	ShowMessage("Next sleep or wait of 1h+ will force: " + label + ". It still needs a valid victim, partner and installed scene.", false)
	ForcePageReset()
EndFunction

Event OnOptionSelect(int o)
	If o == oMaster
		If Main.bMaster
			Main.Panic()
		Else
			Main.EnableMaster()
			If Main.iPanicKey <= 0 && !Main.bNoKeyWarned
				Main.bNoKeyWarned = true
				ShowMessage("O'Deadly Skyrim is now ON.\n\nBind a Panic key on this page: one press stops any scene from this mod, cleans up, and turns the mod off again.", false)
			EndIf
		EndIf
		ForcePageReset()
		return
	EndIf
	string k = KeyOfT(o)
	If k != ""
		SetB(k, !GetB(k))
		SetToggleOptionValue(o, GetB(k))
		If k == "defeat" || k == "defeatplayer" || k == "essential" || k == "defeatfol"
			Main.UpdateEssential()
			Main.FillFollowerAliases()
		EndIf
		If k == "cr" && Main.bCrEnabled && Main.bMaster
			Main.DetectCreatures()
		EndIf
		If k == "jail" || k == "travel" || k == "cr"
			If Main.bMaster
				Main.RefreshTimers(Game.GetPlayer().GetCurrentLocation())
			EndIf
		EndIf
		ForcePageReset()
		return
	EndIf
	If o == oRecheck
		SetTextOptionValue(o, "Checking...")
		Main.DetectCreatures()
		ForcePageReset()
	ElseIf o == oSerana
		Main.bProtectSerana = !Main.bProtectSerana
		SetToggleOptionValue(o, Main.bProtectSerana)
	ElseIf o == oOvrClear
		Main.ClearOverridesHere()
		ForcePageReset()
	ElseIf o == oPlaceUntag
		Main.UntagHere()
		ForcePageReset()
	ElseIf o == oPlaceApplyRadius
		If Main.SetRadiusHere(Main.fPlaceRadius)
			ShowMessage("Radius sent to SkyrimNet.", false)
		Else
			ShowMessage("SkyrimNet refused the change.", false)
		EndIf
	ElseIf o == oPlaceDelete
		If ShowMessage("Delete this place from SkyrimNet's library? This affects SkyrimNet in every playthrough.", true, "Delete", "Cancel")
			If !Main.DeletePlaceHere()
				ShowMessage("SkyrimNet refused.", false)
			EndIf
			ForcePageReset()
		EndIf
	ElseIf o == oForceClear
		Main.iForceMode = 0
		ForcePageReset()
	ElseIf o == oForceAttack
		SetForce(Main.K_ATTACK, "night attack")
	ElseIf o == oForceCreature
		SetForce(Main.K_CREATURE, "creature encounter")
	ElseIf o == oForceCheat
		SetForce(Main.K_CHEAT, "cheating spouse")
	ElseIf o == oForceJail
		SetForce(Main.K_JAIL, "jail / barracks")
	ElseIf o == oForceInn
		SetForce(Main.K_INN, "inn patrons")
	ElseIf o == oForceSpiked
		SetForce(Main.K_SPIKED, "spiked drink")
	ElseIf o == oForceTrespass
		SetForce(Main.K_TRESPASS, "trespass")
	ElseIf o == oForceRoad
		SetForce(Main.K_ROAD, "road robbery")
	ElseIf o == oForceBetrayal
		SetForce(Main.K_BETRAYAL, "follower betrayal")
	ElseIf o == oForceVampire
		SetForce(Main.K_VAMPIRE, "vampire")
	ElseIf o == oForceDefeat
		Main.iForceMode = Main.K_DEFEAT
		ShowMessage("The next bleedout of the player or a follower will force a defeat scene (if Defeat and that victim type are enabled).", false)
		ForcePageReset()
	ElseIf oFollower
		int i = oFollower.Find(o)
		If i >= 0 && kFollower[i]
			SetToggleOptionValue(o, Main.ToggleProtected(kFollower[i]))
		EndIf
	EndIf
EndEvent

Event OnOptionKeyMapChange(int o, int keyCode, string conflictControl, string conflictName)
	If o != oPanicKey
		return
	EndIf
	If conflictControl != "" && keyCode > 0
		string who = conflictControl
		If conflictName != ""
			who = conflictName + ": " + conflictControl
		EndIf
		If !ShowMessage("This key is already used by " + who + ". Use it anyway?", true, "Yes", "No")
			return
		EndIf
	EndIf
	Main.iPanicKey = keyCode
	Main.RegisterPanicKey()
	SetKeyMapOptionValue(o, keyCode)
	ForcePageReset()
EndEvent

Event OnOptionSliderOpen(int o)
	string k = KeyOfS(o)
	If k != ""
		SliderSpec(k)
	EndIf
EndEvent

Event OnOptionSliderAccept(int o, float v)
	string k = KeyOfS(o)
	If k != ""
		SetF(k, v)
		SetSliderOptionValue(o, v, FmtOf(k))
	EndIf
EndEvent

Event OnOptionMenuOpen(int o)
	If o == oGender
		SetMenuDialogOptions(genderOpts)
		SetMenuDialogStartIndex(Main.iVictimGender)
		SetMenuDialogDefaultIndex(0)
	ElseIf o == oMsg
		SetMenuDialogOptions(msgOpts)
		SetMenuDialogStartIndex(Main.iMsgStyle)
		SetMenuDialogDefaultIndex(1)
	ElseIf o == oJailHere
		SetMenuDialogOptions(jailOpts)
		SetMenuDialogStartIndex(Main.GetJailOverride())
		SetMenuDialogDefaultIndex(0)
	ElseIf o == oPlaceCat
		If catOpts == None || catOpts.Length != 10
			catOpts = new string[10]
			int c = 0
			While c < 9
				catOpts[c] = Main.CategoryName(c)
				c += 1
			EndWhile
			catOpts[9] = "(no category)"
		EndIf
		SetMenuDialogOptions(catOpts)
		int cur = Main.PlaceCategory()
		If cur < 0
			cur = 9
		EndIf
		SetMenuDialogStartIndex(cur)
		SetMenuDialogDefaultIndex(9)
	EndIf
EndEvent

Event OnOptionMenuAccept(int o, int i)
	If i < 0
		return
	EndIf
	If o == oGender
		Main.iVictimGender = i
		SetMenuOptionValue(o, genderOpts[i])
	ElseIf o == oMsg
		Main.iMsgStyle = i
		SetMenuOptionValue(o, msgOpts[i])
	ElseIf o == oJailHere
		Main.SetJailOverride(i)
		ForcePageReset()
	ElseIf o == oPlaceCat
		If i == 9
			Main.UntagHere()
		Else
			int r = Main.MarkHere(sNewPlaceName, i)
			If r == 0
				ShowMessage("SkyrimNet refused to mark this spot.", false)
			ElseIf r == 1 && Main.CurrentPlaceName() == ""
				ShowMessage("Marked. SkyrimNet saves it in the background; reopen this page in a moment.", false)
			EndIf
		EndIf
		ForcePageReset()
	EndIf
EndEvent

Event OnOptionInputOpen(int o)
	If o == oPlaceName
		SetInputDialogStartText(sNewPlaceName)
	ElseIf o == oPlaceRename
		SetInputDialogStartText(Main.CurrentPlaceName())
	EndIf
EndEvent

Event OnOptionInputAccept(int o, string t)
	If o == oPlaceName
		If t != ""
			sNewPlaceName = t
		EndIf
		SetInputOptionValue(o, sNewPlaceName)
	ElseIf o == oPlaceRename && t != ""
		If !Main.RenamePlaceHere(t)
			ShowMessage("SkyrimNet refused the rename.", false)
		EndIf
		ForcePageReset()
	EndIf
EndEvent

; ---------------- info text ----------------
string Function Hint(string k)
	If k == "notice"
		return "After the panic key (or switching the mod off) show a plain 'O'Deadly Skyrim is off.' notice. OFF = completely silent."
	ElseIf k == "pvsleep"
		return "OFF (default): night attacks only target followers. ON: you can be the victim too."
	ElseIf k == "waitsleep"
		return "Also roll night attacks when you wait (not only when you sleep)."
	ElseIf k == "nearby"
		return "Use a real hostile already nearby before spawning one."
	ElseIf k == "guards"
		return "ON (default): a non-hostile guard within range stops night attacks. Never blocks cheating. Jail / barracks events ignore this."
	ElseIf k == "guardatk"
		return "OFF (default). ON: guards can be attackers in other modules. In jails, night attacks then ignore guard blocking."
	ElseIf k == "guardvic"
		return "OFF (default). ON: a guard who is your follower can be a victim."
	ElseIf k == "fallback"
		return "If no aggressive / forced / rough scene exists for the pair, allow another scene."
	ElseIf k == "named"
		return "OFF (default): essential or protected unique NPCs (quest characters) are never used as attackers or partners."
	ElseIf k == "group"
		return "OFF (default). Jails, barracks, camps, bandits, defeat and creatures can use several attackers if OStim has a matching group scene; otherwise one on one."
	ElseIf k == "groupboth"
		return "Group scenes may take two victims at once (player and a follower, or two followers), if OStim has such a scene."
	ElseIf k == "morality"
		return "Without a SkyrimNet answer, peaceful NPCs only take part if their character allows it (low Morality, or they dislike the victim)."
	ElseIf k == "bio"
		return "Asks SkyrimNet's decision model, from the NPC's bio, whether they would do it. Needs a SkyrimNet decisions provider; otherwise the character filter is used."
	ElseIf k == "snstart"
		return "SkyrimNet: describe the event when it starts so nearby NPCs react."
	ElseIf k == "snlog"
		return "SkyrimNet: remember what happened so characters can bring it up later."
	ElseIf k == "rumors"
		return "SkyrimNet: short-lived rumours about what happened, where it happened."
	ElseIf k == "drunkmod"
		return "If you are drunk or on skooma (detected from active effects), inn, trespass, betrayal and night-attack chances are multiplied. No effect when those modules are off."
	ElseIf k == "cheat"
		return "OFF by default. If your spouse is nearby you may wake to them with someone else. Consensual scenes only."
	ElseIf k == "patrons"
		return "Only non-follower, non-guard locals can be the partner."
	ElseIf k == "lover"
		return "Also treat a follower at relationship rank Lover as your spouse."
	ElseIf k == "drunkevent"
		return "In inns, also tell SkyrimNet the patrons have been drinking heavily."
	ElseIf k == "caught"
		return "When another mod starts an OStim scene with you, your spouse or a follower nearby may walk in on it. SkyrimNet handles the rest."
	ElseIf k == "betrayal"
		return "OFF by default. A follower whose character allows it may take advantage of you while you sleep, are drunk, or are downed."
	ElseIf k == "jail"
		return "OFF by default. Jails and guard barracks in every hold. Rolls when you sleep or wait there, or after you linger a while. Never the moment you walk in."
	ElseIf k == "jailspawn"
		return "If there are not enough guards for a group scene, copy a guard who is already there."
	ElseIf k == "arrest"
		return "In 0.1 this works in jail only: after a jail scene with you, your bounty in that hold is cleared. The guard's arrest dialogue is not changed."
	ElseIf k == "zaz"
		return "With ZaZ installed: jail scenes prefer bondage / restrained scenes, and you may be made to watch."
	ElseIf k == "lingerh"
		return "Game hours in a jail or barracks before a linger roll. One roll per period, no polling."
	ElseIf k == "innplayer"
		return "OFF by default. Drunk patrons may go after you when you sleep or wait in an inn."
	ElseIf k == "spiked"
		return "OFF by default. When you sleep or wait in an inn, someone may have spiked a drink."
	ElseIf k == "defeat"
		return "OFF by default. When you or a follower are downed (bleedout), the winner may take them. Event-based."
	ElseIf k == "essential"
		return "The player only enters bleedout if essential. ON: this mod keeps you essential while Defeat is on. If no defeat scene happens, you die normally."
	ElseIf k == "trespass"
		return "OFF by default. Sleeping or waiting in someone else's home can let the owner find you."
	ElseIf k == "travel"
		return "OFF by default. Robbers on the road (one roll per game hour outdoors, plus waiting). Stolen gold goes into the robber's pockets and can be taken back."
	ElseIf k == "vampire"
		return "OFF by default. In vampire lairs and dungeons, a vampire already there may entrance a victim while you sleep."
	ElseIf k == "blackmail"
		return "Someone who took part may bring it up later through SkyrimNet. One time, no quest."
	ElseIf k == "leftover"
		return "After jail or defeat events, word spreads and a bystander comments (SkyrimNet)."
	ElseIf k == "ocum"
		return "With OCum installed, SkyrimNet memories mention the mess left behind."
	ElseIf k == "cr"
		return "Locked off unless OCreatures is installed. Only creature types with installed scenes are used. No creature files are included."
	ElseIf k == "crplayer"
		return "OFF by default, even when creatures are available."
	EndIf
	return ""
EndFunction

Event OnOptionHighlight(int o)
	If o == oMaster
		SetInfoText("Master switch for everything in this mod. OFF (default) = nothing ever happens. Turning it OFF works like the panic key.")
	ElseIf o == oPanicKey
		SetInfoText("One press: stops any scene this mod started, removes spawned actors, gives stolen gold back, and turns the whole mod OFF until you turn it on again.")
	ElseIf o == oJailHere
		SetInfoText("Tag this location as a jail / barracks (for modded or custom cells), or exclude it.")
	ElseIf o == oRecheck
		SetInfoText("Probe OStim again for each creature type (stand near a follower for best results).")
	Else
		string k = KeyOfT(o)
		If k == ""
			k = KeyOfS(o)
		EndIf
		If StringUtil.Substring(k, 0, 3) == "atk" || StringUtil.Substring(k, 0, 3) == "cht"
			SetInfoText("Percent per hour slept. 0 = never.")
		ElseIf k != ""
			string h = Hint(k)
			If h != ""
				SetInfoText(h)
			EndIf
		EndIf
	EndIf
EndEvent
