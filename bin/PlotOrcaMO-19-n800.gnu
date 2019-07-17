set terminal pngcairo  transparent enhanced font "arial,32" fontscale 1.0 size 4000,2000
set output "HF-B3LYP-SVP-MTMO-d009-809-n800-trace.png"
set multiplot
set xrange [0.9:5.0]
#set yrange [-1.0:1.5]
#set yrange [-0.5:0]
#set xlabel "Distance C-N, A" font "Helvetica-Bold,30"
set xlabel "Step" font "Helvetica-Bold,30"
set ylabel "E, Hartree" font "Helvetica-Bold,30"
#set label "NH_2-N_2^+" at 15.0,-16.0 left font "Helvetica,28"
#set label "NH_2^+" at 16.8,-16.0 left font "Helvetica,28"
#set label "N_2" at 17.7,-16.0 left font "Helvetica,28"
#do for [i=4:19:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:i with lines ls i lw 4 ti "i" }
#do for [i=2:6:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:i with lines ls 2 lw 3 notitle }
#do for [i=7:19:1] { plot 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:i with lines ls 1 lw 3 notitle }

plot 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 2:6 with lines ls 3 lw 4 ti "3", \
 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 2:7 with lines ls 4 lw 4 ti "4", \
 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 2:8 with lines ls 5 lw 4 ti "5"
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:7 with lines ls 7 lw 4 ti "6"
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:3 with lines ls 3 lw 4 ti "2"

unset multiplot

quit

# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:8 with lines ls 8 lw 4 ti "7", \
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:9 with lines ls 9 lw 4 ti "8", \
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:10 with lines ls 10 lw 4 ti "9", \
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:11 with lines ls 11 lw 4 ti "10", \
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:12 with lines ls 12 lw 4 ti "11", \
# 'HF-B3LYP-SVP-MTMO-d009-809-n800-trace.csv' using 1:13 with lines ls 13 lw 4 ti "12", \
