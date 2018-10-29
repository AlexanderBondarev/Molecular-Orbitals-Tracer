
name=`basename $1 .gbw`
cat get-mo.com | sed -e "s/MO/$2/" | ./orca_plot $1 -i > get-mo.log
mv NH2-N2+-scan-d09-169-n800.mo"$2"a.cube mo.cube
rm NH2-N2+-scan-d09-169-n800.mo"$2"b.cube
mv NH2-N2+-scan-d09-169-n800.xyz mol.xyz
pymol -c plot-mo.pml
mv mo.cube $1-mo$2.cube
mv mo.png $1-mo$2.png
eom $1-mo$2.png
