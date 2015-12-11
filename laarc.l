
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

(during-compile-and-run

  (define-global do-list (f xs)
    (when (and (is? xs) (some? xs))
      (for i (# xs)
        (let x (at xs i)
          (unless (= x '%list)
            (if (= x '%kv)
                (let (k (at xs (+ i 1))
                      v (at xs (+ i 2)))
                  (inc i 2)
                  (f k v))
                (= x ".")
                (let (k 'rest
                      v (at xs (+ i 1)))
                  (inc i 1)
                  (f k v))
              (f x)))))))

  (define-macro step-list (x ys rest: body)
    `(do-list (fn ,x ,@body) ,ys))

  (define-global parse-list (xs)
    (if (atom? xs) xs
      (with l () 
        (step-list (k v) xs
          (let k (parse-list k)
            (if (is? v)
              (set (get l k) (parse-list v))
              (add l k)))))))

  (define-global parse-args (xs inits)
    (if (atom? xs) xs
      (with l ()
        (step-list (k v) xs
          (if (nil? v)
               (add l (parse-args k inits))
              (= k 'rest)
               (set (get l 'rest) (parse-args v inits))
              (atom? k)
               (do (add inits `(if (nil? ,k) (set ,k ,v)))
                   (add l (parse-args k inits)))
              (error "todo"))))))
)

(define-macro %list l
  (parse-list l))

;; Arc.

(define-macro mac (name args rest: body)
  (let inits ()
    `(define-macro ,name ,(parse-args args inits)
       ,@inits
       ,@body)))

(define-macro def (name args rest: body)
  (if (none? body)
    `(define-global ,name ,args)
    (let inits ()
      `(define-global ,name ,(parse-args args inits)
         ,@inits
         ,@body))))

(define-macro var (name args rest: body)
  (if (none? body)
    `(define ,name ,args)
    (let inits ()
      `(define ,name ,(parse-args args inits)
         ,@inits
         ,@body))))

(define-macro sym l `(define-symbol ,@l)) 

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

(def filechars (get (require 'system) 'read-file))

(def lumen-readstr (x more)
  (let reader (require 'reader)
    (let s ((get reader 'stream) x more)
      ((get reader 'read-all) s))))

(def readstr (x more)
  (let reader (require 'ac-reader)
    (let s ((get reader 'stream) x more)
      (map (fn (x) (if (atom? x) x
                       (is (hd x) '%list) (tl x)
                     x))
           ((get reader 'read-all) s)))))

(def %run    (get (require 'compiler) 'run))
(def %expand (get (require 'compiler) 'expand))

(def macex (expr)
  (%expand expr))

(def ac-compile-file (file)
  (compile (macex `(do ,@(readstr (filechars file))))))

(def ac-load (file)
  (let x (ac-compile-file file)
    (print x)
    (%run x)))


;; Helpers.

(mac prdo l
  `(do ,@(map (fn (x) `(print (cat "> " (lumen-str ',x) "\n"
                                   (lumen-str ((fn () ,x))))))
              l)
       nil))

