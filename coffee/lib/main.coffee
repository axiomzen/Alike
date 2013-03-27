module.exports = (subject, objects, options) ->
  throw new Error("Expecting at least 2 arguments")  if arguments.length < 2
  arguments