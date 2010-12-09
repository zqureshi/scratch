#!/usr/bin/env bash
# Script to poll computers in labs at Bahen and report 
# logged-in users
#
# Zeeshan Qureshi

cdf_login='g0zee'

for lab in 2210:28 2220:24 2240:12 3175:18 3185:24 3195:18
do
  for station in $(eval echo "{01..${lab##*:}}")
  do
    # Echo machine name
    echo -n "b${lab%:*}-${station}: "

    # Get logged-in users
    output=$(ssh -qq ${cdf_login}@b${lab%:*}-${station}.cdf.toronto.edu users)
    ssh_exit_code=$?

    # If exited successfully, display users
    if [ "$ssh_exit_code" -eq "0" ]
    then
      echo "${output}"
    else
      echo "down.."
    fi

  done
done
