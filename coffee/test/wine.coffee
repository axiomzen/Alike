should = require 'should'
nearestNeighbor = require '../lib/main'

describe 'K Nearest Neighbor', ->
  describe 'with basic wine testCase', ->
    testCase = require './test_case_simple'
    wineList = testCase.wineList
    profile1 = testCase.tasteProfile1
    profile2 = testCase.tasteProfile2
    profile3 = testCase.tasteProfile3
    options = k: 3
    getLabels = (results) ->
      results.map (r) ->
        r.label

    it 'should return the nearest neighbor', ->
      nearestNeighbor(profile1, wineList)[0].label.should.eql('C')
      nearestNeighbor(profile2, wineList)[0].label.should.eql('E')
      nearestNeighbor(profile3, wineList)[0].label.should.eql('J')
    it 'should return 3 nearest neighbors, sorted by distance', ->
      getLabels(nearestNeighbor(profile1, wineList, options)).should.eql(['C', 'H', 'A'])
      getLabels(nearestNeighbor(profile2, wineList, options)).should.eql(['E', 'F', 'A']) #D,G,H tie
      getLabels(nearestNeighbor(profile3, wineList, options)).should.eql(['J', 'L', 'G'])
    it 'should return all of Y sorted by distance if Y.length < 3', ->
      getLabels(nearestNeighbor(profile1, wineList.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(nearestNeighbor(profile2, wineList.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(nearestNeighbor(profile3, wineList.slice(0, 2), options)).should.eql(['B', 'A'])

  describe.skip 'with testCase that requires standardized Euclidean distance', ->
    testCase = require './test_case_standardize'
    wineList = testCase.wineList
    profile1 = testCase.tasteProfile1
    profile2 = testCase.tasteProfile2
    profile3 = testCase.tasteProfile3
    options = k: 3, standardize: true
    getLabels = (results) ->
      results.map (r) ->
        r.label

    it 'should return the nearest neighbor', ->
      nearestNeighbor(profile1, wineList)[0].label.should.eql('C')
      nearestNeighbor(profile2, wineList)[0].label.should.eql('E')
      nearestNeighbor(profile3, wineList)[0].label.should.eql('J')
    it 'should return 3 nearest neighbors, sorted by distance', ->
      getLabels(nearestNeighbor(profile1, wineList, options)).should.eql(['C', 'H', 'A'])
      getLabels(nearestNeighbor(profile2, wineList, options)).should.eql(['E', 'F', 'A']) #D,G,H tie
      getLabels(nearestNeighbor(profile3, wineList, options)).should.eql(['J', 'L', 'G'])
    it 'should return all of Y sorted by distance if Y.length < 3', ->
      getLabels(nearestNeighbor(profile1, wineList.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(nearestNeighbor(profile2, wineList.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(nearestNeighbor(profile3, wineList.slice(0, 2), options)).should.eql(['B', 'A'])
