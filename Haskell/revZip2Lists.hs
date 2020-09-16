-- Short Functions in Haskell by Lexxi Reddington: Part 6

-- Purpose of the Function: Take two lists of arguments and create a list with a pair from each list consecutively, but in reverse
-- Function Parameters: Two lists of elements/arguments
-- Function Results: One list with elements that are pairs of two elements, one from each of the two original lists
-- Type of the Function: Takes two lists of elements and outputs one list of elements of the same types (tuples created from elements in the two input lists)
revZip2Lists [] [] = []
revZip2Lists [x] [y] = [(y,x)]
revZip2Lists (x:xs) (y:ys) = (revZip2Lists xs ys) ++ [(y,x)]
