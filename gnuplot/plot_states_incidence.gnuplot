load "template.gnuplot"

set output '../plots_de/plot_incidence_states.png'

# x-axis setup
set ytics( \
  states_name_de[1]   2,\
  states_name_de[2]   3,\
  states_name_de[3]   4,\
  states_name_de[4]   5,\
  states_name_de[5]   6,\
  states_name_de[6]   7,\
  states_name_de[7]   8,\
  states_name_de[8]   9,\
  states_name_de[9]  10,\
  states_name_de[10] 11,\
  states_name_de[11] 12,\
  states_name_de[12] 13,\
  states_name_de[13] 14,\
  states_name_de[14] 15,\
  states_name_de[15] 16,\
  states_name_de[16] 17 \
)
set yrange [17.5:1.5] reverse
set ytics offset 0, 0
set lmargin 27.00
set tmargin 3.00
set rmargin 4.00
set bmargin 3.5

# grid
unset grid
set grid xtics ls 21 lc rgb '#aaaaaa'

# y-axis setup
set xrange [0: 100 < * ]
set xtics 0, 100, 10000000 out nomirror rotate by 0 offset 0, 0 scale 1.0 center
set mxtics 5
set format x '%.0f'

unset key

set offsets graph 0.001, graph 0.15, graph 0.00, graph 0.00

set boxwidth 0.50
set style fill solid 1.00

binwidth = 0.25

scaling_fac = 1000000

##################################### German

