# Builds ODeadlySkyrim.esp (ESL-flagged, master Skyrim.esm only). ESL plugin builder.
import struct, sys
OWN = 0x01000000
def sub(t, b): return t.encode() + struct.pack('<H', len(b)) + b
def z(s): return s.encode() + b'\0'
def rec(t, fid, subs_, flags=0):
    d = b''.join(subs_)
    return t.encode() + struct.pack('<IIIIHH', len(d), flags, fid, 0, 44, 0) + d
def grup(label, rs):
    body = b''.join(rs)
    return b'GRUP' + struct.pack('<I', 24 + len(body)) + label.encode() + struct.pack('<IIHH', 0, 0, 0, 0) + body
def ws(s): b = s.encode(); return struct.pack('<H', len(b)) + b
def pobj(name, fid, alias=-1): return ws(name) + bytes([1, 1]) + struct.pack('<HhI', 0, alias, fid)
def script(name, props): return ws(name) + b'\0' + struct.pack('<H', len(props)) + b''.join(props)
def vmad_quest(scripts, aliases):
    b = struct.pack('<hhH', 5, 2, len(scripts)) + b''.join(scripts)
    b += b'\x02' + struct.pack('<H', 0) + ws('') + struct.pack('<H', len(aliases))
    for aid, qfid, ascripts in aliases:
        b += struct.pack('<HhI', 0, aid, qfid) + struct.pack('<hhH', 5, 2, len(ascripts)) + b''.join(ascripts)
    return b
def alias(aid, name, flags, forced=None):
    s = [sub('ALST', struct.pack('<I', aid)), sub('ALID', z(name)), sub('FNAM', struct.pack('<I', flags))]
    if forced is not None: s.append(sub('ALFR', struct.pack('<I', forced)))
    s.append(sub('ALED', b''))
    return s

MAINQ, MCMQ = OWN | 0x800, OWN | 0x801
pools = [
    ('ODS_PoolBandit',   0x810, (0x39CFC, 0x3DEC8, 0x3DEC9)),
    ('ODS_PoolWerewolf', 0x811, (0x1E791,)),
    ('ODS_PoolDraugr',   0x812, (0x55936, 0xBF7A9, 0x1E772, 0xBF7AD)),
    ('ODS_PoolTroll',    0x813, (0x23ABA, 0x23ABB)),
    ('ODS_PoolFalmer',   0x814, (0x23A99,)),
    ('ODS_PoolSpriggan', 0x815, (0x23AB9,)),
    ('ODS_PoolGiant',    0x816, (0x23AAE,)),
    ('ODS_PoolHagraven', 0x817, (0x23AB0,)),
    # 0.2 (all vanilla Skyrim.esm forms)
    ('ODS_PoolVampire',  0x818, (0x107A9B, 0x107A9C, 0x107A9D, 0x107A9E, 0x107A9F, 0x3387E, 0x3387F, 0x33880, 0x33881, 0x33882)),
    ('ODS_PoolWatcher',  0x819, (0x73FBE,)),   # hunter
    ('ODS_AlcoholVanilla', 0x81A, (0x34C5E, 0x3133B, 0x2C35A, 0xF693F, 0x508CA, 0x34C5D, 0x555E8, 0x85368, 0xC5349,
                                   0x3133C, 0xC5348, 0x9380D, 0xDC172, 0x65C39, 0xB91D7, 0xD055E, 0x65C37, 0x65C38, 0x36D53)),
    ('ODS_PoolFauna',    0x81B, (0x6DC9D,)),   # hare
    ('ODS_PoolButterfly', 0x81C, (0x22219, 0x2221E, 0xB97AF)),   # blue butterfly, luna moth, monarch
    # 0.9 roadside events (vanilla Skyrim.esm only; never unique / quest NPCs)
    ('ODS_PoolTraveler', 0x81D, (0x73FBE, 0xBD759, 0xBD75E, 0x1034E4, 0x1034E6)),  # hunter, farmer templates, WE farmers
    ('ODS_PoolVigilant', 0x81E, (0x10C44E, 0x10C453, 0x10C454, 0x10C455, 0x10C457,
                                 0x10C46F, 0x10C470, 0x10C471, 0x10C476, 0x10C477,
                                 0x10C478, 0x10C479, 0x10C47C)),  # generic Vigilant of Stendarr (never Carcette 0xBFB55)
]
fl = [rec('FLST', OWN | lid, [sub('EDID', z(ed))] + [sub('LNAM', struct.pack('<I', x)) for x in ids]) for ed, lid, ids in pools]

