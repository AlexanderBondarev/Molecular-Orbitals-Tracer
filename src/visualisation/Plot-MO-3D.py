#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np
import pickle

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

def plot_MO(sysname, Step, Orb, rOrb, mE, mEsum, mParam):
    print '*** step=%04ld  orb=%ld  rorb=%ld' % (Step, Orb, rOrb)
#    os.system( 'cat get-mo.com | sed -e "s/MO/%ld/" | ./orca_plot-3.0.2 %s/%s.%03d.gbw -i | tee get-mo.log' % (rOrb, sysname, sysname, Step) )
    os.system( 'cat get-mo.com | sed -e "s/MO/%ld/" | ./orca_plot-4.1.0 %s/%s.%03d.gbw -i | tee get-mo.log' % (rOrb, sysname, sysname, Step) )
#    os.system( 'mv %s/%s.%03ld.mo%lda.cube step%03ld-mo%ld-rmo%ld.cube' % (sysname, sysname, Step, rOrb, Step, Orb, rOrb) )
    os.system( 'mv %s/%s.%03ld.mo%lda.cube mo.cube' % (sysname, sysname, Step, rOrb) )
    os.system( 'rm %s/%s.%03ld.mo%ldb.cube' % (sysname, sysname, Step, rOrb) )
#    os.system( 'ln -s -r step%03ld-mo%ld-rmo%ld.cube mo.cube' % (Step, Orb, rOrb) )
    os.system( 'cp %s/%s.%03ld.xyz mol.xyz' % (sysname, sysname, Step) )
    os.system( 'pymol -c plot-mo.pml' )
    os.system( 'mkdir -p %s/mo%ld' % (sysname, Orb) )
    st = '\'Orbital=%ld   Step=%ld   d=%.3f   E=%.6f   Eorb=%.6f\'' % (rOrb, Step, mParam[Step], mEsum[Step], mE[Step][rOrb])
    os.system( 'convert -pointsize 18 -fill black -draw \"text 170,35 %s\" mo.png mo-txt.png' % (st) )
    os.system( 'mv mo-txt.png %s/mo%ld/mo%ld.%03ld.png' % (sysname, Orb, Orb, Step) )
    os.system( 'rm mo.png' )
    os.system( 'rm mo.cube' )
    os.system( 'rm mol.xyz' )


### Main part

sysname = sys.argv[1]
Orb = int(sys.argv[2])

nStep, nOrb, mE, mEsum, mParam = read_E(sysname)
nStep, nOrb, mOrb = read_map(sysname)

if len(sys.argv)>3 :
    Step = int(sys.argv[3])
else : Step = nStep
#nStep = int(re.findall(r'\-n\d+', sysname)[0][2:])

##print "Orb=%ld/%ld  Step=%ld/%ld" % (Orb, nOrb, Step, nStep)

#for i in range(nStep) :
for i in range(1,Step) :
    print "Orb=%ld/%ld  Step=%ld/%ld" % (Orb, nOrb, i, nStep)
#    print "%4ld; %7.4f; %12.6f; %12.6f; %4ld;" % (i, mParam[i], mEsum[i], mE[i][Orb], mOrb[i][Orb])
    plot_MO(sysname, i, Orb, mOrb[i][Orb], mE, mEsum, mParam)

#plot_MO(sysname, Step, Orb, mOrb[Step][Orb])
