#!/bin/bash

# Part 1: Create eng.tok with 1 token per line using awk
awk '{
    for (i=1; i<=NF; i+=2) {
        if (i+1 <= NF && $i != "" && $(i+1) != "" && match($(i+1),/[A-Z]{2,4}|[^\w\s]/)) {
            printf "%s\n",$i
        }
    }
}' eng.sent > eng.tok


# Part 2: Create engTri.freq with trigrams and their frequencies
awk '{word_list[NR] = $1}
END{
  for (i=1; i<=NR-2; i++) {
      printf "%s %s %s\n", word_list[i], word_list[i+1], word_list[i+2]
    }
}' eng.tok  | sort -k1,1 -k2,2 -k3,3 | uniq -c | sort -k1,1nr -k2,2 -k3,3 -k4,4 > engTri.freq


# Part 3: How many trigrams and distinct trigrams are there?
echo "Amount of distinct trigrams: $(wc --lines engTri.freq | awk '{print $1}')"
# Amount of distinct trigrams: 166451

echo "Amount of trigrams: $(awk '{sum += $1} END {print sum}' engTri.freq)"
# Amount of trigrams: 204564


# Part 4: Using engTri.freq, Estimate (using Maximum Likelihood Estimation) P(Monday | said on)
awk '
BEGIN {
    sum = 0
    count = 0
    vocabulary = 0
} {
    vocabulary += 1
    if ($2 == "said" && $3 == "on") {
        sum += $1
    }
    if ($2 == "said" && $3 == "on" && $4 == "Monday") {
        count += $1
    }
} END {
    print "With formula P(Monday | said on) = count(said on Monday) / count(said on) = " count/sum
    print "With formula P(Monday | said on) = (count(said on Monday) + 1) / (count(said on) + #Vocabulary)= " (count + 1)/(sum + vocabulary)
}' engTri.freq
# With formula P(Monday | said on) = count(said on Monday) / count(said on) = 0.0956938
# With formula P(Monday | said on) = (count(said on Monday) + 1) / (count(said on) + 1 * #Vocabulary)= 0.000126005
