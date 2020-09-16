-- Haskell Types, Pattern Matching and Type Classes by Lexxi Reddington (longform)

-- Data Type: "TriTree"
-- Defined recursively as either an "EmptyNode," an empty node, or "TriNode a," a node holding an element with three branches, each a trinary tree.
data TriTree a = EmptyNode | TriNode a (TriTree a) (TriTree a) (TriTree a) deriving (Show)

-- Typeclass Extension
instance (Eq a) => Eq (TriTree a) where
  EmptyNode           == EmptyNode = True
  TriNode a la ma ra  == TriNode b lb mb rb = (a == b) &&
                                              (la == lb) &&
                                              (ma == mb) &&
                                              (ra == rb)
  _                   == _ = False

-- HELPER FUNCTION: treeTraversal
-- Purpose: Traverse a tree and output a list ofthe values at each node
-- Function Parameters: A trinary trees
-- Function Results: A list of values from the input tree
-- Type of function: Input 1 TriTree of type a and output a list of type a
treeTraversal EmptyNode = []
treeTraversal (TriNode value left middle right) = [value] ++ treeTraversal left ++ treeTraversal middle ++ treeTraversal right

-- FUNCTION 1: nodeValue
-- Purpose: Takes a trinary tree and returns the value of the given node (or error)
-- Function Parameters: A trinary tree
-- Function Results: The value of the given node, or an error if it's an empty node
-- Type of Function: Input 1 TriTree of type a and output type a (the value)
nodeValue :: TriTree a -> a
nodeValue EmptyNode = error "Error: Empty Node!"
nodeValue (TriNode value left middle right) = value

-- FUNCTION 2: leftChild
-- Purpose: Takes a trinary tree and returns the left child (or error)
-- Function Parameters: A trinary tree
-- Function Results: The left child, or an error if the tree is an empty node
-- Type of Function: Input 1 TriTree of type a and output type a
leftChild :: TriTree a -> TriTree a
leftChild EmptyNode = error "Error: Empty Node!"
leftChild (TriNode value left middle right) = left

-- FUNCTION 3: middleChild
-- Purpose: Takes a trinary tree and returns the middle child (or error)
-- Function Parameters: A trinary tree
-- Function Results: The middle child, or an error if the tree is an empty node
-- Type of Function: Input 1 TriTree of type a and output type a
middleChild :: TriTree a -> TriTree a
middleChild EmptyNode = error "Error: Empty Node!"
middleChild (TriNode value left middle right) = middle

-- FUNCTION 4: rightChild
-- Purpose: Takes a trinary tree and returns the right child (or error)
-- Function Parameters: A trinary tree
-- Function Results: The right child, or an error if the tree is an empty node
-- Type of Function: Input 1 TriTree of type a and output type a
rightChild :: TriTree a -> TriTree a
rightChild EmptyNode = error "Error: Empty Node!"
rightChild (TriNode value left middle right) = right

-- FUNCTION 5: inTree
-- Purpose: Returns True or False if the given element is in a trinary tree
-- Function Parameters: A value of type a and a trinary tree of type a
-- Function Results: True (if the value is in the tree) or False (if the value is not in the tree)
-- Type of Function: Input one value of type a and a TriTree of type a and output a boolean type (True/False)
inTree :: Eq a => a -> TriTree a -> Bool
inTree x EmptyNode = False
inTree x (TriNode value left middle right) =
  let
    exists a [] = False
    exists a (x:xs) =
      if (a == x)
        then True
        else exists a xs
    list = treeTraversal (TriNode value left middle right)
  in exists x list

-- FUNCTION 6: LeafList
-- Purpose: Takes a trinary tree and returns a list of all the values in the leaves of the tree
-- Note: A leaf is a node with three empty branches
-- Function Parameters: A trinary tree
-- Function Results: A list of all the values in the leaves of the tree
-- Type of Function: A TriTree of type a and a list of type a
leafList :: TriTree a -> [a]
leafList EmptyNode = []
leafList (TriNode value EmptyNode EmptyNode EmptyNode) = [value]
leafList (TriNode _ left middle right) = leafList left ++ leafList middle ++ leafList right

-- FUNCTION 7: inOrderMap
-- Purpose: This function acts like map on a list, performing an in-order traversal of the tree...
-- Pass a function that takes type a and returns type b, pass in a TriTree with type a, and get a resulting TriTree of type b...
-- The trees will match in structure, but with each value transformed by the function you used
-- Function Parameters: A function and a trinary tree of type a
-- Function Results: A trinary tree of type b (Basically the function applied on the values in the tree)
-- Type of Function: Input a function and a TriTree of type a and output a TriTree of type b
inOrderMap :: (a -> b) -> TriTree a -> TriTree b
inOrderMap _ EmptyNode = EmptyNode
inOrderMap f (TriNode value left middle right) = TriNode (f value) (inOrderMap f left) (inOrderMap f middle) (inOrderMap f right)

-- FUNCTION 8: preOrderFold
-- Purpose: Similar to a foldl operation on lists, this function takes a function as the first argument, an accumulator value, a TriTree,
-- and performs an pre-order walk of the tree, applying the function to each value and then using the result of that function in the next call of the folding in the tree
-- Function Parameters: A function, an accumulator value, and a trinary tree
-- Function Results: A resultant value
-- Type of Function: Input a function that produces a type b, a value of type b, and a TriTree, and output a value of type b
preOrderFold:: (a -> b -> b) -> b -> TriTree a -> b
preOrderFold func start EmptyNode = start
preOrderFold func start (TriNode value left middle right) =
  let
    fold f z [] = z
    fold f z (x:xs) = f x (fold f z xs)

    list = treeTraversal (TriNode value left middle right)
    returnValue = (fold func start list)
  in returnValue

--------------------------------------------------------------------------------
-- "Achievements"

-- Defined data type for k-trees, i.e., a tree with k children
-- A k-tree is similar to a binary tree, except that only the leaves have values, internal nodes do not
data KTree a =  KLeaf a | KNode [(KTree a)] deriving Show

-- Function: kLeafList
-- Purpose: Takes a k-tree and returns a list of all the values in the leaves of the tree
-- Function Parameters: A k-tree
-- Function Results: A list of leaf values
-- Type of Function: Input a KTree of a certain type and output a list of the same type
kLeafList :: (Ord a) => KTree a -> [a]
kLeafList (KLeaf a)  = [a]
kLeafList (KNode []) = []
kLeafList (KNode (x:xs))  = kLeafList x ++ kLeafList (KNode xs)

-- Function: kMap
-- Purpose: Performs mapping (applies the function to the elements in a k-tree)
-- Function Parameters: A function on type a and a KTree of type a
-- Function Results: A KTree of type a
-- Type of Function: Input a function and a KTree and output a KTree
kMap :: (a -> a) -> KTree a -> KTree a
kMap f (KLeaf a) = KLeaf (f a)
kMap f (KNode trees) = KNode (map (kMap f) trees)

-- Function: kFold
-- Purpose: Perform a pre-order walk of the tree, applying the function to each value and then using the result of that function in the next call of the folding in the tree
-- Function Parameters: A function on type b, an accumulator value of type b, and a k-tree
-- Function Results: A value of type b
-- Type of Function: Input a function on type b, a type b value, a KTree, and output a type b value
kFold :: (Ord a) => (b -> a -> b) -> b -> KTree a -> b
kFold _ z (KLeaf a) = z
kFold f z ktree = foldl f z (kLeafList ktree)
