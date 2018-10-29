
set terminal pngcairo  transparent enhanced font "arial,16" fontscale 1.0 size 1200,800
set view map scale 1
set style data lines

set xlabel "Distance C-N, A" font "Helvetica-Bold,16"
do for [i=1:27:1] {
 fdat = sprintf("Ph-N2+/MO%d/MO%d-stat.dat",i,i)
 fout1 = sprintf("Ph-N2+/MO%d/MO%d-stat-r.png",i,i)
 fout2 = sprintf("Ph-N2+/MO%d/MO%d-stat-r2.png",i,i)
 print fdat
 set output fout1
 set ylabel "Density" font "Helvetica-Bold,16"
 plot fdat using 3:7 with lines ls 1 lw 7
 set output fout2
 set ylabel "Density^2" font "Helvetica-Bold,16"
 plot fdat using 3:9 with lines ls 2 lw 7
}

set output 'MO-stat-r.png'
unset yrange
set xlabel
set ylabel
set multiplot
do for [i=1:27:1] {
 fdat = sprintf("Ph-N2+/MO%d/MO%d-stat.dat",i,i)
 s = sprintf("%d",i);
 plot fdat using 3:7 with lines ls i lw 7 ti s
}
unset multiplot
set ylabel "Density" font "Helvetica-Bold,16"
set xlabel "Distance C-N, A" font "Helvetica-Bold,16"
unset yrange
unset key

quit

