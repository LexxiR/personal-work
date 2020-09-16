-- FUNCTION: firstAnswer by Lexxi Reddington

-- The first argument should be applied to elements of the second argument (a list) in order
-- until the first time it returns Just v for some v
-- and then Just v is the result of the call to firstAnswer.
-- If the first argument returns Nothing for all the elements in the list, then firstAnswer should return Nothing.
-- FUNCTION PARAMETERS: A function and a list
-- FUNCTION RESULTS: A Maybe b type (either Just b or Nothing)
-- TYPE OF FUNCTION: ( a -> Maybe b ) -> [a] -> Maybe b
firstAnswer :: ( a -> Maybe b ) -> [a] -> Maybe b
firstAnswer f [] = Nothing
firstAnswer f (x:xs) = case (f x) of
  Just y -> Just y
  Nothing -> firstAnswer f xs
