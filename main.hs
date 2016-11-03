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
  where go [] _ next = go next rules []
        go (_:ps) [] next = go ps rules next
        go px@(p:_) (r:rs) next
          | (traceShow p False) = "foo"
          | res == c = "proven"
          | otherwise = go px rs ([res] ++ next)
            where res = r p

main :: IO ()
main = print $ prove [(Not (Not (Not (Not (Phrase "a")))))] (Phrase "a")
