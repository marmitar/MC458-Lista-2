import Data.Maybe (isJust)


data Tree = Empty | Node Float Tree Tree Tree deriving (Show, Read, Eq, Ord)

leaf :: Float -> Tree
leaf x = Node x Empty Empty Empty

value :: Tree -> Maybe Float
value Empty = Nothing
value (Node x _ _ _) = Just x

left :: Tree -> Tree
left Empty = Empty
left (Node _ a _ _) = a

center :: Tree -> Tree
center Empty = Empty
center (Node _ _ b _) = b

right :: Tree -> Tree
right Empty = Empty
right (Node _ _ _ c) = c

tuscaTest :: Float -> Float -> Tree -> Maybe (Float, Float)
tuscaTest r s Empty = Just (r, s)
tuscaTest _ _ (Node x a b c) = joinR (tuscaTest x (x - 1) a) (tuscaTest x x b) (tuscaTest (x + 1) x c)
    where joinR (Just (a1, a2)) (Just (b1, b2)) (Just (c1, c2))
            | a2 < x && b1 == x && b2 == x && c1 > x = Just (a1, c2)
            | otherwise = Nothing
          joinR _ _ _ = Nothing


ehTusca :: Tree -> Bool
ehTusca = isJust . tuscaTest 0 0

tst :: [Tree]
tst = [
        leaf 20,
        Node 20 (leaf 10) Empty Empty,
        Node 20 Empty (leaf 20) Empty,
        Node 20 (leaf 10) Empty (leaf 25),
        Node 20 (leaf 10) (leaf 20) (leaf 25),
        Node 20
            (Node 10
                (Node 8 Empty Empty (leaf 9))
                (leaf 10)
                (Node 15 (leaf 12) Empty Empty)
            )
            (Node 20 Empty (leaf 20) Empty)
            (Node 30 (leaf 19) Empty Empty),
        Node 20
            (Node 10
                (Node 9 (leaf 8) Empty Empty)
                (leaf 10)
                (Node 12 Empty Empty (leaf 15))
            )
            (Node 20 Empty Empty (leaf 25))
            (Node 30 (leaf 20) Empty Empty),
        Node 20
            (Node 10
                (Node 8 Empty Empty (leaf 10))
                (leaf 10)
                (Node 19 (leaf 17) Empty (leaf 21))
            )
            Empty
            (Node 20 (leaf 18) Empty (leaf 25))
    ]
