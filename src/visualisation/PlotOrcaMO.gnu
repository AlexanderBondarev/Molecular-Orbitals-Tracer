
set terminal pngcairo  transparent enhanced font "arial,16" fontscale 1.0 size 1200,1200
set view map scale 1
set style data lines
#set xtics border in scale 0,0 mirror norotate  autojustify
#set ytics border in scale 0,0 mirror norotate  autojustify
#set ztics border in scale 0,0 nomirror norotate  autojustify
#unset cbtics
#set rtics axis in scale 0,0 nomirror norotate  autojustify
#set title "Heat Map" 

set output "NH2-N2+-LUMO-HOMO.png"
set yrange [0:700]
set xlabel "Distance C-N, A" font "Helvetica-Bold,18"
set ylabel "dE, kJ/mol" font "Helvetica-Bold,18"
plot 'NH2-N2+.mo' using 1:(2625.5*($2+341.0)) with lines ls 3 lw 7 ti "E", \
 'NH2-N2+.mo' using 1:(2625.5*$3+1290) with lines ls 2 lw 3 ti "HOMO", \
 'NH2-N2+.mo' using 1:(2625.5*$4+1290) with lines ls 1 lw 3 ti "LUMO", \
 'NH2-N2+.mo' using 1:(2625.5*($4-$3)) with lines ls 4 lw 3 ti "LUMO-HOMO"
unset yrange
unset key


set output "NH2-N2+-MO.png"
set xlabel "Distance C-N, A" font "Helvetica-Bold,18"
set ylabel "E, Hartree" font "Helvetica-Bold,18"
plot 'NH2-N2+.mo' using 1:27 with lines ls 2 lw 3 notitle, \
 'NH2-N2+.mo' using 1:28 with lines ls 2 lw 3 notitle, \
 'NH2-N2+.mo' using 1:29 with lines ls 2 lw 3 notitle, \
 'NH2-N2+.mo' using 1:30 with lines ls 2 lw 3 notitle, \
 'NH2-N2+.mo' using 1:31 with lines ls 2 lw 3 notitle, \
 'NH2-N2+.mo' using 1:32 with lines ls 1 lw 3 notitle, \
 'NH2-N2+.mo' using 1:33 with lines ls 1 lw 3 notitle, \
 'NH2-N2+.mo' using 1:34 with lines ls 1 lw 3 notitle


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 2000,2000
set output "NH2-N2+-MO-all.png"
set multiplot
set xrange [0.9:6.5]
set yrange [-17.0:4.0]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
set label "NH2-N_2^+" at 4.4,-15 left font "Helvetica,32"
set label "NH2^+" at 5.15,-15 left font "Helvetica,32"
set label "N_2" at 5.55,-15 left font "Helvetica,32"
do for [i=5:31:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=32:228:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 1 lw 2 notitle }
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 2 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 2 notitle }
unset multiplot


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 2000,2000
set output "NH2-N2+-MO-more.png"
set multiplot
set xrange [0.9:6.5]
set yrange [-1.5:0.0]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
set label "NH2-N_2^+" at 4.4,-1.4 left font "Helvetica,32"
set label "NH2^+" at 5.15,-1.4 left font "Helvetica,32"
set label "N_2" at 5.55,-1.4 left font "Helvetica,32"
do for [i=5:31:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=32:228:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 1 lw 2 notitle }
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 2 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 2 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 2 notitle }
plot 'NH2-N2+.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 2000,2000
set output "NH2-N2+-MO-rmo-color.png"
set multiplot
set xrange [0.9:18.5]
set yrange [-1.5:-0.4]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
unset label
set label "NH2-N_2^+" at 4.4,-1.3 left font "Helvetica,32"
set label "NH2^+" at 5.15,-1.3 left font "Helvetica,32"
set label "N_2" at 5.55,-1.3 left font "Helvetica,32"
#do for [i=5:31:1] { plot 'NH2-N2+.rmo' using 1:i with points ls i lw 2.0 pt 0 ps 0.5 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.rmo' using 1:i with points ls i lw 0.2 pt 0 ps 0.1 notitle }
do for [i=5:31:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls i lw 3 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls i lw 2 notitle }
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+.rmo' using 1:($2+340.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 2000,2000
set output "NH2-N2+-MO-rmo.png"
set multiplot
set xrange [0.9:6.5]
set yrange [-1.5:-0.4]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)
unset label
set label "NH2-N_2^+" at 4.4,-1.3 left font "Helvetica,32"
set label "NH2^+" at 5.15,-1.3 left font "Helvetica,32"
set label "N_2" at 5.55,-1.3 left font "Helvetica,32"
do for [i=7:12:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=14:21:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=23:23:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=25:25:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=29:31:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls 2 lw 4 notitle }
plot 'NH2-N2+.rmo' using 1:5 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:6 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:13 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:22 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:24 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:27 with lines ls 4 lw 4 notitle
plot 'NH2-N2+.rmo' using 1:28 with lines ls 4 lw 4 notitle
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 4 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 4 lw 4 notitle }
#plot 'NH2-N2+.rmo' using 1:($2+340.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 2000,2000
set output "NH2-N2+-MO-rmo-1.3832.png"
set multiplot
set xrange [1.3832:6.5]
set yrange [-1.5:-0.4]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
unset label
set label "NH2-N_2^+" at 4.4,-1.3 left font "Helvetica,32"
set label "NH2^+" at 5.15,-1.3 left font "Helvetica,32"
set label "N_2" at 5.55,-1.3 left font "Helvetica,32"
#do for [i=5:31:1] { plot 'NH2-N2+.rmo' using 1:i with points ls i lw 2.0 pt 0 ps 0.5 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.rmo' using 1:i with points ls i lw 0.2 pt 0 ps 0.1 notitle }
do for [i=5:31:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls i lw 3 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.rmo' using 1:i with lines ls i lw 2 notitle }
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 3 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 3 notitle }
do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 3 notitle }
#plot 'NH2-N2+.rmo' using 1:($2+340.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,4000
set output "NH2-N2+-MO-d1.3832.png"
set multiplot
set xrange [1.3832:6.5]
set yrange [-1.5:-0.4]
set xlabel "Distance C-N, A" font "Helvetica-Bold,32"
set ylabel "E, Hartree" font "Helvetica-Bold,32"
set label "NH2-N_2^+" at 4.4,-1.4 left font "Helvetica,32"
set label "NH2^+" at 5.15,-1.4 left font "Helvetica,32"
set label "N_2" at 5.55,-1.4 left font "Helvetica,32"
do for [i=5:31:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 2 lw 1 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 1 lw 1 notitle }
do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 2 notitle }
#do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 2 notitle }
do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 2 notitle }
#do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 2 notitle }
#plot 'NH2-N2+.mo' using 1:($2+341.0) with lines ls 3 lw 3 ti "dE, Hartree"
unset multiplot


