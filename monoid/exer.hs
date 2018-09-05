import qualified Data.Foldable as F

newtype Pair b a = Pair { getPair :: (a, b) }

instance Functor (Pair c) where
    fmap f (Pair (x, y)) = Pair (f x, y)

lengthCompare :: String -> String -> Ordering
lengthCompare x y = (length x `compare` length y) `mappend`
                    (x `compare` y)

newtype First' a = First' { getFirst' :: Maybe a }
    deriving (Eq, Show, Read)

--instance Monoid (First' a) where
    --mempty = First' Nothing
    --First' (Just x) `mappend` _ = First' (Just x)
    --First' Nothing `mappend` x = x
-- Last 实现与 First 相反

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

testTree = Node 5
    (Node 3
        (Node 1  EmptyTree EmptyTree)
        (Node 6  EmptyTree EmptyTree)
    )
    (Node 9
        (Node 8  EmptyTree EmptyTree)
        (Node 10 EmptyTree EmptyTree)
    )

instance F.Foldable Tree where
    foldMap f EmptyTree = mempty
    foldMap f (Node x l r) = F.foldMap f l `mappend`
                             f x       `mappend`
                             F.foldMap f r

