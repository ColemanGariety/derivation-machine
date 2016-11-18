import Control.Monad
import Data.List
import Data.Maybe
import Logic
import Util

applySingle :: [(Expr, t)] -> [Line]
applySingle props = catMaybeFst [(r p, (n, [p])) | pp <- props, rp <- rulePairs,
                                let (r, n) = rp,
                                let (p, o) = pp]

applyDouble :: [(Expr, t)] -> [Line]
applyDouble props = catMaybeFst [(r p q, (n, [p,q])) | pp <- props, qp <- props, rp <- doubleRulePairs,
                               let (r, n) = rp,
                               let (p, o) = pp,
                               let (q, s) = qp]

apply :: [Line] -> [Line]
apply props = props ++ applySingle props ++ applyDouble props

resolve :: [Line] -> [[Line]]
resolve = unfoldr (Just . join (,) . apply)

isValid :: [Expr] -> Expr -> Bool
isValid ps c = elem c . map fst . concat . resolve . addSups $ ps

-- prove :: [Expr] -> Expr -> [(Expr, [Char])]
prove :: [Expr] -> Expr -> [(Expr, (String, [Expr]))]
prove ps conc = nub $ go [conc] []
  where go seeds res = if length (intersect seeds ps) == length seeds
                       then (addSups ps) ++ res
                       else go (concatMap prev lines) (lines ++ res)
          where lines = map findLine seeds
                findLine p = val . find (\b -> (prem b) == p) . concat $ rose
                  where rose = takeWhileInclusive findConclusion (resolve (addSups ps))
                          where findConclusion b = all (not . (\a -> (prem a) == conc)) b

main :: IO ()
main = prettyProof . addNumbers $ prove

       [ (If R (Not P)),
         (Or Q P),
         (Or R (Not (Or Q P)))
       ] (Not P)
