;;; ------------------------------------------------------------
;;; Activities
;;; Global variables and constants
;;; -----------------------------------------------------------
(include "lib.scm" )  ; <-- global general functions

(define *categories
  '("Engineering" "Fitness" "Life" "Maitenance" "Media" "MusicPractice" "PIM"))

;;; Current Category
(define *category (list-ref *categories 0))

;;; Global to hold the corrent actvity
;;; Or false so indicate a new activity is being created
(define *current-activity #f)

(define (actions-by-cat-ix i)
  (list-ref
   '(("CM" "Debug" "R&D" "ProjMgmt" "Programming" "Study" "SysAdm" "Testing")
     ("Dance" "Other" "Pull-Ups" "Walking" "Yoga")
     ("Cooking" "Dining" "Sleep/Nap" "SSS" "Social Entertainment" "Social Other")
     ("Clean House" "Laundry" "Misc" "Instrument Maint.")
     ("Movies/AV" "News" "Non-Fiction" "Production" "Research" "Social" "Study")
     ("Cello" "Clarinet" "Flute" "Guitar" "Other Inst" "Other Listenng"
      "Percussion" "Piano/Kbd" "Recorder" "Trombone" "Trumpet/Flgl" "Violin" "Voice")
     ("Finance" "Music Prep" "Online Shopping" "Personal Tech" "Planning")) i))

(define (activities-for-category)
  ;; Activity list for currently selected Category
  (actions-by-cat-ix
   (list-index
    (lambda (s) (string=? s *category ) ) *categories)))

;;; =================================================================
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

(define (db-get-last)
  ;; Get the last record or #f
  (let ((recset
         (sqlite-query
          (get-db)
          "SELECT * \
           FROM assocs \
           WHERE stime = (SELECT MAX(stime) FROM assocs);")))
    (if (null? recset)  #f (car recset))))
