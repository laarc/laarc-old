
(define-global env (get (require 'system) 'get-environment-variable))

(define-global home        (env 'laarc_home))
(define-global stdin-tty?  (env 'laarc_stdin_tty))
(define-global stdout-tty? (env 'laarc_stdout_tty))

;; Base.

(define-macro eval-now l
  (eval `(do ,@l))
  `(do ,@l))

(eval-now

  (when (get (last environment) 'laarc)
    (drop environment))
  (add environment (obj :laarc)))

(define-macro eval-now l
  (eval `(do ,@l))
  `(do ,@l))

(define-macro during-compile l
  (eval `(do ,@l))
  nil)

(eval-now

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

(eval-now

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

(eval-now

  (define-global parse-args (xs inits)
    (if (atom? xs) xs
      (with l ()
        (let (rest? nil
              kwargs ())
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
                     (if rest?
                         (add kwargs k)
                         (add l k)))
              (error "todo")))
          (if (= rest? true) (error ". in an arg list must be followed by an atom")
            (step k kwargs
              (set (get l k) true)
              (add inits `(wipe (get ,rest? ',k))) ))))))

  (define-global parse-body (xs)
    (if (atom? xs) xs
      (with l ()
        (each (k v) xs
          (if (number? k)
            (add l (parse-body v))
            (set (get l k) (parse-body v)))))))
)

;; Arc.

(define-macro mac (name args rest: body)
  (let inits ()
    `(define-macro ,name ,(parse-args args inits)
       ,@inits
       ,@(parse-body body))))

(define-macro def (name args rest: body)
  (if (none? body)
    `(define-global ,name ,args)
    (let inits ()
      `(define-global ,name ,(parse-args args inits)
         ,@inits
         ,@(parse-body body)))))

(define-macro var (name args rest: body)
  (if (none? body)
    `(define ,name ,args)
    (let inits ()
      `(define ,name ,(parse-args args inits)
         ,@inits
         ,@(parse-body body)))))

(define-macro sym l `(define-symbol ,@l)) 

(sym t true)
(sym len lumen-len)

(mac is l
  (case (len l)
    0 `true
    1 `(is? ,@l)
    2 `(lumen-eq ,@l)
    `(and ,@(map3 (fn (x y) `(is ,x ,y))
                  l))))

(eval-now

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

(def readstr (x more :reader)
  (let r (if (is reader true) (require 'ac-reader) r)
    (let s ((get r 'stream) x more)
      (map (fn (x) (if (atom? x) x
                       (is (hd x) '%list) (tl x)
                     x))
           ((get r 'read-all) s)))))

(def %run    (get (require 'compiler) 'run))
(def %expand (get (require 'compiler) 'expand))

(def macex (expr)
  (%expand expr))

(def ac-compile (expr)
  (compile (macex expr)))

(def ac-compile-str (s)
  (compile (macex `(do ,@(readstr s)))))

(def ac-compile-file (file)
  (ac-compile-str (filechars file)))

; todo: multiple ac-load's of the same file should re-eval the file.
(def ac-load (file)
  (let code (ac-compile-file file)
    (when (env "VERBOSE")
      (print (cat "\n> (ac-load " file ")"))
      (print code))
    ; (%run code)))
    (let (parts (split file ".")
          name (hd parts)
          ext (last parts))
      (unless (= ext 'la) (error "todo: non-.la files"))
      (unless (two? parts) (error "todo: filepaths containing multiple dots"))
      (let filename (cat name "." (language))
        ((get (require 'system) 'write-file) filename code)
        (require (last (split name "/")))))))


;; Helpers.

(mac prdo l
  `(do ,@(map (fn (x) `(print (cat "> " (lumen-str ',x) "\n"
                                   (lumen-str ((fn () ,x))))))
              l)))
       ;nil))

(def endswith (s ending)
  (let i (- (len s) (len ending))
    (is i (search s ending i))))

(def startswith (s prefix)
  (is (search s prefix) 0))

;; Main.

(define-global pp (x)
  (print (str x)))

(target lua:
  (let ((ok req) (guard (require 'require)))
    (when ok
      (define-global require (req "/"))
      (eval '(define-global require ((require 'require) "/")))
      (define-global ppr (get (require 'pretty-print) 'prettyPrint))
      (define-global pp (x)
        (if (string? x) (print x)
          (ppr x)))
      ((get compiler 'run) """
ffi = require('ffi')
ffi.cdef[[int fcntl(int fildes, int cmd, ...);]]
ffi.cdef[[static const int F_GETFL= 3;/* get file status flags */]]
ffi.cdef[[static const int F_SETFL= 4;/* set file status flags */]]
ffi.cdef[[static const int O_NONBLOCK	= 0x0004;		/* no delay */]]
local flags = ffi.C.fcntl(0, ffi.C.F_GETFL, 0)
bit = require("bit")
flags = bit.bxor(flags, ffi.C.O_NONBLOCK)
ffi.C.fcntl(0, ffi.C.F_SETFL, flags)
"""))))

(let args (get (require 'system) 'argv)
  (for i (len args)
    (var arg (at args i))
    (if (endswith arg '.la)
         (ac-load arg)
        (is arg "test")
         (do (ac-load (cat home "/test.la"))
             (test))
        (is arg "-e")
         (do (inc i)
             (%run (ac-compile-str
                     (cat "(set %result "
                          (with s ""
                            (step x (cut args i)
                              (cat! s " " x)))
                       ")")))
             (when (is? %result)
               (pp %result)))
      (%run arg))))





