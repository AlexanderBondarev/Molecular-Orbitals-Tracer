<?php

$SysName=$argv[1];

function CmpMO($a, $b)
{
   if ($a['Eh'] == $b['Eh']) return 0;
   return $a['Eh'] > $b['Eh'] ? 1 : -1;
}

function ReadMO($fin, &$HOMO, &$LUMO) {
    $MO = array(); 
    $LUMO = 1000.0;
    $HOMO = -1000.0;
    while (!feof ($fin)) {
	$s = fgets($fin);
	if(strlen($s)<10) {
	    $s = fgets($fin);
	    if( strpos($s,"SPIN DOWN ORBITALS")>0 ) { $s = fgets($fin); continue; }
	    else {usort($MO,'CmpMO'); return $MO;}
	}
	$OCC = intval(substr($s,6,7));
	$Eh = floatval(substr($s,16,27));
	$MO[] = array( 'OCC'=>$OCC, 'Eh'=>$Eh );
	if( $OCC>0 && $Eh>$HOMO ) $HOMO=$Eh;
	if( $OCC==0 && $Eh<$LUMO ) $LUMO=$Eh;
    }
}

function vangle( $x1, $y1, $x2, $y2 ) { return 57.3*acos( ($x1*$x2+$y1*$y2)/(sqrt($x1*$x1+$y1*$y1)*sqrt($x2*$x2+$y2*$y2))); }

function Check_MO_3D( $j, $i, $a, $b, $flog ) {
    global $SysName;
    $old = $j-1;
    $r1 = floatval(system(sprintf("./Compare-Gaussian-Cube.sh $SysName/$SysName.%03ld.gbw $a $SysName/$SysName.%03ld.gbw $a", $old, $j)));
    $r2 = floatval(system(sprintf("./Compare-Gaussian-Cube.sh $SysName/$SysName.%03ld.gbw $a $SysName/$SysName.%03ld.gbw $b", $old, $j)));
    fprintf($flog,"\n  *** %ld Swap %ld <=> %ld [%ld <=> %ld] {%.6f %.6f}", $j, $i, $i+1, $a, $b, $r1, $r2);
    if( $r1 < $r2 ) return true; 
    else return false;
}

