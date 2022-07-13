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
set style line  2 lc rgb '#FF0000' lt 1 lw 4 pt 7 ps 2.00
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
set xrange [strptime("%Y-%m-%d", "2022-05-19"):*]

set xtics 7*86400 out nomirror rotate by 90 offset 0, -3.5 scale 1.0
set mxtics 7

set format y '%5.0f'
set ytics out nomirror scale 1.2
set mytics 2

set key left at screen 0.12, 0.80 opaque box vertical width 0.5 height 0.5 maxcols 1 spacing 1 
set border back

set object 1 rectangle from screen -0.1,-0.1 to screen 1.1,1.1 fc rgb "#ffffff" behind

# filter negative values
filter_neg(x)=(x>=0)?(x):(1/0)

set timefmt "%Y-%m-%d"
set datafile separator ","

# static data

# population data taken from
# https://www.destatis.de/DE/Themen/Gesellschaft-Umwelt/Bevoelkerung/Bevoelkerungsstand/Tabellen/bevoelkerung-nichtdeutsch-laender.html;jsessionid=1E8FEA66BF8B3DE3DC6DF68A51B153BA.live722?view=main[Print]

NUM_STATES = 16
array states_name_en[NUM_STATES]
array states_name_de[NUM_STATES]
array states_population[NUM_STATES]

states_name_en[1]    = "Baden-Württemberg"
states_name_de[1]    = "Baden-Württemberg"
states_population[1] = 11124642

states_name_en[2]    = "Bavaria"
states_name_de[2]    = "Bayern"
states_population[2] = 13176989

states_name_en[3]    = "Berlin"
states_name_de[3]    = "Berlin"
states_population[3] = 3677472

states_name_en[4]    = "Brandenburg"
states_name_de[4]    = "Brandenburg"
states_population[4] = 2537868

states_name_en[5]    = "Bremen"
states_name_de[5]    = "Bremen"
states_population[5] = 676463

states_name_en[6]    = "Hamburg"
states_name_de[6]    = "Hamburg"
states_population[6] = 1853935

states_name_en[7]    = "Hesse"
states_name_de[7]    = "Hessen"
states_population[7] = 6295017

states_name_en[8]    = "Mecklenburg-Vorpommern"
states_name_de[8]    = "Mecklenburg-Vorpommern"
states_population[8] = 1611160

states_name_en[9]    = "Lower Saxony"
states_name_de[9]    = "Niedersachsen"
states_population[9] = 8027031

states_name_en[10]    = "North Rhine-Westphalia"
states_name_de[10]    = "Nordrhein-Westfalen"
states_population[10] = 17924591

states_name_en[11]    = "Rhineland-Palatinate"
states_name_de[11]    = "Rheinland-Pfalz"
states_population[11] = 4106485

states_name_en[12]    = "Saarland"
states_name_de[12]    = "Saarland"
states_population[12] = 982348

states_name_en[13]    = "Saxony"
states_name_de[13]    = "Sachsen"
states_population[13] = 4043002

states_name_en[14]    = "Saxony-Anhalt"
states_name_de[14]    = "Sachsen-Anhalt"
states_population[14] = 2169253

states_name_en[15]    = "Schleswig-Holstein"
states_name_de[15]    = "Schleswig-Holstein"
states_population[15] = 2922005

states_name_en[16]    = "Thuringia"
states_name_de[16]    = "Thüringen"
states_population[16] = 2108863
