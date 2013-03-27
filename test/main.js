var should = require('should');
var nearestNeighbor = require('../lib/main');

describe('K Nearest Neighbor', function() {
  describe('number of arguments', function() {
    it('should be at least 2', function() {
      (function(){nearestNeighbor();}).should.throwError('Expecting at least 2 arguments');
      (function(){nearestNeighbor(1);}).should.throwError('Expecting at least 2 arguments');
    });
    it('should accept 2 or 3', function(){
      (function(){nearestNeighbor(1, 2);}).should.not.throwError();
      (function(){nearestNeighbor(1, 2, 3);}).should.not.throwError();
    });
  });
});