function trace_MMO( $m, $Prop, $flog, $fout, $fmap ) {
 $map = array();
 $cmap = array();
 $t = array();

 $max_j = count($m);
 $max_i = count($m[0]);

 for( $i=0; $i<$max_i; $i++) $cmap[$i]=$i;
 $map[0]=$cmap;

// fprintf($fout," %7.4f; %17.9f; %17.9f; %17.9f;  ", $Prop[0]['d'], $Prop[0]['E'], $Prop[0]['HOMO'], $Prop[0]['LUMO'] );
// for( $z=0; $z<$max_i; $z++ ) { $ind=$map[0][$z]; fprintf($fout," %f;", $m[0][$ind]['Eh']); }

 for( $j=0; $j<$max_j; $j++) {
//    $map[$j]=$cmap;
    if( $j>3 && $j<($max_j-3) ) {
	for( $i=0; $i<$max_i-1; $i+=1) {
	    $y11 = 1.0*$m[$j-2][$i]['Eh'];
	    $y12 = 1.0*$m[$j][$i]['Eh'];
	    $y13 = 1.0*$m[$j+2][$i]['Eh'];
	    $y21 = 1.0*$m[$j-2][$i+1]['Eh'];
	    $y22 = 1.0*$m[$j][$i+1]['Eh'];
	    $y23 = 1.0*$m[$j+2][$i+1]['Eh'];
	    $y = ($y12 + $y22)/2.0;
	    $d1 = $y21-$y11; if($d1<0.000001) $d1=0.000001;
	    $d2 = $y22-$y12; if($d2<0.000001) $d2=0.000001;
	    $d3 = $y23-$y13; if($d3<0.000001) $d3=0.000001;
	    $dx = 0.001;
	    $ang1 = vangle( $dx, $y-$y11, $dx, $y23-$y );
	    $ang2 = vangle( $dx, $y-$y11, $dx, $y13-$y );
	    $ang3 = vangle( $dx, $y-$y21, $dx, $y13-$y );
	    $ang4 = vangle( $dx, $y-$y21, $dx, $y23-$y );
	    if( ($y22-$y12)<0.005 ) {
 //		if($y12>-0.7 && $y22<-0.6) fprintf($flog," Test %ld [%ld %ld] (%f - %f)=%f\n", $j, $i, $i+1, $y12, $y22, $y22-$y12 );
//		if( ($d1-$d2)>0.000001 && ($d3-$d2)>0.000001 && ($d2/$d1)<0.2 ) 
		if( ($d2/$d1)<0.85 && ($d2/$d3)<0.85 && $map[$j-2][$i]==$map[$j-1][$i] ) {
 //		    if($i>16 && $i<23) {
 //			fprintf($flog,"  *** %ld Swap %ld <=> %ld [%ld <=> %ld] ",$j,$i,$i+1,$cmap[$i],$cmap[$i+1]);
//			fprintf($flog,"      (%f %f %f) [%f %f] [%f %f] [%f %f] ",$d1,$d2,$d3,$y11,$y21,$y12,$y22,$y13,$y23);
////			fprintf($flog,"      ang %f %f %f %f \n",$ang1,$ang2,$ang3,$ang4);
//			fprintf($flog,"           cmap %ld =[",$j); for( $z=0; $z<$max_i; $z++) fprintf($flog," %ld",$cmap[$z]); fprintf($flog," ]\n");
//		    }
		    if(Check_MO_3D($j, $i, $cmap[$i], $cmap[$i+1], $flog)) {
//			fprintf($flog,"\n  *** %ld Swap %ld <=> %ld [%ld <=> %ld] ",$j,$i,$i+1,$cmap[$i],$cmap[$i+1]);
			fprintf($flog,"  3D control [OK]",$j,$i,$i+1,$cmap[$i],$cmap[$i+1]);
			$swap = $cmap[$i];
			$cmap[$i] = $cmap[$i+1];
			$cmap[$i+1] = $swap;
		    }
//		    if($i>16 && $i<23) {
//			fprintf($flog,"     ### [%ld %ld %ld %ld %ld %ld] ",$cmap[$i-2],$cmap[$i-1],$cmap[$i],$cmap[$i+1],$cmap[$i+2],$cmap[$i+3]);
////			fprintf($flog,"     ### [%ld %ld %ld %ld %ld %ld] ",$cmap[17],$cmap[18],$cmap[19],$cmap[20],$cmap[21],$cmap[22]);
////			fprintf($flog,"           cmap %ld =[",$j); for( $z=0; $z<$max_i; $z++) fprintf($flog," %ld",$cmap[$z]); fprintf($flog," ]\n");
//		    }
//		    $map[$j]=$cmap;
		}
	    }
	}
    }
    $map[$j]=$cmap;
//    fprintf($fout," %7.4f; %17.9f; %17.9f; %17.9f;  ", $Prop[$j]['d'], $Prop[$j]['E'], $Prop[$j]['HOMO'], $Prop[$j]['LUMO'] );
//    for( $z=0; $z<$max_i; $z++ ) { $ind=$map[$j-1][$z]; fprintf($fout," %f;", $m[$j][$ind]['Eh']); }

//    fprintf($flog,"cmap %ld =[",$j); for( $i=0; $i<$max_i; $i++) fprintf($flog," %ld",$cmap[$i]); fprintf($flog," ]\n");
////    fprintf($flog,"$ %ld [%ld %ld %ld %ld %ld %ld] \n", $j, $cmap[17], $cmap[18], $cmap[19], $cmap[20], $cmap[21], $cmap[22] );
////    fprintf($flog,"@; %f; %f; %f; %f; %f; %f; %f; \n", $Prop[$j]['d'], $m[$j][$cmap[17]]['Eh'], $m[$j][$cmap[18]]['Eh'], $m[$j][$cmap[19]]['Eh'], $m[$j][$cmap[20]]['Eh'], $m[$j][$cmap[21]]['Eh'], $m[$j][$cmap[22]]['Eh'] );
 }
 fprintf($flog,"cmap %ld =[",$j); for( $i=0; $i<$max_i; $i++) fprintf($flog," %ld",$cmap[$i]); fprintf($flog," ]\n");

 for( $j=0; $j<$max_j; $j++) {
    fprintf($fout," %7.4f; %17.9f; %17.9f; %17.9f;  ", $Prop[$j]['d'], $Prop[$j]['E'], $Prop[$j]['HOMO'], $Prop[$j]['LUMO'] );
    fprintf($fmap," %7.4f; %17.9f; %17.9f; %17.9f;  ", $Prop[$j]['d'], $Prop[$j]['E'], $Prop[$j]['HOMO'], $Prop[$j]['LUMO'] );
    $SumE=0.0;
    $SumEz=0.0;
    for( $i=0; $i<$max_i; $i+=1) {
	$a=0;
	for( $z=0; $z<$max_i; $z++ ) if( $map[$j][$z]==$i ) {$a=$z; break; }
	fprintf($fout," %f;", $m[$j][$a]['Eh']);
	fprintf($fmap," %ld;", $a);
	$SumE+=$m[$j][$a]['Eh'];
	if($i<27) $SumEz+=$m[$j][$a]['Eh'];
	}
    fprintf($fout,"\n");
    fprintf($fmap,"\n");
    fprintf($flog,"%03ld; %7.4f; %17.9f; %17.9f; %17.9f; %17.9f;\n", $j, $Prop[$j]['d'], $Prop[$j]['E'], $SumE, $SumEz, $SumE-$SumEz );
    }

 return $map;
}

