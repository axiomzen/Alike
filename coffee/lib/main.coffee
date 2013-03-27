### 
  Euclidean distance function
  ----------
  Takes 2 objects, and returns squared Euclidean distance based on the first object's attributes
  e.g. p1 = {a: 1} and p2 = {a: 2, b: 3, c: 5} will ignore extra attributes on p2 and return 1
  All attributes on p1 MUST be present in p2 (otherwise will be inaccurate if ignored)
###
distance = (p1, p2) ->
  dist = 0
  for attr, val of p1
    dist += Math.pow val - p2[attr], 2
  dist

  
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
    dist: distance(subject, object)

  # console.log subject, objects, distances

  # Sort distances ascending
  sortMap = distances.sort (a,b) -> a.dist - b.dist

  # Sort objects using sortMap
  sortedObjects = for i in sortMap 
    objects[i.index]

  # Slice top k from sorted
  k = options?.k || 1
  sortedObjects.slice(0, k)