import Debug.Trace
import Control.Monad
import Data.List
import Data.Maybe
import Logic
import Util

applySingle :: [Expr] -> [Expr]
applySingle props = catMaybes [r p | p <- props, r <- rules]

applyDouble :: [Expr] -> [Expr]
applyDouble props = catMaybes [r p q | p <- props, q <- props, r <- doubleRules]

apply :: [Expr] -> [Expr]
apply props = nub (props ++ applySingle props ++ applyDouble props)

resolve :: [Expr] -> [[Expr]]
resolve = unfoldr (Just . join (,) . apply)

isValid :: [Expr] -> Expr -> Bool
isValid ps c = elem c . concat $ resolve ps

-- addSups = map (\p -> (p, ("S", p)))

-- prove ps conc = go conc []
--   where go seed res = if elem (prev line) ps
--                       then (prettify ps) ++ ((pretty line) : res)
--                       else go (prev line) ((pretty line) : res)
--           where line = findLine seed
--                 findLine p = val . find (\b -> (prem b) == p) . concat $ rose
--                 findConclusion b = all (not . (\a -> (prem a) == conc)) b
--                 rose = takeWhileInclusive findConclusion (resolve (addSups ps))
--                 prettify = map (\p -> (p, "S"))
--                 pretty (a, (b, c)) = (a, b)

main :: IO ()
main = print $ isValid

       [ (Not (Not (If A B))),
         (And (Not (Not (Not B))) (Not C)) 
       ] (Not A)
