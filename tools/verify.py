# Parse-verify ODeadlySkyrim.esp: header, masters, ESL flag, every record, every VMAD consumed exactly.
import struct, sys
d = open(sys.argv[1], 'rb').read()
def subs(data):
    o = 0
    while o < len(data):
        t = data[o:o+4].decode(); s = struct.unpack_from('<H', data, o+4)[0]
        yield t, data[o+6:o+6+s]; o += 6 + s
    assert o == len(data)
def recs(b, o, end):
    while o < end:
        t = b[o:o+4].decode(); sz = struct.unpack_from('<I', b, o+4)[0]
        if t == 'GRUP':
            assert b[o+8:o+12].decode().isalpha()
            yield from recs(b, o+24, o+sz); o += sz; continue
        fl, fid = struct.unpack_from('<II', b, o+8)
        yield t, fid, fl, b[o+24:o+24+sz]; o += 24 + sz
    assert o == end, (o, end)
def parse_vmad(b):
    o = 0
    def ws():
        nonlocal o; l = struct.unpack_from('<H', b, o)[0]; s = b[o+2:o+2+l].decode(); o += 2 + l; return s
    def scripts(tag):
        nonlocal o
        v, f, n = struct.unpack_from('<hhH', b, o); o += 6; assert v == 5 and f == 2
        for i in range(n):
            nm = ws(); o += 1; pc = struct.unpack_from('<H', b, o)[0]; o += 2; props = []
            for j in range(pc):
                pn = ws(); t = b[o]; o += 2; assert t == 1, t
                _, al, fid = struct.unpack_from('<HhI', b, o); o += 8
                props.append(f'{pn}={fid:08X}' + (f'@{al}' if al >= 0 else ''))
            print(f'   {tag} {nm}: {len(props)} props', ' '.join(props))
    scripts('quest')
    assert b[o] == 2; o += 1; assert struct.unpack_from('<H', b, o)[0] == 0; o += 2; ws()
    ac = struct.unpack_from('<H', b, o)[0]; o += 2
    for i in range(ac):
        _, al, fid = struct.unpack_from('<HhI', b, o); o += 8; scripts(f'alias{al}')
    assert o == len(b); print('   VMAD fully consumed', len(b), 'bytes')
n = 0
for t, fid, fl, data in recs(d, 0, len(d)):
    ss = list(subs(data))
    if t == 'TES4':
        h = struct.unpack('<fII', dict(ss)['HEDR'])
        print('TES4 HEDR', h, 'masters', [v[:-1].decode() for k, v in ss if k == 'MAST'], 'ESL', bool(fl & 0x200))
        assert [v[:-1].decode() for k, v in ss if k == 'MAST'] == ['Skyrim.esm'] and fl & 0x200
        continue
    n += 1
    ed = dict(ss).get('EDID', b'?\0')[:-1].decode()
    print(t, hex(fid), ed)
    if t == 'FLST': print('   ', [hex(struct.unpack('<I', v)[0]) for k, v in ss if k == 'LNAM'])
    if t == 'QUST':
        parse_vmad(dict(ss)['VMAD'])
        al = [struct.unpack('<I', v)[0] for k, v in ss if k == 'ALST']
        fn = [hex(struct.unpack('<I', v)[0]) for k, v in ss if k == 'FNAM']
        print('   aliases', list(zip(al, [v[:-1].decode() for k, v in ss if k == 'ALID'], fn)))
        assert struct.unpack('<I', dict(ss)['ANAM'])[0] == len(al)
assert n == h[1], (n, h)
print('OK records', n)
