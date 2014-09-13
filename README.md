Alike
=============
[![Build Status](https://travis-ci.org/axiomzen/Alike.png?branch=master)](https://travis-ci.org/axiomzen/Alike)
<a href="https://zenhub.io"><img src="https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png" height="18px"></a>

A simple-but-useful kNN library for NodeJS, comparing JSON Objects using Euclidean distances, returning top k closest objects.

Supports Normalized Weighted Euclidean distances. Normalize attributes by Standard Deviation. See [here](http://www.econ.upf.edu/~michael/stanford/maeb4.pdf).

Features `key` and `filter` attributes to do the data assembly for you, Lisp style!

## k-Nearest Neighbour function
```
subject:  vantage point object - will consider each attribute present in this object as a feature
objects:  array of objects that should all have at least the attributes of subject
options:
    - k: (default = unlimited) specifies how many objects to return
    - standardize: (default = false) if true, will apply standardization across all attributes using stdvs - set this to true if your attributes do not have the same scale
    - weights: (default = {}) a hash describing the weights of each attribute
    - key: (default = none) a key function to map over objects, to be used if the subject attributes are nested within key
        e.g. if subject is {a:0} and objects are [{x: {a: 0}}, {x: {a: 2}}], then provide key: function(o) {return o.x}
    - filter: (default = none) a filter function that returns true for items to be considered
        e.g. to only consider objects with non-negative a: function(o) {return o.a >= 0})
```
## Example usage

Given John Foo's taste for movies:

<table>
  <thead>
    <th>Attributes</th>
    <th>Value</th>
    <th>Weight</th>
  </thead>
  <tr>
    <td>explosions</td><td>8</td><td>10%</td>
  </tr>
  <tr>
    <td>romance</td><td>3</td><td>30%</td>
  </tr>
  <tr>
    <td>length</td><td>6</td><td>5%</td>
  </tr>
  <tr>
    <td>humor</td><td>5</td><td>5%</td>
  </tr>
  <tr>
    <td>pigeons</td><td>10</td><td>50%</td>
  </tr>
</table>

John Foo would like to rent a movie tonight that most closely matches his movie tastes. He collected a DB of movies with numerical values ranging from 1 to 10 for each of the 5 attributes listed above (don't ask how).

John Foo loves his pigeons. It is the most important attribute to him, hence carries 50% of the weight. He does not like romance and wants to make sure that he avoids sappy movies. Even though he likes mid-length movies with explosions and semi-funny movies, he doesn't care as much, as long as the movie features peaceful pigeons.

Perfect case for Alike!

### Getting started

To install and add it to your `package.json`

```
$ npm install alike --save
```

Now you can load up the module and use it like so:

```
knn = require('alike');

options = {
  k: 10,
  weights: {
    explosions: 0.1,
    romance: 0.3,
    length: 0.05,
    humour: 0.05,
    pigeons: 0.5
  }
}

movieTaste = {
  explosions: 8,
  romance: 3,
  length: 5,
  humour: 6,
  pigeons: 10
}

knn(movieTaste, movies, options)
```

Where `movies` is an array of objects that have at least those 5 attributes. Returns the top 10 movies from the array. Enjoy! :)

## Development

Alike is written in CoffeeScript in the `coffee/` folder. You may use `make coffee` to compile and watch for changes. Unit tests are in the `coffee/test/` folder. You can run the tests with `npm test` or if you are developing, you may use `make watch-test` to watch while you TDD. :)

## Benchmarks

Run it with `coffee benchmark/` takes about 1m on a Macbook Air.

The benchmarks are designed to reflect realistically sized sets of data. They don't ship with the `npm` package to keep things light.

## License

Alike is licensed under the terms of the [GNU Lesser General Public License](http://www.gnu.org/licenses/lgpl.html), known as the LGPL.
