#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np
import pickle

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
    with open( '%s/%s.out' % (name, name), 'r') as f:
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
    morb = []; mocc = []; mE = []; step = 0;
    mbasis = []; mSumE = []; md = [];
    with open( '%s/%s.out' % (name, name), 'r') as f:
	line = f.readline()
	while line:
	    if 'SURFACE SCAN STEP' in line :
		step = step + 1
		morb.append([])
		mocc.append([])
		mE.append([])
		mSumE.append(0.0)
		md.append(0.0)
	    if flagstr in line :
#		print step, line
		morb[step-1] = []
		mocc[step-1] = []
		mE[step-1] = []
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
			for i in range(len(mi)) :
			    morb[step-1].append([])
			    mocc[step-1].append(mo[i])
			    mE[step-1].append(me[i])
#			print mi
#			print me
#			print mo
			mbasis = []
			line = f.readline()
			while len((line[:9]).strip())>0 :
			    m = line.strip().split()
			    a = m[0]
			    b = m[1]
			    mbasis.append('%s-%s' % (a, b))
			    mc =  map(float, m[2:])
#			    print a, b, mc
			    for i in range(len(mc)) :
				orb = mi[i]
				morb[step-1][orb].append(mc[i])
#				print ' %ld %ld %f' % (i, mi[i], mc[i])
			    line = f.readline()
#		    lst = line.strip().split()
#		    if len(lst)>1 : 
#			print lst
#			m[n-1].append(float(lst[2]))
#			occ[n-1].append(float(lst[1]))
	    line = f.readline()
	    if 'FINAL SINGLE POINT ENERGY' in line :
		mSumE[step-1] = float(line[26:])
#		print step-1, ' E = ', float(line[26:])
	    if '         *                 Bond (' in line :
		md[step-1] = float(line[47:61])
#		print step-1, ' d = ', float(line[47:61])
    f.close()
    return step, len(morb[0]), morb, mE, mSumE, mocc, mbasis, md

#MOLECULAR ORBITALS
#------------------
#                      0         1         2         3         4         5   
#                 -24.64914  -1.15660  -0.52340  -0.38280  -0.38280   0.05227
#                   2.00000   2.00000   2.00000   2.00000   2.00000   0.00000
#                  --------  --------  --------  --------  --------  --------
#  0H   1s         0.001495 -0.212017 -0.385740  0.000000  0.000000  0.177599
#  0H   2s        -0.003017 -0.007250 -0.061689 -0.000000  0.000000  1.235739

#FINAL SINGLE POINT ENERGY      -100.314764415265

#         *************************************************************
#         *               RELAXED SURFACE SCAN STEP   1               *
#         *                                                           *
#         *                 Bond (  1,   0)  :   0.90000000           *
#         *************************************************************


def GetAtomNumber(s) :
    return int(re.findall(r'[0-9]+', s)[0])

def CompareOrb(a, b, aE, bE) :
#    D = aE - bE
#    Q = 10000.0*D*D
    Q = 0.0
    for i in range(min(len(a), len(b))) :
	D = abs(a[i])-abs(b[i])
	Q = Q + D*D
    return Q

def TraceOrb(n, m, mE) :
    a = m[0][n]
    aE = mE[0][n]
    mr = []
    Prev = 0
    for step in range(1,len(m)) :
	b = m[step][0]
	bE = mE[step][0]
	Qmin = CompareOrb(a, b, aE, bE)
	Q2 = Qmin
	Nmin = 0
	mQ = []
	for i in range(1,len(m[step])) :
	    b = m[step][i]
	    bE = mE[step][0]
	    Q = CompareOrb(a, b, aE, bE)
	    mQ.append(Q)
	    if Q<Qmin :
		Nmin = i
		Q2 = Qmin
		Qmin = Q
	mr.append(Nmin)
	a = m[step][Nmin]
	if Prev>0 and abs(Prev-Nmin)>3 :
	    print '*** ', Prev, Nmin, Qmin, Q2
	    print ' ** ', m[step-1][n]
	    print ' ** ', m[step][n]
	Prev = Nmin
#	print step, n, Nmin, Qmin, mE[step][Nmin]
#	print mQ
    print mr
    return mr

def TraceAllOrb(m, mE) :
    mr = []
    for i in range(len(m[0][0])) :
	mr.append(TraceOrb(i, m, mE))
    return mr

def PrintTRE(m, mE, mSumE, md, sysname) :
    f = open( '%s-trace.csv' % (sysname), 'w')
    f.write('Step; d; SumE;')
    for i in range(len(mE[0])) : f.write(' MO%ld;' % (i))
    f.write('\n')
    for step in range(len(mE)) :
	f.write('%ld; %f; %f;' % (step+1, md[step], mSumE[step]))
	for i in range(len(mE[step])) :
	    f.write(' %f;' % (mE[step][i]))
	f.write('\n')
    f.close()
    f = open( '%s-trace.map' % (sysname), 'w')
#    for step in range(len(m)) :
#	for i in range(len(m[step])) :
    for i in range(len(m[0])) :
	for step in range(len(m)) :
	    f.write(' %ld;' % (m[step][i]))
	f.write('\n')
    f.close()


### Main part

#nE, mE, minE = read_E(sysname)
nMO, nOrb, mMO, mOCC = read_MO(sysname)

#print nstep
#print nE, minE
print nMO, nOrb

nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md = read_MOC(sysname)

for i in range(len(mMOC)) :
    print '\nStep: %ld  E=%f' % (i+1, mSumE[i])
    for j in range(len(mMOC[i])) :
	print j, mE[i][j], mOCC[i][j], mMOC[i][j]

print '\nBasis: ', mBasis
print '         ', map(GetAtomNumber, mBasis)
print 'nStep = %ld \nnOrb = %ld\n' % (nStep, nOrb)

#print CompareOrb(mMOC[1][1], mMOC[2][1])
#print CompareOrb(mMOC[1][1], mMOC[2][5])

TR = TraceAllOrb(mMOC, mE)

with open('data.pickle', 'wb') as f:
    pickle.dump(TR, f)

with open('data.pickle', 'rb') as f:
    TR = pickle.load(f)

PrintTRE(TR, mE, mSumE, md, sysname)

#print mOCC

#print sys.getsizeof(mMOC)

