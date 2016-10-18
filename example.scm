(import (scheme base)
        (scheme write)
        (follows))

;; 1 Suppose
;; 2 1 DNE
;; 
(display (derive '((if a b)
                   (if b c)
                   a)
                 'c))
