load "template.gnuplot"

set output '../plots_de/plot_sum_cases.png'

# x-axis setup
unset xlabel
set xdata time
set format x "%d.%m.%y"

# y-axis setup
unset ylabel

# key
# set key at graph 0.98, graph 0.03 right bottom invert spacing 1.3 box ls 1 lc "#000000"
unset key

set offsets graph 0.01, graph 0.01, graph 0.30, 0.00

##################################### German

date_cmd = sprintf("%s", "`awk -F, '{print ""($1)}' ../data/RKI_Monkeypox.csv | tail -n 1 | xargs date +"%Y-%m-%d" -d`")
update_str = "letztes Update: " . date_cmd . "; Quelle: Corona-Warn-App"

set label 1 at graph 0.50, 0.95 "{/Linux-Libertine-O-Bold*1.2 Summe der gemeldeten Affenpockenfälle in Deutschland}" center textcolor ls 0
set label 2 at graph 0.50, 0.90 "{/*0.75 (Quelle: Robert Koch-Institut)}" center textcolor ls 0

plot  \
  "../data/RKI_Monkeypox.csv" using 1:2 with linespoints ls 1 notitle, \
  \
  "../data/RKI_Monkeypox.csv" using 1:2:2 with labels point ls 2 ps 0.0 right offset char 0.0, 0.75 tc "#0000FF" notitle

