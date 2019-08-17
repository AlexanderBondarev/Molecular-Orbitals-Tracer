#set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set terminal svg size 4000,2600 font "Helvetica,50"

k=(16.9-0.9)/800

set output "Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n800-trace-all.svg"
set multiplot
set nokey
#set xlabel "Step" font "Helvetica-Bold,50"
set xlabel "d(C1-N1), Å" font "Helvetica-Bold,50"
set ylabel "E, Hartree" font "Helvetica-Bold,50"
#set xrange [0.9:5.0]
set yrange [-15:5.5]
do for [i=4:139:1] { plot 'Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n800-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 notitle }
unset multiplot

set output "Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n800-trace.svg"
set multiplot
set nokey
#set xlabel "Step" font "Helvetica-Bold,50"
set xlabel "d(C1-N1), Å" font "Helvetica-Bold,50"
set ylabel "E, Hartree" font "Helvetica-Bold,50"
#set xrange [0.9:5.0]
set yrange [-1.6:0.2]
do for [i=4:30:1] { plot 'Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n800-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 notitle }
do for [i=31:41:1] { plot 'Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n800-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 dashtype 2 notitle }
unset multiplot
