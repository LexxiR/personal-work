import Data.List
import Data.Char

-- Short Functions in Haskell by Lexxi Reddington: Part 12

-- Purpose: Take a String list and return a String list that only has the strings in the given list that begin with a lower-case letter.
-- Assume all strings have at least one character and use filter (in Data.List) and isLower (in Data.Char) for a 1-2 line solution.
-- Type of Function: [[Char]] -> [[Char]]
-- Function Parameters: A String list
-- Function Results: A String list
{-|
Note: This is the solution before being simplified into fewer lines
onlyLowercase :: [[Char]] -> [[Char]]
onlyLowercase s = filter isLow s
    where isLow str = Data.Char.isLower (head str)
-}
onlyLowercase :: [[Char]] -> [[Char]]
onlyLowercase s = filter (\str -> Data.Char.isLower (head str)) s
