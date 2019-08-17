#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np
import pickle


# MinE_MO; E_MinE_MO; Last_MO; E_Last_MO; Frag_MO; E_Frag_MO; Occ; Frag; Localisation;
#       0;         1;       2;         3;       4;         5;   6;    7;            8;
def read_tranform(name) :
    MOr = []
    EMOr = []
    MOs = []
    EMOs = []
    Occ = []
    Frag = []
    with open( '%s.csv' % (name), 'r') as f:
	f.readline()
	for line in f.readlines():
	    lst = line.split(';')
	    if len(lst)>7 :
		MOr.append(int(lst[0].strip()))
		EMOr.append(float(lst[1].strip()))
		MOs.append(int(lst[4].strip()))
		EMOs.append(float(lst[5].strip()))
		Occ.append(float(lst[6].strip()))
		Frag.append(lst[7].strip())
    f.close()
    return MOr, EMOr, MOs, EMOs, Occ, Frag

def get_frag_name(Frag) :
    for f in Frag :
	if f=='Ph+' : return "Ph^+"
	if f=='4-MeOPh+' : return "4-MeOPh^+"
	if f=='4-NO2Ph+' : return "4-NO_2Ph^+"
    if f=='N2' : return f
    else : return 'Compound'

def write_gnuplot(name, prefix, MOr, EMOr, MOs, EMOs, Occ, Frag, Emin, Emax) :
    with open( '%s%s.gnu' % (name, prefix), 'w') as f:
#	f.write('set terminal pngcairo  transparent enhanced font \"arial,32\" fontscale 1.0 size 2000,2600\n')
	f.write('set terminal svg size 2000,2600 font "Helvetica,50\n')
	f.write('set output \"%s%s.svg\"\n' % (name, prefix))
	f.write('set multiplot\n')
	f.write('set nokey\n')
	f.write('set ylabel "E, Hartree" font "Helvetica,50"\n')
	f.write('set xrange [0:9.0]\n')
	f.write('set yrange [%f:%f]\n' % (Emin, Emax))
	f.write('set yzeroaxis lt 1\n')
	f.write('set xzeroaxis lt 0\n')
	f.write('unset box\n')
	f.write('unset border\n')
	f.write('unset xtics\n')
	f.write('set style arrow 1 nohead ls 1 lw 5\n')
	f.write('set style arrow 2 nohead ls 2 lw 5\n')
	f.write('set style arrow 3 nohead ls 3 lw 5\n\n')
	for i in range(len(MOr)) :
	    f.write('set label \"%s\" at 7.5,%f center font "Helvetica-Bold,50\n' % (get_frag_name(Frag), Emin + 0.05*(Emax-Emin)))
	    f.write('set label \"%s\" at 1.5,%f center font "Helvetica-Bold,50\n' % ('N_2', Emin + 0.05*(Emax-Emin)))
	    if Frag[i]=='N2' :
#		f.write('set label \"%ld\" at 0.7,%f center font "Helvetica-Bold,30"\n' % (MOs[i], EMOs[i]))
		f.write('set arrow from 1,%f to 2,%f as 2\n' % (EMOs[i], EMOs[i]))
	    else :
#		f.write('set label \"%ld\" at 8.3,%f center font "Helvetica-Bold,30"\n' % (MOs[i], EMOs[i]))
		f.write('set arrow from 7,%f to 8,%f as 1\n' % (EMOs[i], EMOs[i]))
	    if Frag[i]=='N2' :
		f.write('set arrow from 4,%f to 5,%f as 2\n' % (EMOr[i], EMOr[i]))
	    else :
		f.write('set arrow from 4,%f to 5,%f as 1\n' % (EMOr[i], EMOr[i]))
	    if Occ[1] > 0 :
		if Frag[i]=='N2' :
		    f.write('set arrow from 2,%f to 4,%f as 2 lw 2 dashtype 2\n' % (EMOs[i], EMOr[i]))
		else :
		    f.write('set arrow from 7,%f to 5,%f as 1 lw 2 dashtype 2\n' % (EMOs[i], EMOr[i]))
	f.write('plot 0 lt 0 lw 0\n\n')
    f.close()


### Main part

sysname = sys.argv[1]
prefix = sys.argv[2]
Emin = float(sys.argv[3])
Emax = float(sys.argv[4])

MOr, EMOr, MOs, EMOs, Occ, Frag = read_tranform(sysname)

#print MOr, EMOr, MOs, EMOs, Occ, Frag
#print Frag

write_gnuplot(sysname, prefix, MOr, EMOr, MOs, EMOs, Occ, Frag, Emin, Emax)

os.system('gnuplot %s%s.gnu' % (sysname, prefix))
#os.system('atril %s%s.png' % (sysname, prefix))
