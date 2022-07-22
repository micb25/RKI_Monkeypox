load "template.gnuplot"

set output '../plots_de/plot_age_groups.png'

# x-axis setup
set xtics( \
  "00-04"  3,\
  "05-09"  4,\
  "10-14"  5,\
  "15-19"  6,\
  "20-24"  7,\
  "25-29"  8,\
  "30-34"  9,\
  "35-39" 10,\
  "40-44" 11,\
  "45-49" 12,\
  "50-54" 13,\
  "55-59" 14,\
  "60-64" 15,\
  "65-69" 16,\
  "70-74" 17,\
  "75-79" 18,\
  "80+"   19 \
)
set xrange [2.5:19.5]
set xtics offset 0, -1.7

# y-axis setup
set yrange [0: 10 < *]
unset ylabel

unset key

set offsets graph 0.001, graph 0.001, graph 0.30, 0.00

set boxwidth 0.50
set style fill solid 1.00

##################################### German

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Altersverteilung der Affenpockenfälle in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 sprintf("{/*0.75 (Datenquelle: SurvStat\\@RKI 2.0, https://survstat.rki.de; Datenstand: %s)}", last_update_survstat) center textcolor ls 0
set xlabel "Altersgruppe (in Jahren)" offset 0, -0.5

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_age_groups.csv" using (3):($3) with boxes ls 1 notitle, \
  "" using ( 4):( $4) with boxes ls 1 notitle, \
  "" using ( 5):( $5) with boxes ls 1 notitle, \
  "" using ( 6):( $6) with boxes ls 1 notitle, \
  "" using ( 7):( $7) with boxes ls 1 notitle, \
  "" using ( 8):( $8) with boxes ls 1 notitle, \
  "" using ( 9):( $9) with boxes ls 1 notitle, \
  "" using (10):($10) with boxes ls 1 notitle, \
  "" using (11):($11) with boxes ls 1 notitle, \
  "" using (12):($12) with boxes ls 1 notitle, \
  "" using (13):($13) with boxes ls 1 notitle, \
  "" using (14):($14) with boxes ls 1 notitle, \
  "" using (15):($15) with boxes ls 1 notitle, \
  "" using (16):($16) with boxes ls 1 notitle, \
  "" using (17):($17) with boxes ls 1 notitle, \
  "" using (18):($18) with boxes ls 1 notitle, \
  "" using (19):($19) with boxes ls 1 notitle, \
  \
  "" using ( 3):( $3):( $3>0?sprintf("{/*0.85 %.0f}",  $3):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 4):( $4):( $4>0?sprintf("{/*0.85 %.0f}",  $4):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 5):( $5):( $5>0?sprintf("{/*0.85 %.0f}",  $5):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 6):( $6):( $6>0?sprintf("{/*0.85 %.0f}",  $6):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 7):( $7):( $7>0?sprintf("{/*0.85 %.0f}",  $7):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 8):( $8):( $8>0?sprintf("{/*0.85 %.0f}",  $8):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 9):( $9):( $9>0?sprintf("{/*0.85 %.0f}",  $9):"") with labels center offset 0, 0.7 notitle, \
  "" using (10):($10):($10>0?sprintf("{/*0.85 %.0f}", $10):"") with labels center offset 0, 0.7 notitle, \
  "" using (11):($11):($11>0?sprintf("{/*0.85 %.0f}", $11):"") with labels center offset 0, 0.7 notitle, \
  "" using (12):($12):($12>0?sprintf("{/*0.85 %.0f}", $12):"") with labels center offset 0, 0.7 notitle, \
  "" using (13):($13):($13>0?sprintf("{/*0.85 %.0f}", $13):"") with labels center offset 0, 0.7 notitle, \
  "" using (14):($14):($14>0?sprintf("{/*0.85 %.0f}", $14):"") with labels center offset 0, 0.7 notitle, \
  "" using (15):($15):($15>0?sprintf("{/*0.85 %.0f}", $15):"") with labels center offset 0, 0.7 notitle, \
  "" using (16):($16):($16>0?sprintf("{/*0.85 %.0f}", $16):"") with labels center offset 0, 0.7 notitle, \
  "" using (17):($17):($17>0?sprintf("{/*0.85 %.0f}", $17):"") with labels center offset 0, 0.7 notitle, \
  "" using (18):($18):($18>0?sprintf("{/*0.85 %.0f}", $18):"") with labels center offset 0, 0.7 notitle, \
  "" using (19):($19):($19>0?sprintf("{/*0.85 %.0f}", $19):"") with labels center offset 0, 0.7 notitle  

##################################### English

set output '../plots_en/plot_age_groups.png'

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Age distribution of monkeypox cases in Germany}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 sprintf("{/*0.75 (data source: SurvStat\\@RKI 2.0, https://survstat.rki.de; last update: %s)}", last_update_survstat) center textcolor ls 0
set xlabel "age group (in years)" offset 0, -0.5

plot \
  "< (tail -n1) < ../data/RKI_Monkeypox_processed_age_groups.csv" using (3):($3) with boxes ls 1 notitle, \
  "" using ( 4):( $4) with boxes ls 1 notitle, \
  "" using ( 5):( $5) with boxes ls 1 notitle, \
  "" using ( 6):( $6) with boxes ls 1 notitle, \
  "" using ( 7):( $7) with boxes ls 1 notitle, \
  "" using ( 8):( $8) with boxes ls 1 notitle, \
  "" using ( 9):( $9) with boxes ls 1 notitle, \
  "" using (10):($10) with boxes ls 1 notitle, \
  "" using (11):($11) with boxes ls 1 notitle, \
  "" using (12):($12) with boxes ls 1 notitle, \
  "" using (13):($13) with boxes ls 1 notitle, \
  "" using (14):($14) with boxes ls 1 notitle, \
  "" using (15):($15) with boxes ls 1 notitle, \
  "" using (16):($16) with boxes ls 1 notitle, \
  "" using (17):($17) with boxes ls 1 notitle, \
  "" using (18):($18) with boxes ls 1 notitle, \
  "" using (19):($19) with boxes ls 1 notitle, \
  \
  "" using ( 3):( $3):( $3>0?sprintf("{/*0.85 %.0f}",  $3):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 4):( $4):( $4>0?sprintf("{/*0.85 %.0f}",  $4):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 5):( $5):( $5>0?sprintf("{/*0.85 %.0f}",  $5):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 6):( $6):( $6>0?sprintf("{/*0.85 %.0f}",  $6):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 7):( $7):( $7>0?sprintf("{/*0.85 %.0f}",  $7):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 8):( $8):( $8>0?sprintf("{/*0.85 %.0f}",  $8):"") with labels center offset 0, 0.7 notitle, \
  "" using ( 9):( $9):( $9>0?sprintf("{/*0.85 %.0f}",  $9):"") with labels center offset 0, 0.7 notitle, \
  "" using (10):($10):($10>0?sprintf("{/*0.85 %.0f}", $10):"") with labels center offset 0, 0.7 notitle, \
  "" using (11):($11):($11>0?sprintf("{/*0.85 %.0f}", $11):"") with labels center offset 0, 0.7 notitle, \
  "" using (12):($12):($12>0?sprintf("{/*0.85 %.0f}", $12):"") with labels center offset 0, 0.7 notitle, \
  "" using (13):($13):($13>0?sprintf("{/*0.85 %.0f}", $13):"") with labels center offset 0, 0.7 notitle, \
  "" using (14):($14):($14>0?sprintf("{/*0.85 %.0f}", $14):"") with labels center offset 0, 0.7 notitle, \
  "" using (15):($15):($15>0?sprintf("{/*0.85 %.0f}", $15):"") with labels center offset 0, 0.7 notitle, \
  "" using (16):($16):($16>0?sprintf("{/*0.85 %.0f}", $16):"") with labels center offset 0, 0.7 notitle, \
  "" using (17):($17):($17>0?sprintf("{/*0.85 %.0f}", $17):"") with labels center offset 0, 0.7 notitle, \
  "" using (18):($18):($18>0?sprintf("{/*0.85 %.0f}", $18):"") with labels center offset 0, 0.7 notitle, \
  "" using (19):($19):($19>0?sprintf("{/*0.85 %.0f}", $19):"") with labels center offset 0, 0.7 notitle

