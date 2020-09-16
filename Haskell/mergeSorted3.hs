-- Short Functions in Haskell by Lexxi Reddington: Part 11

-- Purpose of the Function: Take three lists which are in sorted order and merge them so that the final list is sorted in increasing order
-- Function Parameters: Three sorted lists of the same element type
-- Function Results: One sorted list of the same element type as the input
-- Type of the Function: Ord a => [a] -> [a] -> [a] -> [a]
-- (Takes three lists of the same type and returns one list of that type - The type must be comparable, like with ints)

-- Note: This assumes the input lists are already sorted
mergeSorted3 [] [] [] = []
mergeSorted3 x [] [] = x
mergeSorted3 [] y [] = y
mergeSorted3 [] [] z = z

mergeSorted3 x y [] = (mergeSort2 x y)
mergeSorted3 x [] z = (mergeSort2 x z)
mergeSorted3 [] y z = (mergeSort2 y z)

mergeSorted3 (x:xs) (y:ys) (z:zs) =
  let
    firstSorted = (mergeSort2 (x:xs) (y:ys))
    finalSorted = (mergeSort2 firstSorted (z:zs))
  in
    finalSorted

-- Helper function to sort two lists into one with elements in ascending order
mergeSort2 [] [] = []
mergeSort2 x [] = x
mergeSort2 [] y = y
mergeSort2 (a:as) (b:bs) =
  if a <= b
    then [a] ++ (mergeSort2 as (b:bs))
    else [b] ++ (mergeSort2 (a:as) bs)
