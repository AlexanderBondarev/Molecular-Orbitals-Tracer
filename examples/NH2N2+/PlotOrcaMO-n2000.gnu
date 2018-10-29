
set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n2000-more.png"
set multiplot
set xrange [0.9:60.0]
set yrange [-17:4.0]
set xlabel "Distance NH_2-N_2^+, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
set label "NH_2-N_2^+" at 46.0,-2.0 left font "Helvetica,30"
set label "N_2" at 52.3,-2.0 left font "Helvetica,30"
set label "NH_2^+" at 54.0,-2.0 left font "Helvetica,30"
set label "N_2^+" at 56.2,-2.0 left font "Helvetica,30"
set label "NH_2" at 58.0,-2.0 left font "Helvetica,30"
#do for [i=5:15:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls i lw 3 notitle }
do for [i=5:15:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=16:91:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:50:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=9:45:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:18:1] { plot 'N2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=19:97:1] { plot 'N2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:14:1] { plot 'NH2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=15:87:1] { plot 'NH2.mo' using 1:i with lines ls 1 lw 3 notitle }
#do for [i=5:16:1] { plot 'NH2-N2+-n2000.mo' using 1:i with lines ls 2 lw 3 notitle }
#do for [i=17:92:1] { plot 'NH2-N2+-n2000.mo' using 1:i with lines ls 1 lw 3 notitle }
#do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
#do for [i=9:46:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
#do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
#do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+-n2000.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot



set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n2000-rmo.png"
set multiplot
set xrange [0.9:60.0]
set yrange [-1.8:-0.1]
set xlabel "Distance NH_2-N_2^+, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
unset label
set label "NH_2-N_2^+" at 46.0,-1.4 left font "Helvetica,30"
set label "N_2" at 52.3,-1.4 left font "Helvetica,30"
set label "NH_2^+" at 54.0,-1.4 left font "Helvetica,30"
set label "N_2^+" at 56.2,-1.4 left font "Helvetica,30"
set label "NH_2" at 58.0,-1.4 left font "Helvetica,30"
do for [i=5:15:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls i lw 3 notitle }
do for [i=16:91:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:50:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=9:45:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:18:1] { plot 'N2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=19:97:1] { plot 'N2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:14:1] { plot 'NH2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=15:87:1] { plot 'NH2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+-n2000.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot



set terminal pngcairo  transparent enhanced font "arial,30" fontscale 1.0 size 4000,2000
set output "NH2-N2+-n2000-MO-rmo.png"
set multiplot
set xrange [0:60.0]
set yrange [-1.8:0.0]
set xlabel "Distance NH_2-N_2^+, A" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)
unset label
set label "NH_2-N_2^+" at 46.0,-1.4 left font "Helvetica,30"
set label "N_2" at 52.3,-1.4 left font "Helvetica,30"
set label "NH_2^+" at 54.0,-1.4 left font "Helvetica,30"
set label "N_2^+" at 56.2,-1.4 left font "Helvetica,30"
set label "NH_2" at 58.0,-1.4 left font "Helvetica,30"

set linestyle 17 lt 7 lw 3 lc -1 dashtype 2
set style arrow 17 nohead ls 17 lw 1.2
set arrow from 1.288,0 to 1.288,-1.8 as 17
set label "1.288" at 2.2,-1.75 center font "arial,30"

set linestyle 11 lt 7 lw 3 lc rgb "red" dashtype 2
set style arrow 11 nohead ls 11 lw 1.2
set linestyle 12 lt 7 lw 3 lc rgb "green" dashtype 2
set style arrow 12 nohead ls 12 lw 1.2
set linestyle 14 lt 7 lw 3 lc rgb "orange" dashtype 2
set style arrow 14 nohead ls 14 lw 1.2

set arrow from 50.9,-14.560429 to 52,-14.450116 as 12
set arrow from 50.9,-14.558954 to 52,-14.448600 as 12
set arrow from 50.9,-1.233369 to 52,-1.134986 as 12
set arrow from 50.9,-0.659225 to 52,-0.563245 as 12
set arrow from 50.9,-0.566409 to 52,-0.471908 as 12
set arrow from 50.9,-0.566425 to 52,-0.471925 as 12
set arrow from 50.9,-0.131629 to 52,-0.039746 as 12

set arrow from 50.9,-0.527431 to 52,-0.438459 as 11
set arrow from 50.9,-0.525376 to 54,-0.610093 as 11

set arrow from 50.9,-14.770716 to 54,-14.889393 as 14
set arrow from 50.9,-1.171813 to 54,-1.265568 as 14
set arrow from 50.9,-0.798767 to 54,-0.891819 as 14
set arrow from 50.9,-0.651392 to 54,-0.744735 as 14
set arrow from 50.9,-0.202743 to 54,-0.265744 as 14

#do for [i=7:12:1] { plot 'NH2-N2+-n2000.rmo' using 1:i with lines ls 2 lw 4 notitle }
plot 'NH2-N2+-n2000.rmo' using 1:5 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:6 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:7 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:8 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:9 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:10 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:11 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:12 with lines ls 4 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:13 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:14 with lines ls 2 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:15 with lines ls 7 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:16 with lines ls 1 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:17 with lines ls 1 lw 4 notitle
plot 'NH2-N2+-n2000.rmo' using 1:18 with lines ls 7 lw 4 notitle
#do for [i=5:8:1] { plot 'NH2+-n2000.mo' using 1:i with lines ls 2 lw 4 notitle }
#do for [i=5:11:1] { plot 'N2-n2000.mo' using 1:i with lines ls 4 lw 4 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:50:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:8:1] { plot 'NH2+.mo' using 1:i with lines ls 4 lw 3 notitle }
do for [i=9:45:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:18:1] { plot 'N2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=19:97:1] { plot 'N2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:14:1] { plot 'NH2.mo' using 1:i with lines ls 4 lw 3 notitle }
do for [i=15:87:1] { plot 'NH2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+-n2000.rmo' using 1:($2+340.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot

quit

