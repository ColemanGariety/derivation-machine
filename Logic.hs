module Logic where

data Expr = Nil | NM String | Not Expr | And Expr Expr | Or Expr Expr | If Expr Expr | Iff Expr Expr | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
          deriving (Show, Eq)

type Rule = Expr -> Maybe Expr
type DoubleRule = Expr -> Expr -> Maybe Expr

type Line = (Expr, (String, Expr))

-- Double Negation Elimination
dne :: Rule
dne (Not (Not p)) = Just p
dne _ = Nothing

-- Double Negation Introduction
dni :: Rule
dni = Just . Not . Not

-- Left And Elimination
ael :: Rule
ael (And p q) = Just p
ael _ = Nothing

-- Right And Elimination
aer :: Rule
aer (And p q) = Just q
aer _ = Nothing

-- Left If and Only If Elimination
iffel :: Rule
iffel (Iff p q) = Just (If p q)
iffel _ = Nothing

-- Right If and Only If Elimination
iffer :: Rule
iffer (Iff p q) = Just (If q p)
iffer _ = Nothing

-- Modus Ponendo Ponens
mpp :: DoubleRule
mpp (If p q) r = if p == r then Just q else Nothing
mpp _ _ = Nothing

-- And Introduction
ai :: DoubleRule
ai p q = Just (And p q)

-- Modus Tonendo Tollens
mtt :: DoubleRule
mtt (If p q) (Not r) = if q == r then Just (Not p) else Nothing
mtt _ _ = Nothing

-- Left Disjunctive Syllogism
dsl :: DoubleRule
dsl (Or p q) (Not r) = if p == r then Just q else Nothing
dsl _ _ = Nothing

-- Right Disjunctive Syllogism
dsr :: DoubleRule
dsr (Or p q) (Not r) = if q == r then Just p else Nothing
dsr _ _ = Nothing

rulePairs :: [(Rule, String)]
rulePairs = [(dne, "DNE"), (dni, "DNI"), (ael, "AE"), (aer, "AE"), (iffel, "IFFE"), (iffer, "IFFE")]

doubleRulePairs :: [(DoubleRule, String)]
doubleRulePairs = [(mpp, "MPP"), (ai, "AI"), (mtt, "MTT")]
