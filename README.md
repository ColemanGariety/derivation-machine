# derivation machine

This is a WIP truth-functional logic library written in Scheme as a learning exercise.

Question: when proving that a conclusion follows from some premises, how do we know when we are approaching our goal or getting further away?

The brute-force method is simply to try to apply every truth functional rule in every combination to our premises ad infinitum until we reach our conclusion.

~~Will it be slow?~~

It's fast as hell!

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
