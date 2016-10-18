(define-library (follows)

  (import (scheme base)
          (scheme write)
          (scheme eval)
          (srfi 1))

  (export derive)
  
  (begin

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; RULES                   ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    
    ;; DOUBLE-NEGATION INTRODUCTION
    (define (dni? p) #t)

    (define (dni p) (list 'not (list 'not p)))

    
    ;; DOUBLE-NEGATION ELIMINATION
    (define (dne? p)
      (and (eq? 'not (car p))
           (eq? 'not (caar (cdr p)))))

    (define (dne p)
      (car (cdr (car (cdr p)))))


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; BASICS                  ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; the simple rules
    (define simple-rules (list dni dne)) ;; andi ande ori ore mpp mtt bce bci))

    ;; determine if non-truth-functional
    (define (molecular? p)
      (let ((sym (car p)))
            (if (pair? p)
                (if (member sym simple-rules)
                    #t
                    (error "Symbol does not belong to simple rules:" sym))
                #f)))

    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; DERIVATIONS             ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (define (make-tree premises conclusion)
      (let loop ((ps premises)
                 (sr simple-rules)
                 (x 0)
                 (y 0)
                 (tree '()))
        (if (eq? (apply (car sr) (list (car premises))) conclusion)
            #t
            (if (pair? sr)
                (loop ps
                      (cdr sr)
                      0
                      y
                      tree)
                (if (pair? ps)
                    (loop (cdr ps)
                          simple-rules
                          (+ x 1)
                          y)
                    #f))))) ;; here we need to go one level deeper in the tree
                            ;; premises become the wides row of the tree
                            ;; x and sr reset
                            ;; y + 1

    ;; list, sexp|string -> list
    ;; derive a conclusion from some premises
    (define (derive premises conclusion)
      (let add-sups ((suppositions premises)
                 (result '())
                 (n 1))

        ;; add premises as suppositions
        (if (pair? suppositions)
            (add-sups (cdr suppositions)
                      (append result (list (list n "S")))
                      (+ n 1))

            (make-tree premises conclusion))))))
