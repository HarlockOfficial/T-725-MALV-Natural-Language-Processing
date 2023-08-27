#!/bin/bash

# case sensitive version
grep -o "Macbeth" ./shakes.txt | wc -l
# result 83

#case insensitive version
grep -o -i "Macbeth" ./shakes.txt | wc -l
# result 291

