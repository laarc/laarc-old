
;; Base.

(define-macro during-compile-and-run l
  (eval `(do ,@l))
  `(do ,@l))

(during-compile-and-run

  (when (get (last environment) 'laarc)
    (drop environment))
  (add environment (obj :laarc)))

(define-macro during-compile-and-run l
  (eval `(do ,@l))
  `(do ,@l))

(define-macro during-compile l
  (eval `(do ,@l))
  nil)

(during-compile

  (define-global compiler (require 'compiler))

  (define-global print-compiled (expr)
    (print (compile ((get compiler 'expand) `(do ,expr))))
    expr)

  (define-global print-env ()
    (step frame environment
      (print "----------------")
      (each (k v) frame
        (print (cat (str k) ": " (str v))))))

  (define-global map3 (f lst)
    (with r ()
      (for i (# lst)
        (when (> i 0)
          (add r (f (at lst (- i 1))
                    (at lst i)
                    (at lst (+ i 1))))))))
)

(define-macro arc-toplevel? ()
  `(two? environment))

;; Arc.

(define-macro mac l `(define-macro ,@l))
(define-macro sym l `(define-symbol ,@l)) 
(define-macro var l `(define ,@l))
(define-macro def l `(during-compile-and-run
                       (define-global ,@l)))

(sym t true)

(sym lumen-eq     (do =))
(sym lumen-assign (do set))
(sym lumen-len    (do #))
(sym lumen-str    (do str))
(sym lumen-cat    (do cat))

(mac is l
  (case (lumen-len l)
    0 `t
    1 `(is? ,@l)
    2 `(lumen-eq ,@l)
    `(and ,@(map3 (fn (x y) `(is ,x ,y))
                  l))))

(during-compile
  (define-global is-var? (x)
    (step frame environment
      (let u (get frame x)
        (when (and (is? u) (is? (get u 'variable)))
          (return true))))))

(mac = l 
  (with e '(do)
    (let final nil
      (step (x y) (pair l)
        (set final x)
        (unless (is-var? x)
          (add e `(,(if (arc-toplevel?) 'def 'var) ,x nil)))
        (add e `(lumen-assign ,x ,y)))
      (add e final))))

;; Testing.

(mac prdo l
  `(do ,@(map (fn (x) `(print (cat "> " (lumen-str ',x) "\n"
                                   (lumen-str ((fn () ,x))))))
              l)
       nil))

(def test-check (s x y)
  (unless (lumen-eq (lumen-str x) (lumen-str y))
    (print (cat s ": Expected " (lumen-str x) ", got " (lumen-str y)))))


(mac testing l
  (with e '(do)
    (step (expect expr) (pair l)
      (add e `(prdo ,expr))
      (add e `(test-check (lumen-str ',expr) ,expect (eval '(do ,expr)))))))


(def test ()
  (testing 
        t (is)
        t (is 1)
        t (is 1 1)
    false (is 1 2)
        t (is 1 1 1)
    false (is 1 1 2)
       42 (= x 42)
        t (is x 42)
        7 (= x 99
             y 7)
        t (is x 99)
        t (is y 7)))


