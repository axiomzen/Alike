
### 
  Euclidean distance function
  ----------
  Takes 2 objects, and returns squared Euclidean distance based on the first object's attributes
  e.g. p1 = {a: 1} and p2 = {a: 2, b: 3, c: 5} will ignore extra attributes on p2 and return 1
  All attributes on p1 MUST be present in p2 (otherwise will be inaccurate if ignored)
  Accepts optional third argument, which is an options hash: 
   - [stdv] defines the stdv for each attr
   - [weights] defines the weights for each attr (todo)
###
exports.distance = (p1, p2, opts) ->
  dist = 0
  for attr, val of p1
    x = val
    y = p2[attr]

    # Normalize if stdv values are passed in opts
    if opts?.stdv and Object.getOwnPropertyNames(opts.stdv).length > 0 and opts.stdv[attr] isnt 0
      x /= opts.stdv[attr]
      y /= opts.stdv[attr]

    # Apply weight factor is provided
    if opts?.weights and Object.getOwnPropertyNames(opts.weights).length > 0
      x *= opts.weights[attr]
      y *= opts.weights[attr]

    dist += Math.pow x - y, 2
  dist

###
  Standard Deviation
  ----------
  Given an array of numbers, returns the stdv
  Given an array of objects, require key parameter identifying the attribute to calculate stdv for
###
exports.stdv = (array, key) ->
  if typeof array[0] != 'number' and not key
    throw new Error('No key parameter provided')

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
  Get all Standard Deviations
  ----------
  Given a subject and an array of objects, return an object describing each of subject's key's stdv on objects
###
exports.allStdvs = (subject, objects) ->
  stdvs = {}
  for attr of subject
    stdvs[attr] = exports.stdv(objects, attr)
  stdvs


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
