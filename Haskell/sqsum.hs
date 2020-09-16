import Data.List
import Data.Char

-- Short Functions in Haskell by Lexxi Reddington: Part 15

-- Purpose: Take a list of integers and return the sum of the squares of those integers.
-- Type of Function: Num a => [a] -> a
-- Function Parameters: A list of numbers
-- Function Results: A number
sqsum :: Num a => [a] -> a
sqsum [] = error "The List is Empty!"
sqsum [x] = x^2
sqsum (x:xs) = x^2 + sqsum xs
