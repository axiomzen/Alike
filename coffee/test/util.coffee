should = require 'should'
utils = require '../lib/util'

describe 'Squared Euclidean Distance function', ->
  it 'should calculate correctly for 1 dimension', ->
    utils.distance({ a: 1 }, { a: 5 }).should.eql(16)
  it 'should calculate correctly for 2 dimensions', ->
    utils.distance({ a: 1, b: 3 }, { a: 5, b: 5 }).should.eql(20)
  it 'should calculate correctly for 3 dimensions', ->
    utils.distance({ a: 1, b: 3 , c: -2}, { a: 5, b: 5, c: 2 }).should.eql(36)

describe 'Standard Deviation', ->
  it 'should be 0 with array of equal numbers', ->
    utils.stdv([1, 1, 1, 1, 1])
      .should.eql(0)
  it 'should calculate stdv given an array of numbers', ->
    utils.stdv([600, 470, 170, 430, 300])
      .should.eql(147.32277488562318)
  it 'should also accept objects with a key', ->
    utils.stdv([{ a: 600 },{ a: 470 },{ a: 170 },{ a: 430 },{ a: 300 }], 'a')
      .should.eql(147.32277488562318)
  it 'should not accept objects without a key', ->
    (->
      utils.stdv([{ a: 600 },{ a: 470 },{ a: 170 },{ a: 430 },{ a: 300 }])
    ).should.throwError 'No key parameter provided'
    


# describe.skip 'Standardize', ->
#   it 'returns the array in units of stdv from mean', ->
#     utils.standardize([a: 600, a: 470, a: 170, a: 430, a: 300])
#       .should.eql([
#         a: 1.398290251863176
#         a: 0.5158740735029193
#         a: -1.5204709534822884
#         a: 0.24436140323822492
#         a: -0.6380547751220317 ])
