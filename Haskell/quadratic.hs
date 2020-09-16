-- Short Functions in Haskell by Lexxi Reddington: Part 1

-- Purpose of the Function: Compute the quadratic a + b*x + c*x^2
-- Function Parameters: The values a, b, c, and x (all numbers)
-- Function Results: A single number that is the result of the formula a + b*x + c*x^2
-- Type of the Function: quadratic :: Num a => a -> a -> a -> a -> a
-- (The type of the function is inputting in four integers/numbers and outputting a single integer/number)
quadratic a b c x = a + b*x + c*x*x
