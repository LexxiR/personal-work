-- Short Functions in Haskell by Lexxi Reddington: Part 3

-- Purpose of the Function: Compute the Cartesian distance between two 3D points
-- Function Parameters: Two 3-tuples (a,b,c) and (x,y,z) symbolizing two 3D points
-- Function Results: The Cartesian distance (a single number)
-- Type of the Function: tripleDistance :: Floating a => (a, a, a) -> (a, a, a) -> a
-- (The type of the function is inputting two tuples and outputting a single integer/number)
tripleDistance (x1,y1,z1) (x2,y2,z2) = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
