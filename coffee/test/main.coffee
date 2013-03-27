should = require("should")
nearestNeighbor = require("../lib/main")

describe "K Nearest Neighbor", ->
  describe "number of arguments", ->
    it "should be at least 2", ->
      (->
        nearestNeighbor()
      ).should.throwError "Expecting at least 2 arguments"
      (->
        nearestNeighbor 1
      ).should.throwError "Expecting at least 2 arguments"

    it "should accept 2 or 3", ->
      (->
        nearestNeighbor 1, 2
      ).should.not.throwError()
      (->
        nearestNeighbor 1, 2, 3
      ).should.not.throwError()