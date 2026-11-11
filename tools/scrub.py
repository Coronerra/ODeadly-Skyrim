import struct,sys,os
def ws(b,o):
    l=struct.unpack_from('>H',b,o)[0]; return b[o+2:o+2+l].decode(),o+2+l
def W(s): b=s.encode(); return struct.pack('>H',len(b))+b
for p in sys.argv[1:]:
    b=open(p,'rb').read(); o=4+2+2+8
    src,o1=ws(b,o); usr,o2=ws(b,o1); mach,o3=ws(b,o2)
    nb=b[:o]+W(os.path.basename(src))+W('coronerra')+W('-')+b[o3:]
    open(p,'wb').write(nb); print(p,src,'->',os.path.basename(src))