$d=0.0;
$E=0.0;
$HOMO=0;
$LUMO=0;
$MO=array();
$MMO=array();
$Prop=array();
$n=0;
$flog = fopen("$SysName.log", "w");
$fout = fopen("$SysName.mo", "w");
$fmap = fopen("$SysName.map", "w");
//if (($fin = fopen('php://stdin', "r")) !== FALSE) {
if (($fin = fopen("$SysName/$SysName.out", "r")) !== FALSE) {
    while (!feof ($fin)) {
        $s = rtrim(ltrim(fgets($fin))); if(strlen($s)<1) continue; 
	if( strpos($s,"ORBITAL ENERGIES")===0 ) {
	    fgets($fin);fgets($fin);fgets($fin);
	    $MO=ReadMO($fin,$HOMO,$LUMO);
	    continue;
	}
	if( strpos($s,"FINAL SINGLE POINT ENERGY")===0 ) {
	    $E=floatval(substr($s,30,42));
	    continue;
	}
	if( strpos($s,"RELAXED SURFACE SCAN STEP")>0 && count($MO)>0 ) {
	    fgets($fin);$s=fgets($fin);
	    printf(" %7.4f; %17.9f; %17.9f; %17.9f;  ",$d,$E,$HOMO,$LUMO);
	    for( $i=0; $i<count($MO); $i++ ) printf(" %f;", $MO[$i]['Eh']);
	    $MMO[$n]=$MO;
	    $Prop[$n]=array( 'd'=>$d, 'E'=>$E, 'HOMO'=>$HOMO, 'LUMO'=>$LUMO );
	    $n++;
	    printf("\n");
	    $d=floatval(substr($s,46,58));
	    continue;
	}
	if( strpos($s,"RELAXED SURFACE SCAN STEP")>0 && count($MO)==0 ) {
	    fgets($fin);$s=fgets($fin);
	    $d=floatval(substr($s,46,58));
	    continue;
	}
    }
    fclose($fin);
    printf(" %7.4f; %17.9f; %17.9f; %17.9f;  ",$d,$E,$HOMO,$LUMO);
    for( $i=0; $i<count($MO); $i++ ) printf(" %f;", $MO[$i]['Eh']);
    $MMO[$n]=$MO;
    $Prop[$n]=array( 'd'=>$d, 'E'=>$E, 'HOMO'=>$HOMO, 'LUMO'=>$LUMO );
    $n++;
    printf("\n");
}

//var_dump($MMO);
$map = trace_MMO($MMO,$Prop,$flog,$fout,$fmap);
fclose($flog);
fclose($fout);
fclose($fmap);


//         *               RELAXED SURFACE SCAN STEP   2               *
//         *                                                           *
//         *                 Bond (  8,   2)  :   0.91002506           *
//FINAL SINGLE POINT ENERGY      -340.398846304393

//	    printf("  (%.8f %.8f %.8f) [%f %f] [%f %f] [%f %f]\n",abs($y11-$y21),abs($y12-$y22),abs($y13-$y23),$y11,$y21,$y12,$y22,$y13,$y23);
//	    printf("  ang %f %f %f %f\n",$ang1,$ang2,$ang3,$ang4);
//        if( vangle(1.0,$y11-$y,1.0,$y-$y13) < vangle(1.0,$y11-$y,1.0,$y-$y23) )
//	    if( vangle(1.0,$y21-$y,1.0,$y-$y23) < vangle(1.0,$y21-$y,1.0,$y-$y13) ) {
/*		if( ($y22-$y21)<0 && ($y23-$y22)>0 )
		if( ($y12-$y11)>0 && ($y13-$y12)<0 ) {
		if( abs($y12-$y22)<abs($y13-$y23) ) {
		var_dump(0.000002<0.000002);
		var_dump(abs($y12-$y22)<abs($y11-$y21));
		var_dump(abs($y12-$y22)<abs($y13-$y23));
		var_dump(abs($y12-$y22));
		var_dump($y12);
		var_dump($y22);
		var_dump(abs($y11-$y21));
		var_dump($y11);
		var_dump($y21);
		var_dump(abs($y12-$y22));
		var_dump($y12);
		var_dump($y22);
		var_dump(abs($y13-$y23));
		var_dump($y13);
		var_dump($y23);*/
//	if( $ang1 < $ang2 )
//	    if( $ang3 < $ang4 ) {

?>

