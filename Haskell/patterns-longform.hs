-- Haskell Patterns by Lexxi Reddington (longform)

-- Data Definitions
data Pattern = WildcardPat | VariablePat (String) | UnitPat | ConstantPat (Int) | ConstructorPat (String, Pattern) | TuplePat ([Pattern]) deriving (Eq, Show)
data Value = Constant (Int) | Unit | Constructor (String, Value) | Tuple [Value] deriving (Eq, Show)

-- allAnswers helper function
allAnswers :: (t -> Maybe [a]) -> [t] -> Maybe [a]
allAnswers f [] = Just []
allAnswers f (x:xs) = case (allAnswers f xs) of
  Nothing -> Nothing
  Just t -> case (f x) of
    Nothing -> Nothing
    Just h -> Just (h ++ t)

-- firstAnswer helper function
firstAnswer :: (a -> Maybe b) -> [a] -> Maybe b
firstAnswer f [] = Nothing
firstAnswer f (x:xs) = case (f x) of
  Just y -> Just y
  Nothing -> firstAnswer f xs

-- FUNCTION 1: checkPat
-- Purpose: Takes a pattern and returns true if and only if all the variables appearing in the pattern are distinct from each other (i.e., use different strings)
-- Type of Function: Pattern -> Bool
-- Function Parameters: A Pattern
-- Function Result: A Boolean (True or False)
checkPat :: Pattern -> Bool
checkPat pat = hasRepeats (patternToList pat)

-- Helper function for checkPat that takes a pattern and returns a list of all the strings it uses for variables
patternToList :: Pattern -> [String]
patternToList pat = case pat of
                                WildcardPat -> []
                                VariablePat str -> [str]
                                UnitPat -> []
                                ConstantPat int -> []
                                ConstructorPat(str, p) -> patternToList p
                                TuplePat([pat1,pat2]) -> patternToList pat1 ++ patternToList pat2

-- Helper function for checkPat that takes a list of strings and decides if it has repeats
hasRepeats :: (Eq a) => [a] -> Bool
hasRepeats [] = True
hasRepeats (x:xs) = case (elem x xs) of
                                        True -> False
                                        False -> hasRepeats xs

-- FUNCTION 2: match
-- Purpose: Implements pattern matching (finding all matches)
-- Type of Function: (Value,Pattern) -> Maybe [(String,Value)]
-- Function Parameters: A (Value, Pattern)
-- Function Result: A Maybe [(String, Value)]
match :: (Value, Pattern) -> Maybe [(String, Value)]
match (val,pat) = case pat of
                            WildcardPat -> Just []
                            VariablePat(str) -> Just [(str,val)]
                            UnitPat -> case val of
                                                    Unit -> Just []
                                                    otherwise -> Nothing
                            ConstantPat(int1) -> case val of
                                                                    Constant(int2) -> if (int1 == int2)
                                                                                        then Just []
                                                                                        else Nothing
                                                                    otherwise -> Nothing
                            ConstructorPat(s1,p1) -> case val of
                                                                    Constructor(s2,p2) -> if (s1 == s2)
                                                                                            then match(p2,p1)
                                                                                            else Nothing
                                                                    otherwise -> Nothing
                            TuplePat ([pat1,pat2]) -> case val of
                                                                    Tuple([v1,v2]) -> if ((length [pat1,pat2]) == (length [v1,v2]))
                                                                                        then (allAnswers (match) [(v1,pat1),(v2,pat2)])
                                                                                        else Nothing
                                                                    otherwise -> Nothing

-- FUNCTION 3: firstMatch
-- Purpose: Implements pattern matching (finding the first match)
-- Type of Function: Value -> [Pattern] -> Maybe[(String, Value)]
-- Function Parameters: A Value and a list of Patterns
-- Function Result: A Maybe[(String, Value)]
firstMatch :: Value -> [Pattern] -> Maybe[(String, Value)]
firstMatch val [] = Nothing
firstMatch val (x:xs) = firstAnswer matchPat (x:xs)
            where matchPat pat = match (val,pat)
