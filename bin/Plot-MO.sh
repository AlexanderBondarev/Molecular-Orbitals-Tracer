
Name=$1
RO=$2
MO=$3
NMO=$(( $MO - 1 ))
echo "NMO=$NMO"
N=$4
TXT=$5
STAT=$6
mkdir -p $Name/MO$RO
cat get-mo.com | sed -e "s/MO/$NMO/" | ./orca_plot $Name/$Name.$N.gbw -i | tee get-mo.log
mv $Name.mo"$NMO"a.cube mo.cube
rm $Name.mo"$NMO"b.cube
cp $Name/gbw/$Name.$N.xyz mol.xyz

pymol -c plot-mo.pml
convert -pointsize 16 -fill black -draw "text 40,40 \"$TXT\"" mo.png mo-txt.png
mv mo-txt.png $Name/MO$RO/MO$RO-$N.png

echo -n $STAT >> $Name/MO$RO/MO$RO-stat.dat
php IntegrateGaussianCube.php mo.cube >> $Name/MO$RO/MO$RO-stat.dat
mv mo.cube $Name/MO$RO/MO$RO-$N.cube
rm mo.png
rm mol.xyz
rm NH2-N2+-scan-d09-169-n800.xyz
