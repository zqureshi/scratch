#!/usr/bin/env bash
# Script to poll computers in labs at Bahen and report 
# logged-in users
#
# Zeeshan Qureshi

cdf_login='g0zee'

for lab in 2210:28 2220:24 2240:12 3175:18 3185:24 3195:18
do
  for station in $(eval echo "{1..${lab##*:}}")
  do
    command="
    printf -v machine \"b%s-%#02d\" ${lab%:*} ${station};
    output=\$(ssh -qq ${cdf_login}@b${lab%:*}-${station}.cdf.toronto.edu users);
    ssh_exit_code=\$?;
    if [ \"\${ssh_exit_code}\" -eq \"0\" ];
    then
      echo \"\${machine}: \${output}\";
    else
      echo \"\${machine}: down..\";
    fi
    "
    eval ${command} &
  done
done
