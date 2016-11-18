# :computer: Propositional Derivation Machine

I wrote this library to do my Philosophy 201 (Introductory Logic) homework for me.

For a good description of propositional logic, see this page: https://en.wikipedia.org/wiki/Propositional_calculus

What we want is to give the program a book problem, and for the derivation machine to prove that it is true. The program lazily builds an infinite tree of logical sentences which "follow" from the given premises. Once it generates something that remembles the conclusion it walks backwards to the root and prints the result.

---

A simple book problem in Haskell syntax (a list of premises and a conclusion):

```
[ (If A B),
  (Not B) 
] (Not A)
```

This conclusion follows from the premises by the simple but unintuaitive rule called "modus tollendo tollens." Haskell gives us the answer:

```
1  "If A B"  S  
2  "Not B"   S  
3  "Not A"   1,2 MTT
(0.03 secs, 149,584 bytes)
```

Although this is an elementary example, the derivation machine can do all propositional derivations that involve the *simple rules*. And now we have no more homework for first term!

---

Disclaimer: do your homework.

---

~~Will it be slow?~~

It's fast as hell!
