-- Short Functions in Haskell by Lexxi Reddington: Part 2

-- Purpose of the Function: Scale a vector by some scalar amount
-- Function Parameters: A scalar n (a number) and a vector/2-tuple (a,b)
-- Function Results: A vector/2-tuple that has been scaled by n
-- Type of the Function: scaleVector :: Num b => b -> (b, b) -> (b, b)
-- (The type of the function is inputting an integer/number and a tuple and outputting a tuple)
scaleVector n (a,b) = (n*a,n*b)
