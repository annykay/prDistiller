#!/bin/bash
echo $1

cd $2
gunzip *.gz
EXP1="s4114_1"
EXP2="s4114_2"
EXP3="X44"

SAMP1=$EXP1".lane1."$1".0.pairsam"
SAMP2=$EXP2".lane1."$1".0.pairsam"
SAMP3=$EXP3".lane1."$1".0.pairsam"

OUT1u1=$EXP1"."$1".u1.not.pairsam"
OUT1u2=$EXP1"."$1".u2.not.pairsam"
OUT1uu1=$EXP1"."$1".uu1.not.pairsam"
OUT1uu2=$EXP1"."$1".uu2.not.pairsam"

OUT2u1=$EXP2"."$1".u1.not.pairsam"
OUT2u2=$EXP2"."$1".u2.not.pairsam"
OUT2uu1=$EXP2"."$1".uu1.not.pairsam"
OUT2uu2=$EXP2"."$1".uu2.not.pairsam"

OUT3u1=$EXP3"."$1".u1.not.pairsam"
OUT3u2=$EXP3"."$1".u2.not.pairsam"
OUT3uu1=$EXP3"."$1".uu1.not.pairsam"
OUT3uu2=$EXP3"."$1".uu2.not.pairsam"


grep u[UNnMmRr]  $SAMP1 | grep -v \# | cut -f 2,6,11,13 > $OUT1u1
grep [UNnMmRr]u  $SAMP1 | grep -v \# | cut -f 4,7,12,14 > $OUT1u2

grep uu  $SAMP1 | grep -v \# | cut -f 2,6,11,13 > $OUT1uu1
grep uu  $SAMP1 | grep -v \# | cut -f 4,7,12,14 > $OUT1uu2

grep u[UNnMmRr]  $SAMP2 | grep -v \# | cut -f 2,6,11,13 > $OUT2u1
grep [UNnMmRr]u  $SAMP2 | grep -v \# | cut -f 4,7,12,14 > $OUT2u2

grep uu  $SAMP2 | grep -v \# | cut -f 2,6,11,13 > $OUT2uu1
grep uu $SAMP2 | grep -v \# | cut -f 4,7,12,14 > $OUT2uu2

grep u[UNnMmRr]  $SAMP3 | grep -v \# | cut -f 2,6,11,13 > $OUT3u1
grep [UNnMmRr]u  $SAMP3 | grep -v \# | cut -f 4,7,12,14 > $OUT3u2

grep uu  $SAMP3 | grep -v \# | cut -f 2,6,11,13 > $OUT3uu1
grep uu $SAMP3 | grep -v \# | cut -f 4,7,12,14 > $OUT3uu2

mkdir chimers 
cat $OUT1u1 $OUT1u2 $OUT1uu1 $OUT1uu2 $OUT2u1 $OUT2u2 $OUT2uu1 $OUT2uu2 $OUT3u1 $OUT3u2 $OUT3uu1 $OUT3uu2 > chimers/chimers.bed

grep U[uNnMmRr]  $SAMP1 | grep -v \# | cut -f 2,6,11,13 > $OUT1u1
grep [uNnMmRr]U  $SAMP1 | grep -v \# | cut -f 4,7,12,14 > $OUT1u2

grep UU  $SAMP1 | grep -v \# | cut -f 2,6,11,13 > $OUT1uu1
grep UU  $SAMP1 | grep -v \# | cut -f 4,7,12,14 > $OUT1uu2

grep U[uNnMmRr]  $SAMP2 | grep -v \# | cut -f 2,6,11,13 > $OUT2u1
grep [uNnMmRr]U  $SAMP2 | grep -v \# | cut -f 4,7,12,14 > $OUT2u2

grep UU  $SAMP2 | grep -v \# | cut -f 2,6,11,13 > $OUT2uu1
grep UU  $SAMP2 | grep -v \# | cut -f 4,7,12,14 > $OUT2uu2

grep U[uNnMmRr]  $SAMP3 | grep -v \# | cut -f 2,6,11,13 > $OUT3u1
grep [uNnMmRr]U  $SAMP3 | grep -v \# | cut -f 4,7,12,14 > $OUT3u2

grep UU  $SAMP3  | grep -v \# | cut -f 2,6,11,13 > $OUT3uu1
grep UU  $SAMP3  | grep -v \# | cut -f 4,7,12,14 > $OUT3uu2

mkdir unique 
cat $OUT1u1 $OUT1u2 $OUT1uu1 $OUT1uu2 $OUT2u1 $OUT2u2 $OUT2uu1 $OUT2uu2 $OUT3u1 $OUT3u2 $OUT3uu1 $OUT3uu2 > unique/unique.bed

rm *.not.pairsam

mkdir coverages

awk '{print $1"\t"$4"\t"$4}' chimers/chimers.bed > chimers/chimers3.bed
bedtools coverage -a chimers/chimers3.bed -b ../MBoI25.bed > coverages/chimers3_inters.cov
awk '{print $1"\t"$4"\t"$4}' unique/unique.bed > unique/unique3.bed
bedtools coverage -a unique/unique3.bed -b ../MBoI25.bed > coverages/unique3_inters.cov
