(define (null-list? xs)(eq? xs '()))

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

;;; Settings
(define *tz -25200) ;; offset in seconds from UTC
