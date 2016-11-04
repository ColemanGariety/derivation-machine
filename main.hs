-- import qualified Data.Map as Map

import Control.Monad
import Data.List
import Data.Maybe

-- import Debug.Trace

data Expr = Nil | Phrase String | Not Expr | And Expr Expr | Or Expr Expr
          deriving (Show, Eq)

type Rule = Expr -> Maybe Expr

dne :: Expr -> Maybe Expr
dne (Not (Not p)) = Just p
dne _ = Nothing

dni :: Expr -> Maybe Expr
dni = Just . Not . Not

rules :: [( Expr -> Maybe Expr, String)]
rules = [(dne, "DNE"), (dni, "DNI")]

apply :: [Expr] -> [Expr]
apply props = catMaybes [r p | p <- props, r <- (map fst rules)]

resolve :: [Expr] -> [Expr]
resolve = concat . unfoldr (Just . join (,) . apply)

main :: IO ()
main = print $ take 10 (resolve [Not (Not (Not (Not (Not (Not (Phrase "a"))))))])
