load "template.gnuplot"

set output '../plots_de/plot_sum_cases_log.png'

# x-axis setup
unset xlabel
set xdata time
set format x "%d.%m.%Y"

# key
unset key

# y-axis setup
unset ylabel
set logscale y
set mytics 10
set yrange[1:*]

set offsets graph 0.01, graph 0.01, graph 0.25, 0.00

##################################### German

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Summe der gemeldeten Affenpockenfälle in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (logarithmische Darstellung; Quelle: Robert Koch-Institut)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:2 with linespoints ls 1 notitle

##################################### English

set output '../plots_en/plot_sum_cases_log.png'
set format x "%Y-%m-%d"

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Sum of reported monkeypox cases in Germany}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (logarithmic graph; source: Robert Koch Institute)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox_processed.csv" using 1:2 with linespoints ls 1 notitle
