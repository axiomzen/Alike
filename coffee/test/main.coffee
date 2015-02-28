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
        nearestNeighbor {a:1}, [{a:2},{a:3}], {option: false}
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

    it 'should assert that all attributes in subject is present in object', ->
      (->
        nearestNeighbor {a:1}, [{a:2},{b:3}]
      ).should.throwError "Missing attribute 'a' in '{\"b\":3}'"

  describe 'for simple cases', ->
    it 'should return an empty object/array if no Y', ->
      nearestNeighbor({a:1}, []).should.eql([])
    it 'should return nearest neighbor with single dimension', ->
      nearestNeighbor({a:1}, [{a:1}, {a:2}], {k:1}).should.eql([{a:1}])
    it 'should return 2 nearest neighbors (in order) with single dimension', ->
      nearestNeighbor({a:1}, [{a:1}, {a:3}, {a:0}], {k:2}).should.eql([{a:1}, {a:0}])
    it 'should accept a key parameter for objects', ->
      nearestNeighbor({a:1}, [{x: {a:1}}, {x: {a:2}}], {k: 1, key: (o) -> o.x}).should.eql([{x: {a:1}}])
    it 'should accept a key parameter for nested objects', ->
      nearestNeighbor({a:1}, [{x: {y: {a:1}}}, {x: {y: {a:2}}}], {k: 1, key: (o) -> o.x.y}).should.eql([{x: {y: {a:1}}}])
    it 'should accept filter parameter', ->
      nearestNeighbor({a:1}, [{a:1}, {a:3}, {a:0}], {k:2, filter: (o) -> o.a > 0}).should.eql([{a:1}, {a:3}])
    it 'should accept return empty array if filters all', ->
      nearestNeighbor({a:1}, [{a:1}, {a:3}, {a:0}], {k:2, filter: (o) -> o.a > 10}).should.eql([])
    it 'should default to unlimited if no k is provided', ->
      nearestNeighbor({a:1}, [{a:1}, {a:2}, {a:3}]).should.eql([{a:1}, {a:2}, {a:3}])
    it 'should return distances if debug option is provided', ->
      nearestNeighbor({a:0, b:0}, [{a:3, b:4}], {debug: true}).should.eql([{a:3, b:4, debug: {distance: 25, details: {a: 9, b: 16}}}])

