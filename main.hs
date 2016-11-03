-- import qualified Data.Map as Map
import Debug.Trace

data Expr = Nil | Phrase String | Not Expr | And Expr Expr | Or Expr Expr
          deriving (Show, Eq)

dne :: Expr -> Expr
dne (Not (Not p)) = p
dne _ = Nil

dni :: Expr -> Expr
dni p = Not (Not p)

rules :: [Expr -> Expr]
rules = [dne, dni]

prove :: [Expr] -> Expr -> String
prove props c = go props rules []
  where go [] _ [] = error "no props"
        go [] _ next = go next rules []
        go (p:ps) [] next = go ps rules (res:next)
          where res = (head rules) p
        go px (r:rs) next
          | (traceShow (head px) False) = "foo"
          | res == c = "proven"
          | otherwise = go px rs (res:next)
          where res = r (head px)

main :: IO ()
main = print $ prove [(Not (Not (Not (Not (Not (Not (Phrase "a")))))))] (Phrase "a")
