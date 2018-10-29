
set terminal pngcairo  transparent enhanced font "arial,30" fontscale 1.0 size 2000,2000
set output "NH2-N2+-Diagram.png"
set multiplot
set xrange [0:7]
set yrange [-1.8:0.0]
#set yrange [-17:1.0]
set ylabel "E, Hartree" font "Helvetica-Bold,30"
rgb(r,g,b) = int(r)*65536 + int(g)*256 + int(b)
unset label
#unset border
unset tics
set ytics axis -1.8,0.2,0
#set ytics axis -17,2,1

set label "NH_2-N_2^+" at 3.3,-1.6 left font "Helvetica-Bold,30"
set label "N_2" at 1.4,-1.6 left font "Helvetica-Bold,30"
set label "NH_2^+" at 5.35,-1.6 left font "Helvetica-Bold,30"

#set label "NH_2-N_2^+" at 3.3,-16 left font "Helvetica-Bold,30"
#set label "N_2" at 1.4,-16 left font "Helvetica-Bold,30"
#set label "NH_2^+" at 5.35,-16 left font "Helvetica-Bold,30"

set linestyle 17 lt 7 lw 4 lc -1 dashtype 2
set style arrow 17 nohead ls 17 lw 1.2

set linestyle 11 lt 7 lw 4 lc rgb "red" dashtype 2
set style arrow 11 nohead ls 11 lw 1.2
set linestyle 12 lt 7 lw 4 lc rgb "green" dashtype 2
set style arrow 12 nohead ls 12 lw 1.2
set linestyle 14 lt 7 lw 4 lc rgb "orange" dashtype 2
set style arrow 14 nohead ls 14 lw 1.2

set arrow from 3,-14.813807 to 2,-14.450116 as 12
set arrow from 3,-14.719726 to 2,-14.448600 as 12
set arrow from 3,-1.458669 to 2,-1.134986 as 12
set arrow from 3,-0.965855 to 2,-0.563245 as 12
set arrow from 3,-0.747709 to 2,-0.471908 as 12
set arrow from 3,-0.738254 to 2,-0.471925 as 12
set arrow from 3,-0.338540 to 2,-0.039746 as 12

set arrow from 3,-0.600942 to 2,-0.438459 as 11
#set arrow from 4,-0.600942 to 5,-0.610093 as 11
set arrow from 4,-0.235372 to 5,-0.610093 as 11
#set arrow from 3,-0.235372 to 2,-0.438459 as 11

set arrow from 4,-14.747813 to 5,-14.889393 as 14
set arrow from 4,-1.298670 to 5,-1.265568 as 14
set arrow from 4,-0.886050 to 5,-0.891819 as 14
set arrow from 4,-0.809290 to 5,-0.744735 as 14
set arrow from 4,-0.299308 to 5,-0.265744 as 14

plot 'NH2-N2+-Diagram.mo' using 1:5 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:6 with lines ls 4 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:7 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:8 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:9 with lines ls 4 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:10 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:11 with lines ls 4 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:12 with lines ls 4 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:13 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:14 with lines ls 2 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:15 with lines ls 7 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:16 with lines ls 1 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:17 with lines ls 1 lw 5 notitle
plot 'NH2-N2+-Diagram.mo' using 1:18 with lines ls 7 lw 5 notitle

do for [i=5:11:1] { plot 'N2-Diagram.mo' using 1:i with lines ls 2 lw 5 notitle }
do for [i=12:50:1] { plot 'N2-Diagram.mo' using 1:i with lines ls 1 lw 5 notitle }
do for [i=5:8:1] { plot 'NH2+-Diagram.mo' using 1:i with lines ls 4 lw 5 notitle }
do for [i=9:45:1] { plot 'NH2+-Diagram.mo' using 1:i with lines ls 1 lw 5 notitle }
unset multiplot

quit