set label 1 at screen 0.50, 0.97 "{/Linux-Libertine-O-Bold*1.2 Inzidenz (pro 1 Mio.) der Affenpocken in Deutschland nach Bundesland}" center textcolor ls 0
set label 2 at screen 0.50, 0.93 sprintf("{/*0.75 (eigene Berechnung; Datenquelle: SurvStat\\@RKI 2.0, https://survstat.rki.de; Datenstand: %s)}", last_update_survstat) center textcolor ls 0

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_states.csv" using (0):(2):(0.0):($3/states_population[ 1]*scaling_fac):((2)-(binwidth/2.0)):((2)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 3):(0.0):( $4/states_population[ 2]*scaling_fac):(( 3)-(binwidth/2.0)):((3)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 4):(0.0):( $5/states_population[ 3]*scaling_fac):(( 4)-(binwidth/2.0)):((4)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 5):(0.0):( $6/states_population[ 4]*scaling_fac):(( 5)-(binwidth/2.0)):((5)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 6):(0.0):( $7/states_population[ 5]*scaling_fac):(( 6)-(binwidth/2.0)):((6)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 7):(0.0):( $8/states_population[ 6]*scaling_fac):(( 7)-(binwidth/2.0)):((7)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 8):(0.0):( $9/states_population[ 7]*scaling_fac):(( 8)-(binwidth/2.0)):((8)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 9):(0.0):($10/states_population[ 8]*scaling_fac):(( 9)-(binwidth/2.0)):((9)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(10):(0.0):($11/states_population[ 9]*scaling_fac):((10)-(binwidth/2.0)):((10)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(11):(0.0):($12/states_population[10]*scaling_fac):((11)-(binwidth/2.0)):((11)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(12):(0.0):($13/states_population[11]*scaling_fac):((12)-(binwidth/2.0)):((12)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(13):(0.0):($14/states_population[12]*scaling_fac):((13)-(binwidth/2.0)):((13)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(14):(0.0):($15/states_population[13]*scaling_fac):((14)-(binwidth/2.0)):((14)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(15):(0.0):($16/states_population[14]*scaling_fac):((15)-(binwidth/2.0)):((15)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(16):(0.0):($17/states_population[15]*scaling_fac):((16)-(binwidth/2.0)):((16)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(17):(0.0):($18/states_population[16]*scaling_fac):((17)-(binwidth/2.0)):((17)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  \
  "" using ( $3/states_population[ 1]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $4/states_population[ 2]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $5/states_population[ 3]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $6/states_population[ 4]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $7/states_population[ 5]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $8/states_population[ 6]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $9/states_population[ 7]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($10/states_population[ 8]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($11/states_population[ 9]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($12/states_population[10]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($13/states_population[11]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($14/states_population[12]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($15/states_population[13]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($16/states_population[14]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($17/states_population[15]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($18/states_population[16]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  \
  "" using ( $3/states_population[ 1]*scaling_fac):(  2):( $3>0?sprintf("{/*0.85 %.1f}",  $3/states_population[ 1]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $4/states_population[ 2]*scaling_fac):(  3):( $4>0?sprintf("{/*0.85 %.1f}",  $4/states_population[ 2]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $5/states_population[ 3]*scaling_fac):(  4):( $5>0?sprintf("{/*0.85 %.1f}",  $5/states_population[ 3]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $6/states_population[ 4]*scaling_fac):(  5):( $6>0?sprintf("{/*0.85 %.1f}",  $6/states_population[ 4]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $7/states_population[ 5]*scaling_fac):(  6):( $7>0?sprintf("{/*0.85 %.1f}",  $7/states_population[ 5]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $8/states_population[ 6]*scaling_fac):(  7):( $8>0?sprintf("{/*0.85 %.1f}",  $8/states_population[ 6]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $9/states_population[ 7]*scaling_fac):(  8):( $9>0?sprintf("{/*0.85 %.1f}",  $9/states_population[ 7]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($10/states_population[ 8]*scaling_fac):(  9):($10>0?sprintf("{/*0.85 %.1f}", $10/states_population[ 8]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($11/states_population[ 9]*scaling_fac):( 10):($11>0?sprintf("{/*0.85 %.1f}", $11/states_population[ 9]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($12/states_population[10]*scaling_fac):( 11):($12>0?sprintf("{/*0.85 %.1f}", $12/states_population[10]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($13/states_population[11]*scaling_fac):( 12):($13>0?sprintf("{/*0.85 %.1f}", $13/states_population[11]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($14/states_population[12]*scaling_fac):( 13):($14>0?sprintf("{/*0.85 %.1f}", $14/states_population[12]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($15/states_population[13]*scaling_fac):( 14):($15>0?sprintf("{/*0.85 %.1f}", $15/states_population[13]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($16/states_population[14]*scaling_fac):( 15):($16>0?sprintf("{/*0.85 %.1f}", $16/states_population[14]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($17/states_population[15]*scaling_fac):( 16):($17>0?sprintf("{/*0.85 %.1f}", $17/states_population[15]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($18/states_population[16]*scaling_fac):( 17):($18>0?sprintf("{/*0.85 %.1f}", $18/states_population[16]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle
  
##################################### English

set output '../plots_en/plot_incidence_states.png'

set ytics( \
  states_name_en[1]   2,\
  states_name_en[2]   3,\
  states_name_en[3]   4,\
  states_name_en[4]   5,\
  states_name_en[5]   6,\
  states_name_en[6]   7,\
  states_name_en[7]   8,\
  states_name_en[8]   9,\
  states_name_en[9]  10,\
  states_name_en[10] 11,\
  states_name_en[11] 12,\
  states_name_en[12] 13,\
  states_name_en[13] 14,\
  states_name_en[14] 15,\
  states_name_en[15] 16,\
  states_name_en[16] 17 \
)

set label 1 at screen 0.50, 0.97 "{/Linux-Libertine-O-Bold*1.2 Incidence (per 1M) of monkeypox in Germany per state}" center textcolor ls 0
set label 2 at screen 0.50, 0.93 sprintf("{/*0.75 (own calculation; data source: SurvStat\\@RKI 2.0, https://survstat.rki.de; last update: %s)}", last_update_survstat) center textcolor ls 0

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_states.csv" using (0):(2):(0.0):($3/states_population[ 1]*scaling_fac):((2)-(binwidth/2.0)):((2)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 3):(0.0):( $4/states_population[ 2]*scaling_fac):(( 3)-(binwidth/2.0)):((3)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 4):(0.0):( $5/states_population[ 3]*scaling_fac):(( 4)-(binwidth/2.0)):((4)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 5):(0.0):( $6/states_population[ 4]*scaling_fac):(( 5)-(binwidth/2.0)):((5)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 6):(0.0):( $7/states_population[ 5]*scaling_fac):(( 6)-(binwidth/2.0)):((6)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 7):(0.0):( $8/states_population[ 6]*scaling_fac):(( 7)-(binwidth/2.0)):((7)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 8):(0.0):( $9/states_population[ 7]*scaling_fac):(( 8)-(binwidth/2.0)):((8)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 9):(0.0):($10/states_population[ 8]*scaling_fac):(( 9)-(binwidth/2.0)):((9)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(10):(0.0):($11/states_population[ 9]*scaling_fac):((10)-(binwidth/2.0)):((10)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(11):(0.0):($12/states_population[10]*scaling_fac):((11)-(binwidth/2.0)):((11)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(12):(0.0):($13/states_population[11]*scaling_fac):((12)-(binwidth/2.0)):((12)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(13):(0.0):($14/states_population[12]*scaling_fac):((13)-(binwidth/2.0)):((13)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(14):(0.0):($15/states_population[13]*scaling_fac):((14)-(binwidth/2.0)):((14)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(15):(0.0):($16/states_population[14]*scaling_fac):((15)-(binwidth/2.0)):((15)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(16):(0.0):($17/states_population[15]*scaling_fac):((16)-(binwidth/2.0)):((16)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(17):(0.0):($18/states_population[16]*scaling_fac):((17)-(binwidth/2.0)):((17)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  \
  "" using ( $3/states_population[ 1]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $4/states_population[ 2]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $5/states_population[ 3]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $6/states_population[ 4]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $7/states_population[ 5]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $8/states_population[ 6]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $9/states_population[ 7]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($10/states_population[ 8]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($11/states_population[ 9]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($12/states_population[10]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($13/states_population[11]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($14/states_population[12]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($15/states_population[13]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($16/states_population[14]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($17/states_population[15]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($18/states_population[16]*scaling_fac):(1) with points ls 1 ps 0.0001 notitle, \
  \
  "" using ( $3/states_population[ 1]*scaling_fac):(  2):( $3>0?sprintf("{/*0.85 %.1f}",  $3/states_population[ 1]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $4/states_population[ 2]*scaling_fac):(  3):( $4>0?sprintf("{/*0.85 %.1f}",  $4/states_population[ 2]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $5/states_population[ 3]*scaling_fac):(  4):( $5>0?sprintf("{/*0.85 %.1f}",  $5/states_population[ 3]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $6/states_population[ 4]*scaling_fac):(  5):( $6>0?sprintf("{/*0.85 %.1f}",  $6/states_population[ 4]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $7/states_population[ 5]*scaling_fac):(  6):( $7>0?sprintf("{/*0.85 %.1f}",  $7/states_population[ 5]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $8/states_population[ 6]*scaling_fac):(  7):( $8>0?sprintf("{/*0.85 %.1f}",  $8/states_population[ 6]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $9/states_population[ 7]*scaling_fac):(  8):( $9>0?sprintf("{/*0.85 %.1f}",  $9/states_population[ 7]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($10/states_population[ 8]*scaling_fac):(  9):($10>0?sprintf("{/*0.85 %.1f}", $10/states_population[ 8]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($11/states_population[ 9]*scaling_fac):( 10):($11>0?sprintf("{/*0.85 %.1f}", $11/states_population[ 9]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($12/states_population[10]*scaling_fac):( 11):($12>0?sprintf("{/*0.85 %.1f}", $12/states_population[10]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($13/states_population[11]*scaling_fac):( 12):($13>0?sprintf("{/*0.85 %.1f}", $13/states_population[11]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($14/states_population[12]*scaling_fac):( 13):($14>0?sprintf("{/*0.85 %.1f}", $14/states_population[12]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($15/states_population[13]*scaling_fac):( 14):($15>0?sprintf("{/*0.85 %.1f}", $15/states_population[13]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($16/states_population[14]*scaling_fac):( 15):($16>0?sprintf("{/*0.85 %.1f}", $16/states_population[14]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($17/states_population[15]*scaling_fac):( 16):($17>0?sprintf("{/*0.85 %.1f}", $17/states_population[15]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($18/states_population[16]*scaling_fac):( 17):($18>0?sprintf("{/*0.85 %.1f}", $18/states_population[16]*scaling_fac):"") with labels left offset 0.7, 0.1 notitle

