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