import Data.List
import Data.Char

-- Short Functions in Haskell by Lexxi Reddington: Part 13

-- Purpose: Take a String list and return the longest String in the list.
-- If the list is empty, return "". If there is a tie, return the first one.
-- Type of Function: [String] -> String (which is equivalent to [[Char]] -> [Char])
-- Function Parameters: A String list
-- Function Results: One String
longestString :: [String] -> String
longestString list = foldl (\accumulator strFromList -> if length strFromList > length accumulator then strFromList else accumulator) [] list
