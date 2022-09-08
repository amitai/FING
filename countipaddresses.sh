#!/bin/bash

CIDRLIST=cidrlist.txt

function echosubnets {
        for c in $(seq 255)
             do
             echo $SUB.$b"."$c."0/24" >> $CIDRLIST
        done
    }

function build_cidr_list {
# Clear file
echo "Building CIDR list.  Please wait."
: > $CIDRLIST

# 10. subnet
SUB=10
echo "Generating $SUB list"
for b in $(seq 0 255)
 do
  echosubnets
 done


# 172. subnet
SUB=172
echo "Generating $SUB list"
for b in $(seq 16 31)
 do
  echosubnets
 done

# 192. subnet
SUB=192
echo "Generating $SUB list"
for b in $(seq 168 168)
 do
  echosubnets
 done


echo "Subnet lists saved to $CIDRLIST"
wc -l $CIDRLIST

}

# Checks if CIDR list exists.   If not, build it.
if test -f "$CIDRLIST"; then
    echo "$CIDRLIST exists."
    wc -l $CIDRLIST
else build_cidr_list
fi

# Checks if gawk is installed.  If not, the user will have to install it.
if ! command -v gawk &> /dev/null
then
    echo "You need gawk for this script to work."
    exit
fi

# Get user input - what number do you want in your subnet?
read -p "What number do you want in your subnet? " NUMBER

# Reset the output file
mkdir -p output
FING=output/$NUMBER-$(date +%F_%H%M%S).txt

# Find he number in the CIDR list
cat $CIDRLIST | awk -v n="$NUMBER" 'BEGIN { split(n,a,""); for (c in a) { r=r a[c] "\\.?" } } $0 ~ r' > $FING

# How many hits did we get?
FINGLENGTH=$(cat $FING | wc -l)
echo "Number of subnets with $NUMBER in it: $FINGLENGTH"

# Show the user five random lines from the file
printf "\n\nHere are some random subnets you can use right now!\n"
shuf -n 5 $FING


# Let user view all results
echo "Do you want to see all results?
 (v)im
 (l)ess
 (c)at
e(x)it"
read -n1 GOGO
case $GOGO in
    v)
        vim $FING
        ;;
    l) 
        less $FING
        ;;
    c)
        cat $FING
        ;;
    x)
        echo "cya, open $FING later."
        exit
        ;;
    *)
        echo "whatever"
        exit
        ;;
esac
