
uuid = require 'node-uuid'

set = []
for i in [0..1000]
  set.push uuid.v1()

exports.createSamples = (howMany, dimension = 5, range = 100) ->
  a = []
  for i in [0..howMany]
    obj = {}
    for d in [0..dimension]
      value = Math.random()*range
      obj[set[d]] = if Math.random() < 0.5 then value else value * -1
    a.push obj
  a