# derivation machine

This is a WIP truth-functional logic library written in Haskell as a learning exercise.

What we want is to give the program these arguments:

```
[
  (If (NM A) (NM B))
  (NM A)
] (NM B)
```

and get a list:

```
[
  (1, (If (NM A) (NM B)), (S 1))
  (2, (NM A), (S 2))
  (3, (NM B), (MPP 1 2))
]
```

It works through a brute force approach wherein all the rules are applied to all the props recursively until a solution is found. Then the tree is traversed to the beginning.

~~Will it be slow?~~

It's fast as hell!
