#!/usr/bin/python

import sys
import os
import re
import math
import numpy as np

def get_MO(sysname, Orb):
    print '*** orb=%ld' % (Orb)
    os.system( 'cat get-mo.com | sed -e "s/MO/%ld/" | ./orca_plot-3.0.2 %s.gbw -i | tee get-mo.log' % (Orb, sysname) )
    os.system( 'mv %s.mo%lda.cube %s-mo%ld.cube' % (sysname, Orb, sysname, Orb) )
    os.system( 'rm %s.mo%ldb.cube' % (sysname, Orb) )

### Main part

sysname = sys.argv[1][:-4]
orb = int(sys.argv[2])

get_MO(sysname, orb)
