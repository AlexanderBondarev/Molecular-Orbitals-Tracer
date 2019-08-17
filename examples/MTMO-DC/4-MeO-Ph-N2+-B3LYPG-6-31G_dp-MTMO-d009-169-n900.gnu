#set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set terminal svg size 4000,2600 font "Helvetica,50"

#set yrange [-0.5:0]
#set xlabel "Distance C-N, A" font "Helvetica-Bold,30"
#set label "NH_2-N_2^+" at 15.0,-16.0 left font "Helvetica,28"
#set label "NH_2^+" at 16.8,-16.0 left font "Helvetica,28"
#set label "N_2" at 17.7,-16.0 left font "Helvetica,28"
#do for [i=4:19:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n900-trace.csv' using 1:i with lines ls i lw 4 ti "i" }
#do for [i=2:6:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n900-trace.csv' using 1:i with lines ls 2 lw 3 notitle }
#do for [i=7:19:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n900-trace.csv' using 1:i with lines ls 1 lw 3 notitle }

k=(16.9-0.9)/900

set output "4-MeO-Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n900-trace-all.svg"
set multiplot
set nokey
#set xlabel "Step" font "Helvetica-Bold,50"
set xlabel "d, Å" font "Helvetica-Bold,50"
set ylabel "E, Hartree" font "Helvetica-Bold,50"
#set xrange [0.9:5.0]
set yrange [-20:5.5]
do for [i=4:177:1] { plot '4-MeO-Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n900-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 notitle }
unset multiplot

set output "4-MeO-Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n900-trace.svg"
set multiplot
set nokey
#set xlabel "Step" font "Helvetica-Bold,50"
set xlabel "d, Å" font "Helvetica-Bold,50"
set ylabel "E, Hartree" font "Helvetica-Bold,50"
#set xrange [0.9:5.0]
set yrange [-1.5:0.2]
do for [i=4:38:1] { plot '4-MeO-Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n900-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 notitle }
do for [i=39:54:1] { plot '4-MeO-Ph-N2+-B3LYPG-6-31G_dp-MTMO-d009-169-n900-trace.csv' using ($1*k+0.9):i with lines ls i lw 3 dashtype 2 notitle }
unset multiplot

