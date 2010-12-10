#!/usr/bin/env bash
# Script to poll computers in labs at Bahen and report 
# logged-in users
#
# Zeeshan Qureshi

cdf_login='g0zee'
pid_list=''

function poll_machine {
  # Copy over arguments
  lab=${1}
  station=${2}

  # Generate machine name
  printf -v machine "b%s-%#02d" ${lab%:*} ${station}

  # Poll the machine
  output=$(ssh -qq ${cdf_login}@${machine}.cdf.toronto.edu users)
  ssh_exit_code=${?}

  # If exited successfuly, then print users
  if [ "${ssh_exit_code}" -eq "0" ]
  then
    echo "${machine}: ${output}"
  else
    echo "${machine}: down.."
  fi
}

case "${1:0:1}" in
  l)
    ;;

  p)      
    ;;

  *)
    echo "usage: ${0} {polling mechanism}"
    echo "polling mechanisms: linear, parallel"
    exit
esac

echo $'Starting Lab Check...\n'
for lab in 2210:28 2220:24 2240:12 3175:18 3185:24 3195:18
do
  for station in $(eval echo "{1..${lab##*:}}")
  do
    case "${1:0:1}" in
      l)
        poll_machine ${lab} ${station}
        ;;

      p)      
        poll_machine ${lab} ${station} &
        pid_list+=$!' '
        ;;
    esac
  done
done

wait ${pid_list}
echo $'\nLab Check Done!!'
