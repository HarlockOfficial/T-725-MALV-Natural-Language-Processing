#!/bin/bash

cat shakes.txt | sed  "s/\(\b[A-Za-z]*\)ed\(\b\)/\1\2/g" > shakes_no_ed.txt 

