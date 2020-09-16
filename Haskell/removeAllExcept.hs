-- Short Functions in Haskell by Lexxi Reddington: Part 8

-- Purpose of the Function: Remove everything that is not equal to the given element
-- Function Parameters: An element and a list of elements
-- Function Results: A new list containing only the desired element(s), if present
-- Type of the Function: Eq a => a -> [a] -> [a]
-- (Takes an element and a list of elements of the same type and outputs a new list of elements of the same type)
removeAllExcept a [] = []
removeAllExcept a (x:xs) =
  if a == x
    then [x] ++ (removeAllExcept a xs)
    else removeAllExcept a xs
