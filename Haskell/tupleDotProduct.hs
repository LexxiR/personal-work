-- Short Functions in Haskell by Lexxi Reddington: Part 5

-- Purpose of the Function: Take two lists of numbers and find the dot product between them
-- Function Parameters: Two lists of numbers
-- Function Results: The dot product of two lists (a scalar value/number)
-- Type of the Function: Takes a list of ints and outputs one int
tupleDotProduct [] [] = 0
tupleDotProduct [x] [y] = x*y
tupleDotProduct (x:xs) (y:ys) = x*y + (tupleDotProduct xs ys)
