-- Short Functions in Haskell by Lexxi Reddington: Part 4

-- Purpose of the Function: Find and return the smallest element in the list
-- Function Parameters: A list of elements
-- Function Results: The smallest element in the list
-- Type of the Function: Takes a list of comparable elements as input and outputs one element from that list (the minimum element)
minOf a b = if a <= b -- This is a helper function
              then a
              else b

findMin [] = error "Empty List"
findMin [x] = x
findMin (x:xs) = minOf x (findMin xs)
