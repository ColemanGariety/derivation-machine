# derivation machine

This is a WIP truth-functional logic library written in Haskell as a learning exercise.

What we want is to give the program these arguments:

```
[
  (If A B)
  A
] B
```

and get a list:

```
[
  (1, (If A B), (S 1))
  (2, A, (S 2))
  (3, B, (MPP 1 2))
]
```

It works through a brute force approach wherein all the rules are applied to all the props recursively until a solution is found. Then the tree is traversed to the beginning.

~~Will it be slow?~~

It's fast as hell!
