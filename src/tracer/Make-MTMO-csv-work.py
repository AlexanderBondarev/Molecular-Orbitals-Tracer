#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np
import pickle

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

def check_split(m) :
    r = []
    for s in m :
	while '-' in s[2:] :
	    p = s[1:].partition('-')
	    head = s[0] + p[0]
	    tail = p[1] + p[2]
	    print ' *** check [%s][%s]' % (head, tail)
	    r.append(head)
	    s = tail
	r.append(s)
    return r

def read_MOC(name) :
    flagstr = 'MOLECULAR ORBITALS'
    morb = []; mocc = []; mE = []; step = 0;
    mbasis = []; mSumE = []; md = [];
    print 'Read MO coefficients on step:',
    with open( '%s/%s.out' % (name, name), 'r') as f:
	line = f.readline()
	while line:
	    if 'SURFACE SCAN STEP' in line :
		step = step + 1
		print ' ', step,
		sys.stdout.flush()
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
			    mc =  map(float, check_split(m[2:]))
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
    print ' '
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
#    D = abs(aE - bE)
#    Q = D*D
    Q1 = 0.0
    for i in range(min(len(a), len(b))) :
	D = a[i] - b[i]
	Q1 = Q1 + D*D
    Q2 = 0.0
    for i in range(min(len(a), len(b))) :
	D = a[i] + b[i]
	Q2 = Q2 + D*D
    if Q2<Q1 : return Q2
    else : return Q1

def TraceOrb(n, m, mE) :
    a = m[0][n]
    aE = mE[0][n]
    mr = []
    mQr = []
    Prev = 0
    for step in range(1,len(m)) :
	b = m[step][0]
	bE = mE[step][0]
	Qmin = CompareOrb(a, b, aE, bE)
	Q2 = Qmin
	Q3 = Q2
	Nmin = 0
	N2 = Nmin
	N3 = N2
	mQ = []
	for i in range(1,len(m[step])) :
	    b = m[step][i]
	    bE = mE[step][i]
	    Q = CompareOrb(a, b, aE, bE)
	    mQ.append(Q)
	    if Q<Qmin :
		N3 = N2
		N2 = Nmin
		Nmin = i
		Q3 = Q2
		Q2 = Qmin
		Qmin = Q
	mr.append(Nmin)
	mQr.append(Qmin)
	a = m[step][Nmin]
	if Prev>0 and abs(Prev-Nmin)>3 :
	    print '***    ', Prev, Nmin, Qmin, N2, Q2, N3, Q3
	    print ' **  %10.6f  %10.6f  %10.6f  %10.6f' % (mE[step-1][n][i], mE[step][Nmin][i], mE[step][N2][i], mE[step][N3][i])
	    for i in range(len(m[step][n])) :
		print ' **  %10.6f  %10.6f  %10.6f  %10.6f' % (m[step-1][n][i], m[step][Nmin][i], m[step][N2][i], m[step][N3][i])
#	    print ' **    ', m[step-1][n]
#	    print ' ** N1 ', m[step][Nmin]
#	    print ' ** N2 ', m[step][N2]
	Prev = Nmin
#	print step, n, Nmin, Qmin, mE[step][Nmin]
#    print mQr
#    print mr
    return mr

def TraceAllOrb(m, mE) :
    mr = []
    nOrb = len(m[0][0])
#    for i in range(nOrb) :
#	print 'Trace of %ld/%ld orbital' % (i, nOrb)
#	mr.append(TraceOrb(i, m, mE))
    mr.append(TraceOrb(36, m, mE))
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

def min_energy(m) :
    r = m[0]
    idx = 0
    for i in range(len(m)/4) :
	if r > m[i] :
	    r = m[i]
	    idx = i
    return r, idx

def save_pickle(sysname):
    global nMO, nOrb, mMO, mOCC, nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md
    with open('%s.pickle' % (sysname), 'wb') as f:
	pickle.dump([nMO, nOrb, mMO, mOCC, nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md], f)
    print 'Save to %s.pickle' % (sysname)

def load_pickle(sysname):
    with open('%s.pickle' % (sysname), 'rb') as f:
	nMO, nOrb, mMO, mOCC, nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md = pickle.load(f)
    print 'Load from %s.pickle' % (sysname)
    return nMO, nOrb, mMO, mOCC, nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md


### Main part

sysname = sys.argv[1]

nStep = int(re.findall(r'\-n\d+', sysname)[0][2:])

if os.path.isfile('%s.pickle' % sysname) :
    nMO, nOrb, mMO, mOCC, nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md = load_pickle(sysname)
else :
    #nE, mE, minE = read_E(sysname)
    nMO, nOrb, mMO, mOCC = read_MO(sysname)
    nStep, nOrb, mMOC, mE, mSumE, mOCC, mBasis, md = read_MOC(sysname)

save_pickle(sysname)

#print nstep
#print nE, minE
print nMO, nOrb

#for i in range(len(mMOC)) :
#    print '\nStep: %ld  E=%f' % (i+1, mSumE[i])
#    for j in range(len(mMOC[i])) :
#	print j, mE[i][j], mOCC[i][j], mMOC[i][j]

minE, minStep = min_energy(mSumE)

print '\nBasis: ', mBasis
print '         ', map(GetAtomNumber, mBasis)

#print CompareOrb(mMOC[1][1], mMOC[2][1])
#print CompareOrb(mMOC[1][1], mMOC[2][5])

TR = TraceAllOrb(mMOC, mE)

#with open('data.pickle', 'wb') as f:
#    pickle.dump(TR, f)

#with open('data.pickle', 'rb') as f:
#    TR = pickle.load(f)

PrintTRE(TR, mE, mSumE, md, sysname)

#print mOCC

#print sys.getsizeof(mMOC)
print 'nStep = %ld \nnOrb = %ld\n' % (nStep, nOrb)
print ' min E[%ld] = %f on d=%f' % (minStep, minE, md[minStep])
