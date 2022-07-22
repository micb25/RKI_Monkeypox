load "template.gnuplot"

set output '../plots_de/plot_num_cases_log.png'

# x-axis setup
unset xlabel
set xdata time
set format x "%d.%m.%Y"

# y-axis setup
unset ylabel
set logscale y
set mytics 10
set yrange[1:1000]

set boxwidth 0.50*86400
set style fill solid 1.00

set offsets graph 0.001, graph 0.001, graph 0.30, 0.00

##################################### German

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Neumeldungen von Affenpockenfällen in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 sprintf("{/*0.75 (logarithmische Darstellung; Quelle: Robert Koch-Institut; Datenstand: %s)}", last_update_rki) center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:(timecolumn(1) > strptime("%Y-%m-%d", "2022-05-19") ? $6 : 1/0) with lines ls 2 title "7-Tage-Mittelwert"

##################################### English

set output '../plots_en/plot_num_cases_log.png'
set format x "%Y-%m-%d"

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Newly reported monkeypox cases in Germany}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 sprintf("{/*0.75 (logarithmic graph; source: Robert Koch Institute; last update: %s)}", last_update_rki) center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:(timecolumn(1) > strptime("%Y-%m-%d", "2022-05-19") ? $6 : 1/0) with lines ls 2 title "7-day average"