#set terminal canvas enhanced mousing rounded size 1200,1200 jsdir "js" fsize 10 lw 1.6 fontscale 1 
#set output "NH2-N2+-MO-all.html"
#set terminal svg size 1800,1800 font "Arial,32"
#set output "NH2-N2+-MO-all.svg"
#set multiplot
#set xrange [0.9:6.5]
#set yrange [-14.0:2.0]
#set label "NH2-N_2^+" at 4.7,-1.5 left font "Helvetica,32"
#set label "NH2^+" at 5.2,-1.5 left font "Helvetica,32"
#set label "N_2" at 5.6,-1.5 left font "Helvetica,32"
#do for [i=5:31:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 2 lw 0.1 notitle }
#do for [i=32:228:1] { plot 'NH2-N2+.mo' using 1:i with lines ls 1 lw 0.1 notitle }
#do for [i=5:24:1] { plot 'NH2+.mo' using 1:i with lines ls 2 lw 0.1 notitle }
#do for [i=25:182:1] { plot 'NH2+.mo' using 1:i with lines ls 1 lw 0.1 notitle }
#do for [i=5:11:1] { plot 'N2.mo' using 1:i with lines ls 2 lw 0.1 notitle }
#do for [i=12:45:1] { plot 'N2.mo' using 1:i with lines ls 1 lw 0.1 notitle }
#unset multiplot


set terminal pngcairo  transparent enhanced font "arial,12" fontscale 1.0 size 1200,1200
set xrange [ 14.500000 : 40.50000 ] noreverse nowriteback
set yrange [ -0.500000 : 400.50000 ] noreverse nowriteback
set view 125,55
unset label
set xlabel "MO" font "Helvetica-Bold,12"
set ylabel "Step" font "Helvetica-Bold,12"
set output "NH2-N2+-MO-Surf.png"
splot 'NH2-N2+.mo' matrix with points pt 7 ps 0.1 notitle

quit