OPT, ALLOW_DEAD, ESSENTIAL, ALLOW_DISABLED = 0x2, 0x10, 0x40, 0x80
STAGE = OPT | ALLOW_DEAD | ALLOW_DISABLED
aliases = [  # id, name, flags, forced, script
    (0, 'Player', 0, 0x14, 'ODS_PlayerAlias'),
    (1, 'Attacker', STAGE, None, 'ODS_AttackerAlias'),
    (2, 'Victim', STAGE, None, 'ODS_VictimAlias'),
    (3, 'Victim2', STAGE, None, 'ODS_VictimAlias'),
    (4, 'Extra1', STAGE, None, 'ODS_AttackerAlias'),
    (5, 'Extra2', STAGE, None, 'ODS_AttackerAlias'),
    (6, 'Extra3', STAGE, None, 'ODS_AttackerAlias'),
    (7, 'PlayerEssential', OPT | ESSENTIAL, None, None),
    (8, 'Follower1', STAGE, None, 'ODS_FollowerAlias'),
    (9, 'Follower2', STAGE, None, 'ODS_FollowerAlias'),
    (10, 'Follower3', STAGE, None, 'ODS_FollowerAlias'),
    (11, 'Follower4', STAGE, None, 'ODS_FollowerAlias'),
]
main_props = [pobj('PlayerRef', 0x14),
    pobj('AttackerAlias', MAINQ, 1), pobj('VictimAlias', MAINQ, 2), pobj('Victim2Alias', MAINQ, 3),
    pobj('Extra1Alias', MAINQ, 4), pobj('Extra2Alias', MAINQ, 5), pobj('Extra3Alias', MAINQ, 6),
    pobj('EssentialAlias', MAINQ, 7),
    pobj('Follower1Alias', MAINQ, 8), pobj('Follower2Alias', MAINQ, 9), pobj('Follower3Alias', MAINQ, 10), pobj('Follower4Alias', MAINQ, 11),
    pobj('PlayerFaction', 0xDB1), pobj('CurrentFollowerFaction', 0x5C84E),
    pobj('FadeToBlackHoldIMod', 0xF756E), pobj('FadeToBlackBackIMod', 0xF756F),
    pobj('Gold001', 0xF)] + [pobj(ed, OWN | lid) for ed, lid, _ in pools] + [pobj('ODS_SaviorChoice', OWN | 0x81F)] + [  # 1.0 (new FormIDs appended)
    pobj('ODS_JoinChoice', OWN | 0x820), pobj('ODS_WildChoice', OWN | 0x821),
    pobj('ODS_BeastPreyChoice', OWN | 0x822), pobj('ODS_BeastClaimChoice', OWN | 0x823)] + [  # 1.0 Bitch in Heat
    pobj('ODS_PoolHeatWolf', OWN | 0x825), pobj('ODS_HeatPackFaction', OWN | 0x824),
    pobj('PlayerWerewolfFaction', 0x91822), pobj('PlayerFollowerFaction', 0x84D1B),
    pobj('ODS_HeatAllow1', OWN | 0x826), pobj('ODS_HeatAllow2', OWN | 0x827), pobj('ODS_HeatAllow3', OWN | 0x828),
    pobj('ODS_HeatChoice', OWN | 0x829), pobj('ODS_HeatQuest', OWN | 0x82A),
    pobj('HeatWolf1Alias', OWN | 0x82A, 0), pobj('HeatWolf2Alias', OWN | 0x82A, 1), pobj('HeatWolf3Alias', OWN | 0x82A, 2)]
v_main = vmad_quest([script('ODS_Main', main_props)],
    [(aid, MAINQ, [script(sc, [])]) for aid, _, _, _, sc in aliases if sc])
alias_subs = []
for aid, nm, flg, forced, _ in aliases:
    alias_subs += alias(aid, nm, flg, forced)
qmain = rec('QUST', MAINQ, [sub('EDID', z('ODS_MainQuest')), sub('VMAD', v_main), sub('FULL', z("O'Deadly Skyrim")),
    sub('DNAM', bytes.fromhex('01003cff0000000000000000')), sub('FLTR', z('ODeadlySkyrim\\')), sub('NEXT', b''),
    sub('ANAM', struct.pack('<I', len(aliases)))] + alias_subs)
v_mcm = vmad_quest([script('ODS_MCM', [pobj('Main', MAINQ)])], [(0, MCMQ, [script('SKI_PlayerLoadGameAlias', [])])])
qmcm = rec('QUST', MCMQ, [sub('EDID', z('ODS_MCMQuest')), sub('VMAD', v_mcm), sub('FULL', z("O'Deadly Skyrim MCM")),
    sub('DNAM', bytes.fromhex('110132ff0000000000000000')), sub('FLTR', z('ODeadlySkyrim\\')), sub('NEXT', b''),
    sub('ANAM', struct.pack('<I', 1))] + alias(0, 'PlayerAlias', 0, 0x14))
def ctda_global_eq1(gfid):  # condition: GetGlobalValue(gfid) == 1.0 (function 74), run on subject
    return sub('CTDA', struct.pack('<B3xfHHIIIIi', 0x00, 1.0, 74, 0, gfid, 0, 0, 0, -1))
