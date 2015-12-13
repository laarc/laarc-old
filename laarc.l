
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

(define-macro def? (x)
  (target
    lua: `(is? ,x)
    js:  `(not (= (typeof ,x) "undefined"))))

(during-compile-and-run
  (define-global %kv '(%kv))
  (define-global %nil '(%nil))
  (define-macro %nil ()
    `(do nil))

  (define-symbol lumen-eq     (do =))
  (define-symbol lumen-assign (do set))
  (define-symbol lumen-len    (do #))
  (define-symbol lumen-str    (do str))
  (define-symbol lumen-cat    (do cat)))

(define-macro arc-toplevel? ()
  `(two? environment))


(define-macro each (x t rest: body)
  (let-unique (o n i c)
    (let ((k v) (if (atom? x) (list i x)
                  (if (> (# x) 1) x
                      (list i (hd x)))))
      `(let (,o ,t ,c 0 ,k nil)
         (%for ,o ,k
           (if (> ,c 0)
             (dec ,c)
             (let (,v (get ,o ,k))
               (target js: (if (numeric? ,k) (set ,k (parseInt ,k))))
               (when (lumen-eq ,v %kv)
                 (set ,c 2)
                 (set ,v (get ,o (+ ,k 2)))
                 (set ,k (get ,o (+ ,k 1))))
               (when (lumen-eq ,v %nil)
                 (set ,v nil))
               ,@body)))))))

(define-macro for (i to rest: body)
  `(let ,i 0
     (while (< ,i ,to)
       ,@body
       (inc ,i))))

(define-macro step (v t rest: body)
  (let-unique (x n i c u)
    `(let (,x ,t ,n (# ,x) ,c 0)
       (for ,i ,n
         (when (>= ,i ,c)
           (let (,u (at ,x ,i))
             (when (lumen-eq ,u %nil)
               (set ,u nil))
             (if (lumen-eq ,u %kv) (set ,c (+ ,i 3))
               (let (,v ,u)
                 (do ,@body)))))))))

(define-macro list body
  (let-unique (x)
    (let (l () forms ())
      (each (k v) body
        (when (nil? v)
          ; (set v `',%nil)) ; todo
          (set v %nil))
        (if (number? k)
            (set (get l k) v)
          (add forms `(set (get ,x ',k) ,v))))
      (if (some? forms)
          `(let ,x (%array ,@l) ,@forms ,x)
        `(%array ,@l)))))

(during-compile-and-run

  (define-global parse-args (xs inits)
    (if (atom? xs) xs
      (with l ()
        (let rest? nil
          (each (k v) xs
            (when (number? k)
              (set k v)
              (set v nil))
            (if (nil? v)
                  (if (= rest? true)
                    (do (set (get l 'rest) (parse-args k inits))
                        (set rest? k))
                    (add l (parse-args k inits)))
                (= k 'rest)
                  (do (set (get l 'rest) true)
                      (set rest? true))
                (atom? k)
                 (do (add inits `(if (nil? ,k) (set ,k ,v)))
                     (if rest? (set (get l k) true)
                       (add l k)))
                (error "todo")))))))
)

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

(mac is l
  (case (lumen-len l)
    0 `true
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

