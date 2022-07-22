#!/bin/bash

for file in plot_*.gnuplot ; do
	gnuplot $file > /dev/null
done
