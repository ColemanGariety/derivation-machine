# derivation machine

This is a WIP truth-functional logic library written in Scheme as a learning exercise.

Question: when proving that a conclusion follows from some premises, how do we know when we are approaching our goal or getting further away?

The brute-force method is simply to try to apply every truth functional rule in every combination to our premises ad infinitum until we reach our conclusion.

Will it be slow?

What we want is to give the program this sexp:

((if a b)
 (if b c)
 a
 c)

and get a list:

(((if a b) (S))
 ((if b c) (S))
 (a        (S))
 (b        (1 3 MPP))
 (c        (2 4 MPP)))
