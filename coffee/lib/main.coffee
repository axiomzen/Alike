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

  # Calculate all object distances from subject and store in object
  distances = for object, i in objects
    index: i
    dist: util.distance(subject, object)

  # console.log subject, objects, distances

  # Sort distances ascending
  sortMap = distances.sort (a,b) -> a.dist - b.dist

  # Sort objects using sortMap
  sortedObjects = for i in sortMap 
    objects[i.index]

  # Slice top k from sorted
  k = options?.k || 1
  sortedObjects.slice(0, k)
