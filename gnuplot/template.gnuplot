set terminal pngcairo enhanced background rgb "#ffffff" truecolor font "Linux Libertine O,18" size 1200, 800 dl 2.0 
set encoding utf8
set minussign

set fit quiet logfile '/dev/null'
set fit errorvariables

# margins
set lmargin 10.00
set rmargin 1.25
set tmargin 0.55
set bmargin 4.50

# colors and plot style
set style line  1 lc rgb '#0000FF' lt 1 lw 1 pt 7 ps 2.00
set style line  2 lc rgb '#FF0000' lt 1 lw 1 pt 7 ps 2.00
set style line  3 lc rgb '#00A000' lt 1 lw 1 pt 7 ps 2.00
set style line  4 lc rgb '#000080' lt 1 lw 1 pt 7 ps 2.00

# grid
#set grid xtics ls 21 lc rgb '#aaaaaa'
set grid ytics ls 21 lc rgb '#aaaaaa'

# misc
set samples 30
set style increment default
set style fill transparent solid 0.20 border

# axes
set yrange [ 0: * ]

set xtics 7*86400 out nomirror rotate by 90 offset 0, -3.0 scale 1.0
set mxtics 7

set format y '%5.0f'
set ytics out nomirror scale 1.2
set mytics 2

set key opaque
set border back

set object 1 rectangle from screen -0.1,-0.1 to screen 1.1,1.1 fc rgb "#ffffff" behind

# filter negative values
filter_neg(x)=(x>=0)?(x):(1/0)

set timefmt "%Y-%m-%d"
set datafile separator ","

