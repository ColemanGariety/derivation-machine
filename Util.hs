module Util where

import Data.List
import Text.PrettyPrint.Boxes

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

val :: Maybe t -> t
val (Just a) = a

addSups :: [t] -> [(t, ([Char], [t]))]
addSups = map (\p -> (p, ("S", [p])))

addNumbers proof = zip [1..] (map (\(a,(b,c)) -> (a,(b, map (\x -> val (findIndex (\y -> y == x) numbers) + 1) c))) proof)
  where numbers = map fst proof

prettyProof xs = printBox $ hsep 2 left (map (vcat left . map text) (transpose [[show a, show b, intercalate "," (map show d) ++ " " ++ c] | (a,(b,(c,d))) <- xs]))
