import Data.List
import Data.Char

-- Short Functions in Haskell by Lexxi Reddington: Part 16

-- Purpose: Take a list as input and create a new list but with each element duplicated.
-- This function should work with any type of list.
-- Type of Function: [a] -> [a]
-- Function Parameters: A list
-- Function Results: A list
duplist :: [a] -> [a]
duplist [] = []
duplist [x] = [x] ++ [x]
duplist (x:xs) = [x] ++ [x] ++ (duplist xs)
