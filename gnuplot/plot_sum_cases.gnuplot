load "template.gnuplot"

set output '../plots_de/plot_sum_cases.png'

# x-axis setup
unset xlabel
set xdata time
set format x "%d.%m.%Y"

# key
unset key

# y-axis setup
unset ylabel

set offsets graph 0.01, graph 0.01, graph 0.30, 0.00

##################################### German

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Summe der gemeldeten Affenpockenfälle in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (Quelle: Robert Koch-Institut)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox.csv" using 1:2 with linespoints ls 1 notitle, \
  \
  "< (tail -n1) < ../data/RKI_Monkeypox.csv" using 1:2:2 with labels point ls 2 ps 0.0 right offset char 0.0, 0.75 tc "#0000FF" notitle

##################################### English

set output '../plots_en/plot_sum_cases.png'
set format x "%Y-%m-%d"

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Sum of reported monkeypox cases in Germany}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (source: Robert Koch Institute)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox.csv" using 1:2 with linespoints ls 1 notitle, \
  \
  "< (tail -n1) <  ../data/RKI_Monkeypox.csv" using 1:2:2 with labels point ls 2 ps 0.0 right offset char 0.0, 0.75 tc "#0000FF" notitle
