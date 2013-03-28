should = require 'should'
nearestNeighbor = require '../lib/main'

describe 'K Nearest Neighbor', ->
  describe 'with basic wine testCase', ->
    testCase = require './test_case_simple'
    wineList = testCase.wineList
    profile1 = testCase.tasteProfile1
    profile2 = testCase.tasteProfile2
    profile3 = testCase.tasteProfile3
    it 'should return the nearest neighbor', ->
      nearestNeighbor(profile1, wineList)[0].label.should.eql('C')
      nearestNeighbor(profile2, wineList)[0].label.should.eql('E')
      nearestNeighbor(profile3, wineList)[0].label.should.eql('J')
    it 'should return 5 nearest neighbors, sorted by distance'
    it 'should return all of Y sorted by distance if Y.length < 5'