#!/bin/bash

# Output file name
OUTPUT=cidrlist.txt
FING=fing.txt
FING2=fing2.txt
# Clear file
: > $OUTPUT

# 10. subnet
SUB=10
echo "Generating $SUB list"
for b in $(seq 0 255)
    do
        for c in $(seq 255)
            do
             echo $SUB.$b"."$c."0/24" >> $OUTPUT
        done
    done

# 172. subnet
SUB=172
echo "Generating $SUB list"
for b in $(seq 16 31)
    do
        for c in $(seq 255)
            do
             echo $SUB.$b"."$c."0/24" >> $OUTPUT
        done
    done

# 192. subnet
SUB=192
echo "Generating $SUB list"
for b in $(seq 168 168)
    do
        for c in $(seq 255)
            do
             echo $SUB.$b"."$c."0/24" >> $OUTPUT
        done
    done

echo "Subnet lists saved to $OUTPUT"
#


# Find the number
read -p "What number do you want in your subnet? " NUMBER
echo "Here are some subnets that have your number:" > $FING
grep $NUMBER $OUTPUT >> $FING
FINGLENGTH=$(wc -l $FING)
echo "Number of entries"
echo $FINGLENGTH
read -p "Enter another number: " NUMBER
grep $NUMBER $FING > $FING2

less $FING2

