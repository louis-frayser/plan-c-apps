;;; =================================================================
;;; ----------------- Lists ------------------------------------
(define (null-list? xs)(eq? xs '()))
(define null? null-list?)

;;; srfi-1
(define (list-index pred lis1 . lists)
  #;(check-arg procedure? pred list-index)
  (if (pair? lists)

      ;; N-ary case
      (error "This #'list-index only hadles one list!")
      #;(let lp ((lists (cons lis1 lists)) (n 0))
      (receive (heads tails) (%cars+cdrs lists)
      (and (pair? heads)
      (if (apply pred heads) n
      (lp tails (+ n 1))))))

      ;; Fast path
      (let lp ((lis lis1) (n 0))
        (and (not (null-list? lis))
             (if (pred (car lis)) n (lp (cdr lis) (+ n 1)))))))
;;; .............................................................
; str-split : Apr 2006 Doug Hoyte, hcsw.org.
;;; ----
;;; Splits a string 'str into a list of strings
;;; that were separated by the delimiter character 'ch
;;; ----
;;; Efficient as possible given that we can't count on
;;; 'str being an immutable string.
(define (string-split str ch)
  (let ((len (string-length str)))
    (letrec
      ((split
        (lambda (a b)
          (cond
            ((>= b len) (if (= a b) '() (cons (substring str a b) '())))
              ((char=? ch (string-ref str b)) (if (= a b)
                (split (+ 1 a) (+ 1 b))
                  (cons (substring str a b) (split b b))))
                (else (split a (+ 1 b)))))))
                  (split 0 0))))
;;; .............................................................
(define fourth cadddr)
(define (fifth xs) (car (cddddr xs)))

;;; ----------------- Settings------------------------------------
(define *tz -25200) ;; offset in seconds from UTC
(define %user% "frayser")
(define %dbpath (string-append (system-directory) "/plan-c-sqlite.db"))
;;; =================================================================
;;; ------------------ Misc ---------------------------------------
;; System IO
(define (current-date-local-string)
  (date->string (current-date *tz) "~Y-~m-~d ~H:~M"))

(define (displayln o) (display o ) (newline))
;; Formatting
(define (number->string2 n)
  (let ((s (number->string n)))
    (if (<= n 9)
       (string-append "0" s)
       s)))
;; -----------------------------------------------------------------
;; Math
(define (quotient/remainder num den)
  (values (quotient num den) (remainder num den)))

;; -----------------------------------------------------------------
;; Data
(define (string-time+ .  strings)
  (with-exception-handler
     (lambda(exn)(error "string-time+:" strings  exn))
     (lambda ()
       (let*((lists (map (lambda(s) (string-split s #\:)) strings))
          (nlists (map (lambda(ls)(map string->number ls)) lists))
          (mins-ea (map (lambda(nlist)
                          (+ (* 60 (car nlist)) (cadr nlist))) nlists))
          (tmins (apply + mins-ea)))
        (call-with-values
         (lambda()(quotient/remainder tmins 60))
         (lambda(hrs mins)
           (string-append
            (number->string2 hrs) ":" (number->string2 mins))))))))

;;; ------------------------ Strings -------------------------------
(define (setw string width)
  (define w (string-length string))
  (cond
    ((< w width) (string-append string  (make-string  (- width w) #\_)))
    ((> w width) (substring string 0 width))
    (else string)))
