#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np

sysname = sys.argv[1]

nstep = int(re.findall(r'\-n\d+', sysname)[0][2:])

def read_E(name):
    mE = []; n = 0;
    with open( '%s/%s.relaxscanscf.dat' % (name, name), 'r') as f:
	for line in f.readlines():
	    lst = line.split()
	    if len(lst)==2 :
		mE.append(float(lst[1]))
		n = n + 1
    f.close()
    return n, mE, min(mE)

def read_MO(name):
    flagstr = 'ORBITAL ENERGIES'
    m = []; occ = []; n = 0; i = 0;
    with open( '%s.out' % (name), 'r') as f:
	line = f.readline()
	while line:
	    if 'SURFACE SCAN STEP' in line :
		n = n+1
		m.append([])
		occ.append([])
	    if flagstr in line :
		m[n-1] = []
		occ[n-1] = []
		line = f.readline()
		line = f.readline()
		line = f.readline()
		while len(line.strip())>0 :
		    if '-----' in line : break
		    line = f.readline()
		    lst = line.strip().split()
		    if len(lst)>1 : 
			m[n-1].append(float(lst[2]))
			occ[n-1].append(float(lst[1]))
	    line = f.readline()
    f.close()
    return n, len(m[0]), m, occ

def find_HOMO_LUMO(MO, mOCC) :
    for i in range(len(MO)) :
	if mOCC[i+1]==0 :
	    return MO[i], MO[i+1]
	    break

def read_MOC(name):
    flagstr = 'MOLECULAR ORBITALS'
    morb = []; mocc = []; n = 0; i = 0;
    mbasis = [];
    with open( '%s.out' % (name), 'r') as f:
	line = f.readline()
	while line:
	    if 'SURFACE SCAN STEP' in line :
		n = n+1
		morb.append([])
		mocc.append([])
	    if flagstr in line :
		print line, n
		morb[n-1] = []
		mocc[n-1] = []
		line = f.readline()
		line = f.readline()
		while len(line.strip())>0 :
		    iline = line
		    eline = f.readline()
		    oline = f.readline()
		    rline = f.readline()
		    if '-------' in rline :
#			print iline
#			print eline
#			print oline
			mi = map(int, iline.strip().split())
			me = map(float, eline.strip().split())
			mo = map(int, map(float, oline.strip().split()))
			print mi
			print me
			print mo
			mbasis = []
			line = f.readline()
			while len((line[:9]).strip())>0 :
			    m = line.strip().split()
			    a = m[0]
			    b = m[1]
			    mbasis.append('%s-%s' % (a, b))
			    mc =  map(float, m[2:])
			    print a, b, mc
			    line = f.readline()
#		    lst = line.strip().split()
#		    if len(lst)>1 : 
#			print lst
#			m[n-1].append(float(lst[2]))
#			occ[n-1].append(float(lst[1]))
	    line = f.readline()
    f.close()
    return n, len(m[0]), morb, mocc, mbasis

#MOLECULAR ORBITALS
#------------------
#                      0         1         2         3         4         5   
#                 -24.64914  -1.15660  -0.52340  -0.38280  -0.38280   0.05227
#                   2.00000   2.00000   2.00000   2.00000   2.00000   0.00000
#                  --------  --------  --------  --------  --------  --------
#  0H   1s         0.001495 -0.212017 -0.385740  0.000000  0.000000  0.177599
#  0H   2s        -0.003017 -0.007250 -0.061689 -0.000000  0.000000  1.235739



### Main part

#nE, mE, minE = read_E(sysname)
nMO, nOrb, mMO, mOCC = read_MO(sysname)

#print nstep
#print nE, minE
print nMO, nOrb

nMOC, nOrb, mMOC, mOCC, mbasis = read_MOC(sysname)

print mbasis

#fMO = open( '%s-E-MO.csv' % (sysname), 'w')
#fMO.write(' N; E; HOMO; LUMO;')
#for i in range(nOrb) : fMO.write(' E(MO%ld); OCC(MO%ld);' % (i, i) )
#fMO.write('\n')
#for i in range(nMO) :
#    fMO.write(' %3ld; %.10f;' % (i+1, mE[i]) )
#    HOMO, LUMO = find_HOMO_LUMO(mMO[i], mOCC[i])
#    fMO.write(' %6f; %.6f;' % (HOMO, LUMO) )
#    for j in range(len(mMO[i])) :
###	fMO.write(' (%ld,%ld) %.6f; %ld;' % (i, j, mMO[i][j], mOCC[i][j]) )
#	fMO.write(' %.6f; %ld;' % (mMO[i][j], mOCC[i][j]) )
#    fMO.write('\n')
#fMO.close()
