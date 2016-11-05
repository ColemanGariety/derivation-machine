-- import qualified Data.Map as Map
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

isValid ps c = elem c . map fst . concat . resolve . addSups $ ps

prove ps conc = go conc []
  where go seed res
          | elem (prev line) ps = (prettify ps) ++ ((pretty line) : res)
          | otherwise = go (prev line) ((pretty line) : res)
          where line = findLine seed
                pretty (a, (b, c)) = (a, b)
                findLine p = val . find (\b -> (prem b) == p) . concat $ rose
                rose = takeWhileInclusive (\b -> all (not . (\a -> (prem a) == conc)) b) (resolve (addSups ps))

main :: IO ()
main = mapM_ print $ prove
       [
         (Not (Not (And (NM "a") (NM "b"))))
       ] (NM "b")
