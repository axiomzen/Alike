should = require 'should'
knn = require '../lib/main'

describe 'K Nearest Neighbor', ->
  getLabels = (results) ->
    results.map (r) ->
      r.label
  describe 'with basic testCase', ->
    testCase = require './test_case_simple'
    objects = testCase.objects
    profile1 = testCase.subject1
    profile2 = testCase.subject2
    profile3 = testCase.subject3
    options = k: 3

    console.log '       --- TEST CASE ---'
    console.log testCase.chart

    it 'should return the nearest neighbor', ->
      knn(profile1, objects)[0].label.should.eql('C')
      knn(profile2, objects)[0].label.should.eql('E')
      knn(profile3, objects)[0].label.should.eql('J')
    it 'should return 3 nearest neighbors, sorted by distance', ->
      getLabels(knn(profile1, objects, options)).should.eql(['C', 'H', 'A'])
      getLabels(knn(profile2, objects, options)).should.eql(['E', 'F', 'A']) #D,G,H tie
      getLabels(knn(profile3, objects, options)).should.eql(['J', 'L', 'G'])
    it 'should return all of Y sorted by distance if Y.length < 3', ->
      getLabels(knn(profile1, objects.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(knn(profile2, objects.slice(0, 2), options)).should.eql(['A', 'B'])
      getLabels(knn(profile3, objects.slice(0, 2), options)).should.eql(['B', 'A'])

  describe 'with testCase that requires standardized Euclidean distance', ->
    testCase = require './test_case_standardize'
    objects = testCase.objects
    profile1 = testCase.subject1
    profile2 = testCase.subject2
    profile3 = testCase.subject3
    options = k: 3, standardize: true

    it 'should return the nearest neighbor', ->
      knn(profile1, objects, options)[0].label.should.eql('C')
      knn(profile2, objects, options)[0].label.should.eql('E')
      knn(profile3, objects, options)[0].label.should.eql('J')
    it 'should return 3 nearest neighbors, sorted by distance', ->
      getLabels(knn(profile1, objects, options)).should.eql(['C', 'H', 'A'])
      getLabels(knn(profile2, objects, options)).should.eql(['E', 'F', 'A'])
      getLabels(knn(profile3, objects, options)).should.eql(['J', 'L', 'G'])

    describe 'and weights per attribute', ->
      it 'should minimize category with 0.01 weight', ->
        options = k:3, standardize: true, weights: { attr_1: 0.01, attr_2: 0.99 }
        getLabels(knn(profile1, objects, options)).should.eql(['K', 'C', 'H'])
        getLabels(knn(profile2, objects, options)).should.eql(['E', 'A', 'I'])
        getLabels(knn(profile3, objects, options)).should.eql(['B', 'J', 'L'])
