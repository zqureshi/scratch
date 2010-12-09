#!/usr/bin/env bash
# Script to poll computers in labs at Bahen and report 
# logged-in users
#
# Zeeshan Qureshi

cdf_login='g0zee'

for lab in 2210 2220 2240 2270 3175 3185 3195
do
  for station in {01..40}
  do
    echo -n "b${lab}-${station}: "
    echo `ssh ${cdf_login}@b${lab}-${station}.cdf.toronto.edu users`
  done
done
