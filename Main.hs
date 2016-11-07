import Control.Monad
import Data.List
import Data.Maybe

import Logic
import Util

apply :: [(Expr, t)] -> [Line]
apply props = catMaybeFst [(r p, (n, p)) | pp <- props, rp <- rulePairs,
                           let (r, n) = rp,
                           let (p, o) = pp]

resolve :: [Line] -> [[Line]]
resolve = unfoldr (Just . join (,) . apply)

addSups = map (\p -> (p, ("S", p)))

prettify = map (\p -> (p, "S"))
pretty (a, (b, c)) = (a, b)

isValid ps c = elem c . map fst . concat . resolve . addSups $ ps

prove ps conc = go conc []
  where go seed res = if elem (prev line) ps
                      then (prettify ps) ++ ((pretty line) : res)
                      else go (prev line) ((pretty line) : res)
          where line = findLine seed
                findLine p = val . find (\b -> (prem b) == p) . concat $ rose
                findConclusion b = all (not . (\a -> (prem a) == conc)) b
                rose = takeWhileInclusive findConclusion (resolve (addSups ps))

main :: IO ()
main = mapM_ print $ prove
       [
         (Not (Not (And (NM "a") (NM "b"))))
       ] (NM "b")
