## Test case considering different units, i.e. requires normalization

## Chart
chart = "
   40  | B                 3 \n
   30  |                J    \n
   20  |    D     G        L \n
   10  |       F             \n
   0   | A     E2       I    \n
   -10 |                     \n
   -20 |    C     H          \n
   -30 |                K    \n
   -40 |_1___________________\n
        1  2  3  4  5  6  7 "

## Taste profiles
tasteProfile1 = 
  category: 1
  angularity: -40

tasteProfile2 = 
  category: 3
  angularity: 0

tasteProfile3 = 
  category: 7
  angularity: 40

## Wine list
wineList = [
    label: 'A'
    category: 1
    angularity: 0
  ,
    label: 'B'
    category: 1
    angularity: 40
  ,
    label: 'C'
    category: 2
    angularity: -20
  ,
    label: 'D'
    category: 2
    angularity: 20
  ,
    label: 'E'
    category: 3
    angularity: 0
  ,
    label: 'F'
    category: 3
    angularity: 10
  ,
    label: 'G'
    category: 4
    angularity: 20
  ,
    label: 'H'
    category: 4
    angularity: -20
  ,    
    label: 'I'
    category: 6
    angularity: 0
  ,    
    label: 'J'
    category: 6
    angularity: 30
  ,    
    label: 'K'
    category: 6
    angularity: -30
  ,    
    label: 'L'
    category: 7
    angularity: 20
]

module.exports =
  tasteProfile1: tasteProfile1
  tasteProfile2: tasteProfile2
  tasteProfile3: tasteProfile3
  wineList: wineList
  chart: chart