###
  k-Nearest Neigbor library
  -------
  subject:  vantage point object -- will consider each attribute present in this object
  objects:  array of objects that should all have at least the attributes of subject
  options:  options hash to specify:
        - k: (default = 1) specifies how many objects to return
        - standardize: (default = false) if true, will apply standardization accross all attributes using stdvs
        - weights: (default = {}) a hash describing the weights of each attribute
###

util = require './util'
module.exports = (subject, objects, options) ->
  # Argument checks
  if arguments.length < 2
    throw new Error('Expecting at least 2 arguments')

  unless (Array.prototype.slice.call(arguments).every (i) -> i and typeof i == 'object')
    throw new Error('Expecting object arguments')

  unless Array.isArray(arguments[1])
    throw new Error('Expecting an array as second argument')  

  unless objects.length
    return []

  for attr of subject
    for o in objects
      unless attr of o
        throw new Error("Missing attribute '#{attr}' in '#{JSON.stringify(o)}'")

  # If standardize option is set to true, precalculate each attribute's stdv
  stdv = {}
  if options?.standardize?
    stdv = util.allStdvs subject, objects

  # Set weights if provided
  weights = {}
  if options?.weights
    weights = options.weights

  # Calculate all object distances from subject and store index
  distances = for object, i in objects
    index: i
    dist: util.distance(subject, object, {stdv: stdv, weights: weights})

  # Sort distances ascending
  sortMap = distances.sort (a,b) -> a.dist - b.dist

  # Copy objects in sorted order using sortMap
  sortedObjects = for i in sortMap 
    objects[i.index]

  # Slice top k from sortedObjects
  k = options?.k || 1
  sortedObjects.slice(0, k)
