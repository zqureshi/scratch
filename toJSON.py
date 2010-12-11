#!/usr/bin/env python

import simplejson as json
import pprint as pp

if __name__ == '__main__':
  status = open('lab.status').readlines()[2:-2]

  data = {}
  for line in status:
    tokens = line.strip().split(': ')

    lab = tokens[0]
    data[lab] = {}

    if len(tokens) > 1:
      if tokens[1] == 'down..':
        data[lab]['up'] = False
      else:
        data[lab]['up'] = True
        data[lab]['output'] = tokens[1]
    else:
      data[lab]['up'] = True
      data[lab]['output'] = ''

  print json.dumps(data)
