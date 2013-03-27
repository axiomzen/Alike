should = require 'should'
nearestNeighbor = require '../lib/main'

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
        nearestNeighbor {a:1}, [{a: 2}]
      ).should.not.throwError()
      (->
        nearestNeighbor {a:1}, [{a:2},{b:3}], {option: false}
      ).should.not.throwError()

    it 'should accept objects only', ->
      (->
        nearestNeighbor 1, 2
      ).should.throwError 'Expecting object arguments'

    it 'should not accept null as objects', ->
      (->
        nearestNeighbor null, null
      ).should.throwError 'Expecting object arguments'

    it 'should only accept array as second argument', ->
      (->
        nearestNeighbor {a:1}, {a:2}
      ).should.throwError 'Expecting an array as second argument'

  describe 'for simple cases', ->
    it 'should return an empty object/array if no Y', ->
      nearestNeighbor({a:1}, []).should.eql([])
    it 'should return nearest neighbor with single dimension', ->
      nearestNeighbor({a:1}, [{a:1}, {a:2}]).should.eql([{a:1}])
    it 'should return 2 nearest neighbors (in order) with single dimension', ->
      nearestNeighbor({a:1}, [{a:1}, {a:3}, {a:0}], {k:2}).should.eql([{a:1}, {a:0}])

  describe 'with basic wine testCase', ->
    beforeEach ->
      testCase = require './test_case'
    it 'should return the nearest neighbor'
    it 'should return 5 nearest neighbors, sorted by distance'
    it 'should return all of Y sorted by distance if Y.length < 5'