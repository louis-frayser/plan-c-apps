(define (null-list? xs)(eq? xs '()))
;;; ----------------- Lists ------------------------------------
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

;;; ----------------- Settings------------------------------------
(define *tz -25200) ;; offset in seconds from UTC
(define %user% "frayser")
(define %dbpath (string-append (system-directory) "/plan-c-sqlite.db"))

;;; ------------------ Misc ---------------------------------------
(define (current-date-local-string)
  (date->string (current-date *tz) "~Y-~m-~d ~H:~M"))


;;; -------------- Database ----------------------------------------
;;; The on-disk database
;;; Verify an open db with tables created
(define *_db #f)
(define (get-db)
  (unless *_db
    (set! *_db (sqlite-open %dbpath))
    (let* ((sql "SELECT name FROM sqlite_master
               WHERE type='table' AND name='assocs';")
	   (tabs (sqlite-query *_db sql)))
      (when (null-list? tabs)
	(sqlite-query
	 *_db
	 (string-append
	  "CREATE TABLE assocs("
	  " ctime timestamp,"
	  " category varchar(25),"
	  " activity varchar (25),"
	  " stime timestamp,"
	  " duration timestamp,"
	  " usr varchar (25)"
	  ");")))))
    *_db)

(define (dbstore ctime cat act stm dur)
  (define (qq s)( string-append "'" s  "', " ))
  (let ((sql
	 (string-append
	  "INSERT INTO assocs"
	  " VALUES ("
	  (apply string-append (map qq (list ctime  cat  act  stm dur )))
	  "'" %user% "' );")))
	(sqlite-query (get-db) sql)))

;;; Read the entire database
(define (get-assocs) ; Return list of lists
  (sqlite-query (get-db)
		 "SELECT ctime, category, activity,stime, duration \
                           FROM assocs \

                          ORDER by stime desc;"))


(define (db-get-history-lines)
  ;; Data for a list widget.  Hope it has a monspace font.
  ;; ctime,cat,act,stime,dur -> stime,activity,duration
  ;; Provides stime,activity,duration
  (let* ((raw-data (map cddr (get-assocs)))
	 (->s-a-d (lambda (r)(list (setw (cadr r) 20) (setw (car r) 24) (caddr r) )))
	 (rows (map ->s-a-d raw-data))
	 ;;(rows raw-data)
	 ;;(sw (lambda(s)(setw s 16))) ; Width of a date-time field is 16
	 (row2line (lambda(r)(string-mapconcat r " " )))
	 (lines (map row2line rows)))
    lines ))

;;; ------------------------ Strings -------------------------------
(define (setw string width)
  (define w (string-length string))
  (cond
    ((< w width) (string-append string  (make-string  (- width w) #\_)))
    ((> w width) (substring string 0 width))
    (else string)))
