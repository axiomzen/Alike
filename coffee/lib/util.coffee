
### 
  Euclidean distance function
  ----------
  Takes 2 objects, and returns squared Euclidean distance based on the first object's attributes
  e.g. p1 = {a: 1} and p2 = {a: 2, b: 3, c: 5} will ignore extra attributes on p2 and return 1
  All attributes on p1 MUST be present in p2 (otherwise will be inaccurate if ignored)
###
exports.distance = (p1, p2) ->
  dist = 0
  for attr, val of p1
    dist += Math.pow val - p2[attr], 2
  dist

###
  Standard Deviation
###
exports.stdv = (array, key) ->
  arr = []
  if key
    arr = (a[key] for a in array)
  else
    arr = array

  m = mean(arr)
  ssqdiff = 0
  for x in arr
    ssqdiff += Math.pow( x - m, 2)
  Math.sqrt(ssqdiff / array.length)

###
  Standardize objects
  ---
  Takes an array of objects with numerical attributes, and returns object with standardized values,
  with units in measures of standard deviation from mean. (See www.econ.upf.edu/~michael/stanford/maeb4.pdf)
###
exports.standardize = (array) ->
  m = mean array
  s = exports.stdv array
  ((x - m) / s for x in array)


# ---  meta-utils  ---

mean = (array) ->
  sum = array.reduce (a,b) -> a + b
  sum / array.length
