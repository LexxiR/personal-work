-- FUNCTION: allAnswers by Lexxi Reddington

-- The first argument should be applied to elements of the second argument.
-- If it returns Nothing for any element, then the result for allAnswers is Nothing.
-- Otherwise, calls to the first argument will have produced Just lst1, Just lst2, ..., Just lstn
-- and the result of allAnswers is Just lst, where lst is [lst1, lst2, ..., lstn]
-- FUNCTION PARAMETERS: A function and a list
-- FUNCTION RESULTS: Either 'Nothing' or a list of Just types
-- TYPE OF FUNCTION: (t -> Maybe a) -> [t] -> Maybe [a]
allAnswers :: (t -> Maybe a) -> [t] -> Maybe [a]
allAnswers f [] = Just []
allAnswers f (x:xs) = case (allAnswers f xs) of
  Nothing -> Nothing
  Just t -> case (f x) of
    Nothing -> Nothing
    Just h -> Just ([h] ++ t)
