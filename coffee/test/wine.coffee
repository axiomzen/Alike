should = require 'should'
nearestNeighbor = require '../lib/main'

describe 'K Nearest Neighbor', ->
  describe 'with basic wine testCase', ->
    beforeEach ->
      testCase = require './test_case_simple'
    it 'should return the nearest neighbor'
    it 'should return 5 nearest neighbors, sorted by distance'
    it 'should return all of Y sorted by distance if Y.length < 5'