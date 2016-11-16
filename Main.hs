import Debug.Trace
import Control.Monad
import Data.List
import Data.Maybe
import Logic
import Util

applySingle :: [(Expr, t)] -> [Line]
applySingle props = catMaybeFst [(r p, (n, p)) | pp <- props, rp <- rulePairs,
                                let (r, n) = rp,
                                let (p, o) = pp]

applyDouble :: [(Expr, t)] -> [Line]
applyDouble props = catMaybeFst [(r p q, (n, p)) | pp <- props, qp <- props, rp <- doubleRulePairs,
                               let (r, n) = rp,
                               let (p, o) = pp,
                               let (q, s) = qp]

apply :: [(Expr, (String, Expr))] -> [Line]
apply props = nub (props ++ applySingle props ++ applyDouble props)

resolve :: [Line] -> [[Line]]
resolve = unfoldr (Just . join (,) . apply)

isValid :: [Expr] -> Expr -> Bool
isValid ps c = elem c . map fst . concat . resolve . addSups $ ps

addSups = map (\p -> (p, ("S", p)))

prove ps conc = go conc []
  where go seed res = if elem (prev line) ps
                      then (prettify ps) ++ ((pretty line) : res)
                      else go (prev line) ((pretty line) : res)
          where line = findLine seed
                findLine p = val . find (\b -> (prem b) == p) . concat $ rose
                findConclusion b = all (not . (\a -> (prem a) == conc)) b
                rose = takeWhileInclusive findConclusion (resolve (addSups ps))
                prettify = map (\p -> (p, "S"))
                pretty (a, (b, c)) = (a, b)

main :: IO ()
main = mapM_ print $ prove

       [ (Not (Not (If A B))),
         (And (Not (Not (Not B))) (Not C)) 
       ] (Not A)
