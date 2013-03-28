should = require 'should'
nearestNeighbor = require '../lib/main'

describe 'K Nearest Neighbor', ->
  describe 'with basic wine testCase', ->
    testCase = require './test_case_simple'
    it 'should return the nearest neighbor', ->
      nearestNeighbor(testCase.tasteProfile1, testCase.wineList)[0].label.should.eql('C')
      nearestNeighbor(testCase.tasteProfile2, testCase.wineList)[0].label.should.eql('E')
      nearestNeighbor(testCase.tasteProfile3, testCase.wineList)[0].label.should.eql('J')
    it 'should return 5 nearest neighbors, sorted by distance'
    it 'should return all of Y sorted by distance if Y.length < 5'