import Prelude hiding (reverse)
import Data.List.NonEmpty


polyRec :: Num a => NonEmpty a -> a -> (a, a)
polyRec (a0:|[]) _ = (a0, 1)
polyRec (an:|(ai:a)) x = (p + an * xn * x, xn * x)
    where (p, xn) = polyRec (ai :| a) x

poly :: Num a => [a] -> a -> a
poly [] _ = error "empty list"
poly (an:a) x = fst $ polyRec alpha x
    where alpha = reverse $ an :| a
