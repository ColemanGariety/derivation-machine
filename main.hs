import Debug.Trace

data Expr = Phrase String | Not Expr | And Expr Expr | Or Expr Expr
          deriving (Show, Eq)

dne (Not (Not p)) = p
dni p = (Not (Not p))

rules = [dne, dni]

prove props = go props rules []
  where go (p:ps) (r:rs) next
          | res == (last props) = "proven"
          | null rs = go next rules next
          | null ps = go next rs []
          | otherwise = go ps rs (next ++ [res])
          where res = r p

main = print $ prove [(Not (Not (Not (Not (Phrase "a"))))), (Phrase "a")]
