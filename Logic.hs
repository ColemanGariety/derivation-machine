module Logic where

data Expr = Nil | NM String | Not Expr | And Expr Expr
          deriving (Show, Eq)

type Rule = Expr -> Maybe Expr

type Line = (Expr, (String, Expr))

dne :: Rule
dne (Not (Not p)) = Just p
dne _ = Nothing

dni :: Rule
dni = Just . Not . Not

ael :: Rule
ael (And p q) = Just p
ael _ = Nothing

aer :: Rule
aer (And p q) = Just q
aer _ = Nothing

rulePairs :: [(Rule, String)]
rulePairs = [(dne, "DNE"), (dni, "DNI"), (ael, "AND ELIM"), (aer, "AND ELIM")]
