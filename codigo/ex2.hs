data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Read, Eq, Ord, Show)
data Nada = Nada deriving (Eq, Ord)

instance Show Nada where
    show Nada = ""

instance Read Nada where
    readsPrec _ str = [(Nada, str)]


readTree :: Integer -> IO (Tree Nada)
readTree n = fmap read $ readFile $ "ex2-" ++ show n ++ ".txt"

showTree :: Show a => Tree a -> IO ()
showTree tr = showDn 0 tr
    where showDn n Empty = putStrLn (replicate (4 * n) ' ' ++ "Empty")
          showDn n (Node x a b) = do
              putStrLn (replicate (4 * n) ' ' ++ "Node " ++ show x)
              showDn (n + 1) a
              showDn (n + 1) b

minDepth :: Tree a -> Integer
minDepth Empty = 0
minDepth (Node _ a b) = 1 + min (minDepth a) (minDepth b)

maxDepth :: Tree a -> Integer
maxDepth Empty = 0
maxDepth (Node _ a b) = 1 + max (maxDepth a) (maxDepth b)

depths :: Tree a -> (Integer, Integer)
depths tree = (minDepth tree, maxDepth tree)

cntNos :: Tree a -> Integer
cntNos Empty = 0
cntNos (Node _ a b) = 1 + cntNos a + cntNos b

dfmp :: Tree a -> Integer
dfmp Empty = error "vazio"
dfmp (Node _ Empty Empty) = 0
dfmp (Node _ a Empty) = dfmp a + 1
dfmp (Node _ Empty b) = dfmp b + 1
dfmp (Node _ a b) = (dfmp a `min` dfmp b) + 1

dfmd :: Tree a -> Integer
dfmd Empty = error "vazio"
dfmd (Node _ Empty Empty) = 0
dfmd (Node _ a Empty) = dfmd a + 1
dfmd (Node _ Empty b) = dfmd b + 1
dfmd (Node _ a b) = (dfmd a `max` dfmd b) + 1

distTreeS :: Tree a -> Tree Integer
distTreeS Empty = Empty
distTreeS tree @ (Node _ a b) = Node num (distTreeS a) (distTreeS b)
    where num =  abs (dfmp tree - dfmd tree)

distTreeExt :: Tree a -> Tree a -> (Tree Integer, Integer, Integer)
distTreeExt Empty Empty = (Node 0 Empty Empty, 0, 0)
distTreeExt Empty (Node _ a b) = (Node (abs (dp - dd)) Empty tr, dp + 1, dd + 1)
    where (tr, dp, dd) = distTreeExt a b
distTreeExt (Node _ a b) Empty = (Node (abs (dp - dd)) tr Empty, dp + 1, dd + 1)
    where (tr, dp, dd) = distTreeExt a b
distTreeExt (Node _ ra rb) (Node _ la lb) = (Node (abs (dp - dd)) rtr ltr, dp + 1, dd + 1)
    where (rtr, rdp, rdd) = distTreeExt ra rb
          (ltr, ldp, ldd) = distTreeExt la lb
          (dp, dd) = (min rdp ldp, max rdd ldd)

distTree :: Tree a -> Tree Integer
distTree Empty = Empty
distTree (Node _ a b) = tr
    where (tr, _, _) = distTreeExt a b

