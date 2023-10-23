#!/bin/bash

# Function to get prime factors
prime_factors() {
    num=$1
    i=2
    factors=""
    while [ $num -gt 1 ]; do
        while [ $((num % i)) -eq 0 ]; do
            num=$((num / i))
            factors="${factors}${i} x "
        done
        i=$((i + 1))
    done

    # Remove the trailing ' x '
    factors=${factors% x }

    # If factors is empty, then the number is prime
    [ -z "$factors" ] && echo $1 || echo $factors
}

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Please pass in a number as an argument to the script."
else
    prime_factors $1
fi
