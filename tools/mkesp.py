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
    pobj('Gold001', 0xF)] + [pobj(ed, OWN | lid) for ed, lid, _ in pools]
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
nrec = 2 + len(fl)
hdr = rec('TES4', 0, [sub('HEDR', struct.pack('<fII', 1.71, nrec, 0x81D)), sub('CNAM', z('That Guy (Coronerra)')),
    sub('SNAM', z("O'Deadly Skyrim (A SkyrimNet environmental mod) v0.8. By That Guy (Coronerra).")),
    sub('MAST', z('Skyrim.esm')), sub('DATA', struct.pack('<Q', 0))], flags=0x200)
out = sys.argv[1] if len(sys.argv) > 1 else 'ODeadlySkyrim.esp'
open(out, 'wb').write(hdr + grup('QUST', [qmain, qmcm]) + grup('FLST', fl))
print('wrote', out, 'records', nrec)
