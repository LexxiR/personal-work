-- Short Functions in Haskell by Lexxi Reddington: Part 7

-- Purpose of the Function: Take a list and construct a new list only consisting of every third element in it
-- Function Parameters: A list of elements
-- Function Results: A list of every third element from the original list
-- Type of the Function: Takes a list of elements and outputs one list of elements (same type)
-- (The type of the function is inputting and outputting )
everyThird [] = []
everyThird [x] = []
everyThird [x,y] = []
everyThird [x,y,z] = [z]
everyThird (x:y:z:a) = [z] ++ (everyThird a)
