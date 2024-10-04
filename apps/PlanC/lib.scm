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
(define %user% "frayser")
(define %dbpath (string-append (system-directory) "/plan-c-sqlite.db"))
(define (current-date-local-string)
  (date->string (current-date *tz) "~Y-~M-~d ~H:~M"))

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
