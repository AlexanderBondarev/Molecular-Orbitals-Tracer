
set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n800-more.png"
set multiplot
set xrange [0.9:18.5]
set yrange [-17:0.0]
set xlabel "Distance C-N, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
set label "NH_2-N_2^+" at 15.0,-16.0 left font "Helvetica,28"
set label "NH_2^+" at 16.8,-16.0 left font "Helvetica,28"
set label "N_2" at 17.7,-16.0 left font "Helvetica,28"
do for [i=5:16:1] { plot 'NH2-N2+-n800.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=17:92:1] { plot 'NH2-N2+-n800.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=9:46:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+-n800.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot

set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n800-rmo.png"
set multiplot
set xrange [0.9:18.5]
set yrange [-1.8:-0.1]
set xlabel "Distance C-N, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
unset label
set label "NH_2-N_2^+" at 16.2,-1.4 left font "Helvetica,30"
set label "NH_2^+" at 17.1,-1.4 left font "Helvetica,30"
set label "N_2" at 17.6,-1.4 left font "Helvetica,30"
do for [i=5:16:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls i lw 3 notitle }
#do for [i=17:92:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=9:46:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+-n800.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot

set terminal pngcairo  transparent enhanced font "arial,30" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n800-MO-rmo.png"
set multiplot
set xrange [0.9:18.5]
set yrange [-1.8:-0.1]
set xlabel "Distance C-N, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)
unset label
set label "NH_2-N_2^+" at 16.2,-1.4 left font "Helvetica,30"
set label "NH_2^+" at 17.1,-1.4 left font "Helvetica,30"
set label "N_2" at 17.6,-1.4 left font "Helvetica,30"
do for [i=7:12:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=14:21:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=23:23:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=25:25:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=29:31:1] { plot 'NH2-N2+-n800.rmo' using 1:i with lines ls 2 lw 4 notitle }
plot 'NH2-N2+-n800.rmo' using 1:5 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:6 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:13 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:22 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:24 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:27 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n800.rmo' using 1:28 with lines ls 4 lw 4 notitle
do for [i=5:8:1] { plot 'NH2+-n800.mo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=5:11:1] { plot 'N2-n800.mo' using 1:i with lines ls 4 lw 4 notitle }
#plot 'NH2-N2+-n800.rmo' using 1:($2+340.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


quit

