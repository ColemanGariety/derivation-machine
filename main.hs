-- import qualified Data.Map as Map

import Control.Monad
import Data.List
import Data.Maybe

-- import Debug.Trace

data Expr = Nil | Phrase String | Not Expr | And Expr Expr | Or Expr Expr
          deriving (Show, Eq)

type Rule = Expr -> Maybe Expr

type Line = (Maybe Expr, String)

fst' (x,_,_) = x

dne :: Rule
dne (Not (Not p)) = Just p
dne _ = Nothing

dni :: Rule
dni = Just . Not . Not

rulePairs :: [(Rule, String)]
rulePairs = [(dne, "DNE"), (dni, "DNI")]

-- catMaybeFst :: [(Maybe a, t)] -> [(Maybe a, t)]
catMaybeFst ls = [(x, y) | (Just x, y) <- ls]

-- apply :: [Expr] -> [Line]
apply props = catMaybeFst [(r p, n) | pp <- props, rp <- rulePairs,
                           let (r, n) = rp,
                           let (p, o) = pp]

-- resolve :: [Expr] -> [Line]
resolve = concat . unfoldr (Just . join (,) . apply)

doesFollow ps c = elem c (map fst (resolve (map (\p -> (p, "S") ) ps)))

main :: IO ()
main = print $ doesFollow [(Phrase "a"), (Not (Not (Phrase "c")))] (Not (Not (Phrase "c")))
