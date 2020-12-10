data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Read, Eq, Ord, Show)
data Nada = Nada deriving (Eq, Ord)

instance Show Nada where
    show Nada = ""

instance Read Nada where
    readsPrec _ str = [(Nada, str)]

readTree :: Integer -> IO (Tree Nada)
readTree n = fmap read $ readFile $ "ex2-" ++ show n ++ ".txt"

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


distTreeExt :: Tree a -> Tree a -> (Tree Integer, Integer, Integer)
distTreeExt Empty Empty = (Node 0 Empty Empty, 1, 1)
distTreeExt Empty (Node _ a b) = (Node dd Empty tr, 1, dd + 1)
    where (tr, _, dd) = distTreeExt a b
distTreeExt (Node _ a b) Empty = (Node dd tr Empty, 1, dd + 1)
    where (tr, _, dd) = distTreeExt a b
distTreeExt (Node _ ra rb) (Node _ la lb) = (Node (abs $ dp - dd) rtr ltr, dp + 1, dd + 1)
    where (rtr, rdp, rdd) = distTreeExt ra rb
          (ltr, ldp, ldd) = distTreeExt la lb
          (dp, dd) = (min rdp ldp, max rdd ldd)

distTree :: Tree a -> Tree Integer
distTree Empty = Empty
distTree (Node _ a b) = tr
    where (tr, _, _) = distTreeExt a b

doit :: Integer -> IO ()
doit n = (distTree <$> readTree n) >>= print

distTreeSlow :: Tree a -> Tree Integer
distTreeSlow Empty = Empty
distTreeSlow tr @ (Node _ a b) = Node (abs $ maxDepth tr - minDepth tr) (distTreeSlow a) (distTreeSlow b)

showD :: Show a => Tree a -> IO ()
showD tr = showDn 0 tr
    where showDn n Empty = putStrLn (replicate (4 * n) ' ' ++ "Empty")
          showDn n (Node x a b) = do
              putStrLn (replicate (4 * n) ' ' ++ "Node " ++ show x)
              showDn (n + 1) a
              showDn (n + 1) b

doitS :: Integer -> IO ()
doitS n = (distTree <$> readTree n) >>= showD
