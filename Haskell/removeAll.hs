-- Short Functions in Haskell by Lexxi Reddington: Part 9

-- Purpose of the Function: Remove all occurences of a given element
-- Function Parameters: An element and a list of elements
-- Function Results: A new list containing everything in the original list except the specified element
-- Type of the Function: Eq a => a -> [a] -> [a]
-- (Takes an element and a list of elements of the same type and outputs a new list of elements of the same type)
removeAll a [] = []
removeAll a (x:xs) =
  if a /= x
    then [x] ++ (removeAll a xs)
    else removeAll a xs
