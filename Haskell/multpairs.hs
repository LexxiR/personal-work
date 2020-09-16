import Data.List
import Data.Char

-- Short Functions in Haskell by Lexxi Reddington: Part 14

-- Purpose: Take a list of pairs of integers and return a list of the products of each pair.
-- Type of Function: Num a => [(a, a)] -> [a]
-- Function Parameters: A list of 2-tuples of numbers
-- Function Results: A list of numbers
multpairs :: Num a => [(a, a)] -> [a]
multpairs [(a,b)] = [(a*b)]
multpairs ((a,b):rest) = [(a*b)] ++ (multpairs rest)
