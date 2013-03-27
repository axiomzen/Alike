should = require('should')
nearestNeighbor = require('../lib/main')

describe 'K Nearest Neighbor', ->
  describe 'arguments', ->
    it 'should be at least 2', ->
      (->
        nearestNeighbor()
      ).should.throwError 'Expecting at least 2 arguments'
      (->
        nearestNeighbor 1
      ).should.throwError 'Expecting at least 2 arguments'

    it 'should accept 2 or 3', ->
      (->
        nearestNeighbor 1, 2
      ).should.not.throwError()
      (->
        nearestNeighbor 1, 2, 3
      ).should.not.throwError()

    it 'should accept objects only'
    it 'should only accept array as second argument'

  describe 'with K=1', ->
    it 'should return the nearest neighbor with fixed dimensionality'
    it 'should return the nearest neighbor with variable dimensionality'
    it 'should return an empty object/array if no Y'

  describe 'with K=5', ->
    it 'should return 5 nearest neighbors with fixed dimensionality'
    it 'should return 5 nearest neighbor with variable dimensionality'
    it 'should return all of Y sorted by distance if Y.length < 5'
