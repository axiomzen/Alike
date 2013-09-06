Benchmark = require('benchmark')
Table = require('cli-table');

helper = require './helper'
nearestNeighbor = require '../lib/main'
log = console.log.bind console
t1 = new Date()

log ''
log "creating sets..."

log "  100 - a regular case when ordering a search .."
set100x5 = helper.createSamples(100,5)
set100x10 = helper.createSamples(100,10)
set100x100 = helper.createSamples(100,100)

log "  10k - a case of a relative large set / store .."
set10000x5 = helper.createSamples(10000,5)
set10000x10 = helper.createSamples(10000,10)
set10000x100 = helper.createSamples(10000,100)

log "  1kk - a pretty large set .."
# set1000000x5 = helper.createSamples(1000000,5)
set1000000x10 = helper.createSamples(1000000,10)
# set1000000x100 = helper.createSamples(1000000,100)

t2 = new Date()
log "  created sets in #{t2 - t1}ms"

log ''
log 'running suite...'

run = (cb) ->
  suite = new Benchmark.Suite

  ratesVector = []
  baseRate = null

  table = new Table({
    head: ['rows', 'dimension', "exec time", 'problem increase', 'time increase' ]
    # colWidths: [150, 100, 100, 200, 200 ]
  })

  suite
   .add("100 x 5", ->
    nearestNeighbor(set100x5[0], set100x5 )
  ).add("100 x 10", ->
    nearestNeighbor(set100x10[0], set100x10 )
  ).add("100 x 100", ->
    nearestNeighbor(set100x100[0], set100x100 )

  ).add("10000 x 5", ->
    nearestNeighbor(set10000x5[0], set10000x5 )
  ).add("10000 x 10", ->
    nearestNeighbor(set10000x10[0], set10000x10 )
  ).add("10000 x 100", ->
    nearestNeighbor(set10000x100[0], set10000x100 )

  # ).add("1000000 x 10", ->
  #   nearestNeighbor(set1000000x10[0], set1000000x10 )

  ).on("cycle", (e) ->
    # default #log e.target.toString()
    name = e.target.name
    stats = e.target.stats
    length = parseInt(name.split(' x ')[0])
    dimension = parseInt(name.split(' x ')[1])
    rateVector = [stats.mean, (length*dimension)]
    ratesVector.push rateVector
    comparison = ""
    if baseRate
      timeGrowth = (rateVector[0] / baseRate[0]).toFixed(1) + 'x'
      problemGrowth = (rateVector[1] / baseRate[1]).toFixed(1) + 'x'
      comparison = " - problem grew by #{problemGrowth} time by #{timeGrowth}"
    else
      baseRate = rateVector
      timeGrowth = "1.0x"
      problemGrowth = "1.0x"
      comparison = " - problem base #{problemGrowth} time base #{timeGrowth}"
    log "  #{name} execution time: #{stats.mean.toFixed(3)}s (#{e.target.hz.toFixed(1)} ops/s) #{comparison}" # ±#{stats.mean.toFixed(2)}% (seems irrelevant)
    table.push [length, dimension, stats.mean.toFixed(3), problemGrowth, timeGrowth ]
  ).on("complete", ->
    log table.toString()
    t3 = new Date()
    log "  all done! #{parseInt((t3 - t1)/1000)}s"
  ).run {async: false}

run()