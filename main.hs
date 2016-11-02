dne ("not", ("not", c)) = (c)
dni p = ("not", ("not", p))
ael (a, "and", c) = (a)
aer (a, "and", c) = (c)
ai p q = (p, "and", q)
-- mpp ("if", a, "then", b) c = if a == c then b else ""
-- mtt ("if", a, "then", b) ("not", c) = if b == c then ("not", a) else ""

rules = [dne, dni, ael, aer, ai, mpp, mtt]

prove props c = go props rules []
  where go (p:ps) (r:rs) next
          | res == c = "proven"
          | null rs = go ps rules next
          | null ps = go next rules []
          | otherwise = go ps rs (next : res)
          where res = r p

main = print $ prove [("not", ("not", ("a")))] ("a")
