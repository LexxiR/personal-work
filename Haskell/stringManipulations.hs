-- String Manipulation Functions by Lexxi Reddington

-- Function for Reference
longestString :: [String] -> String
longestString list = foldl (\accumulator strFromList -> if length strFromList > length accumulator then strFromList else accumulator) [] list

-- Problem 1: longestString'
-- Purpose: Take a String list and return the longest String in the list.
-- If the list is empty, return "". If there is a tie, return the last one.
-- Type of Function: [String] -> String (which is equivalent to [[Char]] -> [Char])
-- Function Parameters: A String list
-- Function Results: One String
longestString' :: [String] -> String
longestString' list = foldl (\accumulator strFromList -> if length accumulator > length strFromList then accumulator else strFromList) [] list

-- Problem 2: longestStringHelper
-- Purpose: Acts like longestString but is more general because it takes a function as an argument
-- NOTE: If longestStringHelper is passed a function that behaves like >, the greater than operator, then the function has the same behavior as longestString
-- Type of Function: (Int -> Int -> Bool) -> [String] -> String
-- Function Parameters: A function (must compare and evaluate to True/False) and a String list
-- Function Results: One String
longestStringHelper :: (Int -> Int -> Bool) -> [String] -> String
longestStringHelper f [] = []
longestStringHelper f (x:xs) = foldl (\accumulator strFromList -> if f (length strFromList) (length accumulator) then strFromList else accumulator) x xs

-- Problem 3: longestString3
-- Purpose: Take a String list and return the longest String in the list.
-- If the list is empty, return "". If there is a tie, return the first one.
-- NOTE: Using just a binding and partial application of longestStringHelper
-- Type of Function: [String] -> String
-- Function Parameters: A String list
-- Function Results: One String
longestString3 :: [String] -> String
longestString3 = longestStringHelper (>)

-- Problem 4: longestString4
-- Purpose: Take a String list and return the longest String in the list.
-- If the list is empty, return "". If there is a tie, return the last one.
-- NOTE: Using just a binding and partial application of longestStringHelper
-- Type of Function: [String] -> String
-- Function Parameters: A String list
-- Function Results: One String
longestString4 :: [String] -> String
longestString4 = longestStringHelper (>=)
