#!/bin/bash

echo "It's true that he doesn't know I've arrived" | sed "s/'s/ is/g" | sed "s/n't/ not/g" | sed "s/'ve/ have/g"
# result "It is true that he does not know I have arrived"
