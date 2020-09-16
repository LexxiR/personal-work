-- Short Functions in Haskell by Lexxi Reddington: Part 10

-- Purpose of the Function: Replace all occurrences of the first argument with the second argument in the list and return the new list
-- Function Parameters: An element, another element, and a list of elements
-- Function Results: A list of elements
-- Type of the Function: Eq a => a -> a -> [a] -> [a]
-- (Takes two elements and a list, all of the same type, and outputs a list of the elements of the same type)
substitute a b [] = []
substitute a b (x:xs) =
  if a == x
    then [b] ++ (substitute a b xs)
    else [x] ++ (substitute a b xs)
