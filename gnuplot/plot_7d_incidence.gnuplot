load "template.gnuplot"

set output '../plots_de/plot_7d_incidence.png'

# x-axis setup
unset xlabel
set xdata time
set format x "%d.%m.%Y"

# y-axis setup
set format y '%.1f'
unset ylabel

# key
unset key

set boxwidth 0.50*86400
set style fill solid 1.00

set offsets graph 0.001, graph 0.001, graph 0.30, 0.00

##################################### German

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 7-Tage-Inzidenz (pro 1 Mio.) von gemeldeten Affenpockenfällen in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (eigene Berechnung; Datenquelle: Robert Koch-Institut)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:(timecolumn(1) > strptime("%Y-%m-%d", "2022-05-19") ? (10*$7) : 1/0) with lines ls 2 notitle

##################################### English

set output '../plots_en/plot_7d_incidence.png'
set format x "%Y-%m-%d"

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 7-Day incidence (per 1 M) of reported monkeypox cases in Germany}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (own calculation; source: Robert Koch Institute)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:(timecolumn(1) > strptime("%Y-%m-%d", "2022-05-19") ? (10*$7) : 1/0) with lines ls 2 notitle
