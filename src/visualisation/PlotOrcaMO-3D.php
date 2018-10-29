<?php

function readCSV($csvFile){
    $r = array();
    $file_handle = fopen($csvFile, 'r');
    while (!feof($file_handle) ) {
        $line = fgetcsv($file_handle, 40000, ";");
	if( count($line)<5 ) continue;
//	printf("%ld %ld\n", count($r), count($line));
	$r[] = $line;
    }
    fclose($file_handle);
    return $r;
}

function Make_MO_images( $Map, $ME, $Name, $MO ) {
    $m = count($Map);
    $f=fopen("$Name/MO$MO/MO$MO-stat.dat","w");
    fclose($f);
    $f=fopen("$Name/MO$MO/scan.dat","w");
    for( $i=0; $i<$m; $i++ ) {
	$N = 1 + $Map[$i][3+$MO];
	$d = $Map[$i][0];
	$E = $Map[$i][1];
	$EMO = $ME[$i][3+$N];
	fprintf($f, "%7.4f; %f; %f; %3ld;\n", $d, $E, $EMO, $N);
	$S = sprintf("MO%ld  Step%ld  d=%.4f  E=%.6f  E(MO)=%.6f", $MO, $i+1, $d, $E, $EMO);
	$STAT = sprintf("%ld;  %ld;  %.4f;  %.6f;  %.6f; ", $MO, $i+1, $d, $E, $EMO);
	$com = sprintf("./Plot-MO.sh %s %d %d %03d \"%s\" \"%s\"", $Name, $MO, $N, $i+1, $S, $STAT);
	echo "$com\n";
	system($com);
    }
    fclose($f);
}

$Name = $argv[1];
$MO = (int) $argv[2];
$Map = readCSV("$Name/$Name.map");
$ME = readCSV("$Name/$Name.mo");
system("mkdir -p $Name/MO$MO");
Make_MO_images($Map, $ME, $Name, $MO);

?>

