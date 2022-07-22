load "template.gnuplot"

set output '../plots_de/plot_states.png'

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
set xtics 0, 500, 100000 out nomirror rotate by 0 offset 0, 0 scale 1.0 center
set mxtics 5
set format x '%.0f'

unset key

set offsets graph 0.001, graph 0.15, graph 0.00, graph 0.00

set boxwidth 0.50
set style fill solid 1.00

binwidth = 0.25

##################################### German

set label 1 at screen 0.50, 0.97 "{/Linux-Libertine-O-Bold*1.2 Verteilung der Affenpockenfälle in Deutschland nach Bundesland}" center textcolor ls 0
set label 2 at screen 0.50, 0.93 sprintf("{/*0.75 (Datenquelle: SurvStat\\@RKI 2.0, https://survstat.rki.de; Datenstand: %s)}", last_update_survstat) center textcolor ls 0

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_states.csv" using (0):(2):(0.0):($3):((2)-(binwidth/2.0)):((2)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 3):(0.0):( $4):(( 3)-(binwidth/2.0)):((3)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 4):(0.0):( $5):(( 4)-(binwidth/2.0)):((4)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 5):(0.0):( $6):(( 5)-(binwidth/2.0)):((5)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 6):(0.0):( $7):(( 6)-(binwidth/2.0)):((6)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 7):(0.0):( $8):(( 7)-(binwidth/2.0)):((7)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 8):(0.0):( $9):(( 8)-(binwidth/2.0)):((8)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 9):(0.0):($10):(( 9)-(binwidth/2.0)):((9)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(10):(0.0):($11):((10)-(binwidth/2.0)):((10)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(11):(0.0):($12):((11)-(binwidth/2.0)):((11)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(12):(0.0):($13):((12)-(binwidth/2.0)):((12)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(13):(0.0):($14):((13)-(binwidth/2.0)):((13)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(14):(0.0):($15):((14)-(binwidth/2.0)):((14)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(15):(0.0):($16):((15)-(binwidth/2.0)):((15)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(16):(0.0):($17):((16)-(binwidth/2.0)):((16)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(17):(0.0):($18):((17)-(binwidth/2.0)):((17)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  \
  "" using ( $3):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $4):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $5):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $6):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $7):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $8):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $9):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($10):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($11):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($12):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($13):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($14):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($15):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($16):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($17):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($18):(1) with points ls 1 ps 0.0001 notitle, \
  \
  "" using ( $3):(  2):( $3>0?sprintf("{/*0.85 %.0f}",  $3):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $4):(  3):( $4>0?sprintf("{/*0.85 %.0f}",  $4):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $5):(  4):( $5>0?sprintf("{/*0.85 %.0f}",  $5):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $6):(  5):( $6>0?sprintf("{/*0.85 %.0f}",  $6):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $7):(  6):( $7>0?sprintf("{/*0.85 %.0f}",  $7):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $8):(  7):( $8>0?sprintf("{/*0.85 %.0f}",  $8):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $9):(  8):( $9>0?sprintf("{/*0.85 %.0f}",  $9):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($10):(  9):($10>0?sprintf("{/*0.85 %.0f}", $10):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($11):( 10):($11>0?sprintf("{/*0.85 %.0f}", $11):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($12):( 11):($12>0?sprintf("{/*0.85 %.0f}", $12):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($13):( 12):($13>0?sprintf("{/*0.85 %.0f}", $13):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($14):( 13):($14>0?sprintf("{/*0.85 %.0f}", $14):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($15):( 14):($15>0?sprintf("{/*0.85 %.0f}", $15):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($16):( 15):($16>0?sprintf("{/*0.85 %.0f}", $16):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($17):( 16):($17>0?sprintf("{/*0.85 %.0f}", $17):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($18):( 17):($18>0?sprintf("{/*0.85 %.0f}", $18):"") with labels left offset 0.7, 0.1 notitle
  
##################################### English

set output '../plots_en/plot_states.png'

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

set label 1 at screen 0.50, 0.97 "{/Linux-Libertine-O-Bold*1.2 Distribution of monkeypox cases in Germany per state}" center textcolor ls 0
set label 2 at screen 0.50, 0.93 sprintf("{/*0.75 (data source: SurvStat\\@RKI 2.0, https://survstat.rki.de; last update: %s)}", last_update_survstat) center textcolor ls 0

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_states.csv" using (0):(2):(0.0):($3):((2)-(binwidth/2.0)):((2)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 3):(0.0):( $4):(( 3)-(binwidth/2.0)):((3)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 4):(0.0):( $5):(( 4)-(binwidth/2.0)):((4)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 5):(0.0):( $6):(( 5)-(binwidth/2.0)):((5)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 6):(0.0):( $7):(( 6)-(binwidth/2.0)):((6)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 7):(0.0):( $8):(( 7)-(binwidth/2.0)):((7)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 8):(0.0):( $9):(( 8)-(binwidth/2.0)):((8)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):( 9):(0.0):($10):(( 9)-(binwidth/2.0)):((9)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(10):(0.0):($11):((10)-(binwidth/2.0)):((10)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(11):(0.0):($12):((11)-(binwidth/2.0)):((11)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(12):(0.0):($13):((12)-(binwidth/2.0)):((12)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(13):(0.0):($14):((13)-(binwidth/2.0)):((13)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(14):(0.0):($15):((14)-(binwidth/2.0)):((14)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(15):(0.0):($16):((15)-(binwidth/2.0)):((15)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(16):(0.0):($17):((16)-(binwidth/2.0)):((16)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  "" using (0):(17):(0.0):($18):((17)-(binwidth/2.0)):((17)+(binwidth/2.0)) with boxxyerrorbars ls 1 notitle, \
  \
  "" using ( $3):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $4):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $5):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $6):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $7):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $8):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ( $9):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($10):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($11):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($12):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($13):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($14):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($15):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($16):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($17):(1) with points ls 1 ps 0.0001 notitle, \
  "" using ($18):(1) with points ls 1 ps 0.0001 notitle, \
  \
  "" using ( $3):(  2):( $3>0?sprintf("{/*0.85 %.0f}",  $3):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $4):(  3):( $4>0?sprintf("{/*0.85 %.0f}",  $4):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $5):(  4):( $5>0?sprintf("{/*0.85 %.0f}",  $5):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $6):(  5):( $6>0?sprintf("{/*0.85 %.0f}",  $6):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $7):(  6):( $7>0?sprintf("{/*0.85 %.0f}",  $7):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $8):(  7):( $8>0?sprintf("{/*0.85 %.0f}",  $8):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ( $9):(  8):( $9>0?sprintf("{/*0.85 %.0f}",  $9):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($10):(  9):($10>0?sprintf("{/*0.85 %.0f}", $10):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($11):( 10):($11>0?sprintf("{/*0.85 %.0f}", $11):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($12):( 11):($12>0?sprintf("{/*0.85 %.0f}", $12):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($13):( 12):($13>0?sprintf("{/*0.85 %.0f}", $13):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($14):( 13):($14>0?sprintf("{/*0.85 %.0f}", $14):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($15):( 14):($15>0?sprintf("{/*0.85 %.0f}", $15):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($16):( 15):($16>0?sprintf("{/*0.85 %.0f}", $16):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($17):( 16):($17>0?sprintf("{/*0.85 %.0f}", $17):"") with labels left offset 0.7, 0.1 notitle, \
  "" using ($18):( 17):($18>0?sprintf("{/*0.85 %.0f}", $18):"") with labels left offset 0.7, 0.1 notitle
  
