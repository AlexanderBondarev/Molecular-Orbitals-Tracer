#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np
import pickle

sysname = sys.argv[1]
Orb = int(sys.argv[2])
nStep = int(re.findall(r'\-n\d+', sysname)[0][2:])

def mfloat(s): return float(s.strip())

def read_E(name):
    mEsum = []
    mE = []
    mParam = []
    Step = 0
    with open( '%s-trace.csv' % (name), 'r') as f:
	line = f.readline()
	line = f.readline()
	while line:
	    ms = line.strip().split(';')
#	    print Step, ms
	    mParam.append( mfloat(ms[1]) )
	    mEsum.append( mfloat(ms[2]) )
	    mE.append( map(mfloat, ms[3:-1]) )
	    Step = Step + 1
	    line = f.readline()
    f.close()
    return Step, len(mE[0]), mE, mEsum, mParam

def read_map(name):
    m = []
    Step = 0
    with open( '%s-trace.map' % (name), 'r') as f:
	line = f.readline()
	while line:
	    ms = line.strip().split(';')
#	    print Step, ms
	    m.append( map(int, ms[:-1]) )
	    Step = Step + 1
	    line = f.readline()
    f.close()
    return Step, len(m[0]), m

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

def plot_MO(sysname, Step, Orb, rOrb):
    print '*** step=%04ld  orb=%ld  rorb=%ld' % (Step, Orb, rOrb)
    os.system( 'cat get-mo.com | sed -e "s/MO/%ld/" | ./orca_plot-3.0.2 %s/%s.%03d.gbw -i | tee get-mo.log' % (rOrb, sysname, sysname, Step) )
    os.system( 'mv %s.mo%lda.cube step%03ld-mo%ld-rmo%ld.cube' % (sysname, rOrb, Step, Orb, rOrb) )
    os.system( 'rm %s.mo%ldb.cube' % (sysname, rOrb) )

### Main part

nStep, nOrb, mE, mEsum, mParam = read_E(sysname)
nStep, nOrb, mOrb = read_map(sysname)

#print mEsum
#print mParam
print nStep, nOrb
for i in range(nStep) :
    print "%4ld; %7.4f; %12.6f; %12.6f; %4ld;" % (i, mParam[i], mEsum[i], mE[i][Orb], mOrb[i][Orb])


plot_MO(sysname, 5, Orb, mOrb[5][Orb])
plot_MO(sysname, 6, Orb, mOrb[6][Orb])
plot_MO(sysname, 7, Orb, mOrb[7][Orb])
plot_MO(sysname, 8, Orb, mOrb[8][Orb])
plot_MO(sysname, 7, Orb, 34)
plot_MO(sysname, 8, Orb, 34)

#cat get-mo.com | sed -e "s/MO/$NMO/" | ./orca_plot $Name/$Name.$N.gbw -i | tee get-mo.log
#mv $Name.mo"$NMO"a.cube mo.cube
#rm $Name.mo"$NMO"b.cube
