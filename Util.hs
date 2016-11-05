module Util where
-- 
takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []

catMaybeFst :: [(Maybe t, t1)] -> [(t, t1)]
catMaybeFst ls = [(x, y) | (Just x, y) <- ls]

prem :: (t, (t1, t2)) -> t
prem (a, (b, c)) = a

name :: (t, (t1, t2)) -> t1
name (a, (b, c)) = b

prev :: (t, (t1, t2)) -> t2
prev (a, (b, c)) = c

val (Just a) = a