def mesg(fid, edid, desc, buttons, box=True, conds=None):
    flags = 1 if box else 0
    subs_ = [sub('EDID', z(edid)), sub('DESC', z(desc)), sub('INAM', struct.pack('<I', 0)),
             sub('DNAM', struct.pack('<I', flags)), sub('TNAM', struct.pack('<I', 0))]
    for i, b in enumerate(buttons):
        subs_.append(sub('ITXT', z(b)))
        if conds and conds[i] is not None:
            subs_.append(ctda_global_eq1(conds[i]))
    return rec('MESG', fid, subs_)

savior_msg = mesg(OWN | 0x81F, 'ODS_SaviorChoice',
    'On the road ahead, a bandit is raping a traveler. What do you do?',
    ('Watch', 'Join in', 'Rescue'))
# 1.0: appended message boxes (0x820-0x823); existing FormIDs are never renumbered
msgs10 = [
    mesg(OWN | 0x820, 'ODS_JoinChoice', 'You walk in on them. What do you do?', ('Watch', 'Join in', 'Stop them')),
    mesg(OWN | 0x821, 'ODS_WildChoice', 'A beast has someone pinned down. What do you do?', ('Watch', 'Rescue')),
    mesg(OWN | 0x822, 'ODS_BeastPreyChoice', 'The beast in you wants them. Take them?', ('Take them', 'Let them go')),
    mesg(OWN | 0x823, 'ODS_BeastClaimChoice', 'They are willing. Claim them?', ('Claim them', 'Not now')),
]
# 1.0 "Bitch in Heat" (appended 0x824-0x82A)
heat_fact = rec('FACT', OWN | 0x824, [sub('EDID', z('ODS_HeatPackFaction')),
    sub('XNAM', struct.pack('<IiI', 0xDB1, 0, 3)),      # PlayerFaction: friend (never ally)
    sub('XNAM', struct.pack('<IiI', 0x5C84E, 0, 3)),    # CurrentFollowerFaction: friend
    sub('XNAM', struct.pack('<IiI', 0x84D1B, 0, 3)),    # PlayerFollowerFaction: friend
    sub('XNAM', struct.pack('<IiI', 0x91822, 0, 3)),    # PlayerWerewolfFaction: friend
    sub('DATA', struct.pack('<I', 1)),                  # hidden from PC
    sub('CRVA', bytes.fromhex('01010000000000000000000000000000'))])
heat_pool = rec('FLST', OWN | 0x825, [sub('EDID', z('ODS_PoolHeatWolf'))] +
    [sub('LNAM', struct.pack('<I', x)) for x in (0x23ABC, 0xA092B, 0xA092C, 0xA092D, 0xA092E, 0xA092F)])  # EncWerewolf01-06, WerewolfBeastRace
def glob(fid, edid): return rec('GLOB', fid, [sub('EDID', z(edid)), sub('FNAM', b's'), sub('FLTV', struct.pack('<f', 0.0))])
heat_globs = [glob(OWN | 0x826, 'ODS_HeatAllow1'), glob(OWN | 0x827, 'ODS_HeatAllow2'), glob(OWN | 0x828, 'ODS_HeatAllow3')]
heat_msg = mesg(OWN | 0x829, 'ODS_HeatChoice',
    'The howls and the scent carry far. Other werewolves are answering. How many do you let come?',
    ('One more', 'Two more', 'Three more', 'Not now'), conds=(OWN | 0x826, OWN | 0x827, OWN | 0x828, None))
HEATQ = OWN | 0x82A
v_heat = vmad_quest([], [(i, HEATQ, [script('ODS_HeatWolfAlias', [pobj('Main', MAINQ)])]) for i in range(3)])
heat_alias_subs = []
for i in range(3):
    heat_alias_subs += alias(i, 'HeatWolf%d' % (i + 1), STAGE)
qheat = rec('QUST', HEATQ, [sub('EDID', z('ODS_HeatQuest')), sub('VMAD', v_heat), sub('FULL', z("O'Deadly Skyrim heat pack")),
    sub('DNAM', bytes.fromhex('00003cff0000000000000000')), sub('NEXT', b''),
    sub('ANAM', struct.pack('<I', 3))] + heat_alias_subs)
heat_recs = 1 + 1 + 3 + 1 + 1
nrec = 2 + len(fl) + 1 + len(msgs10) + heat_recs
hdr = rec('TES4', 0, [sub('HEDR', struct.pack('<fII', 1.71, nrec, 0x82B)), sub('CNAM', z('That Guy (Coronerra)')),
    sub('SNAM', z("O'Deadly Skyrim (A SkyrimNet environmental mod) v1.0. By That Guy (Coronerra).")),
    sub('MAST', z('Skyrim.esm')), sub('DATA', struct.pack('<Q', 0))], flags=0x200)
out = sys.argv[1] if len(sys.argv) > 1 else 'ODeadlySkyrim.esp'
open(out, 'wb').write(hdr + grup('GLOB', heat_globs) + grup('FACT', [heat_fact]) + grup('QUST', [qmain, qmcm, qheat]) +
    grup('FLST', fl + [heat_pool]) + grup('MESG', [savior_msg] + msgs10 + [heat_msg]))
print('wrote', out, 'records', nrec)
