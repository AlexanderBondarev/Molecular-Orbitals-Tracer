
Name=$1

for MO in $(seq 1 87)
do
  NMO=$(( $MO - 1 ))
  echo "   MO=$MO"
  mkdir -p $Name/MO$MO
  if [ -f $Name/MO$MO/MO$MO-001.cube ] ; then
    echo "   Skip MO$MO-001.cube"
  else
    echo "  Make MO$MO-001.cube"
    cat get-mo.com | sed -e "s/MO/$NMO/" | ./orca_plot $Name/gbw/$Name-scan-d09-169-n800.001.gbw -i | tee get-mo.log > /dev/null
    mv NH2-N2+-scan-d09-169-n800.mo"$NMO"a.cube $Name/MO$MO/MO$MO-001.cube
    rm NH2-N2+-scan-d09-169-n800.mo"$NMO"b.cube
  fi
done

for Step in $(seq --equal-width 2 799)
do
  S2=`expr $Step - 1`
  Old=`printf "%03ld" $S2`
  echo "Step=$Step"

  printf "" > Step$Step.map
  for MO in $(seq 1 87)
  do
    NMO=$(( $MO - 1 ))
    echo "   MO=$MO"
    mkdir -p $Name/MO$MO

    if [ -f $Name/MO$MO/MO$MO-$Step.cube ] ; then
      echo "   Skip MO$MO-$Step.cube"
    else
      cat get-mo.com | sed -e "s/MO/$NMO/" | ./orca_plot $Name/gbw/$Name-scan-d09-169-n800.$Step.gbw -i | tee get-mo.log > /dev/null
      mv NH2-N2+-scan-d09-169-n800.mo"$NMO"a.cube $Name/MO$MO/MO$MO-$Step.cube
      rm NH2-N2+-scan-d09-169-n800.mo"$NMO"b.cube
    fi

    for OldMO in $(seq 1 87)
    do
      Delta=`./Compare-Gaussian-Cube $Name/MO$MO/MO$MO-$Step.cube $Name/MO$OldMO/MO$OldMO-$Old.cube`
      echo "      Delta [ MO$MO-$Step MO$OldMO-$Old ] = $Delta"
      echo -n " $Delta" >> Step$Step.map
    done
    printf "\n" >> Step$Step.map
  done

done
