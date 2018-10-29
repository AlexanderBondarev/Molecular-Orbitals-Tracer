
cat get-mo.com | sed -e "s/MO/$2/" | ./orca_plot $1 -i | tee get-mo.log > /dev/null
mv NH2-N2+-scan-d09-169-n800.mo"$2"a.cube a.cube
rm NH2-N2+-scan-d09-169-n800.mo"$2"b.cube
cat get-mo.com | sed -e "s/MO/$4/" | ./orca_plot $3 -i | tee get-mo.log > /dev/null
mv NH2-N2+-scan-d09-169-n800.mo"$4"a.cube b.cube
rm NH2-N2+-scan-d09-169-n800.mo"$4"b.cube

./Compare-Gaussian-Cube a.cube b.cube
