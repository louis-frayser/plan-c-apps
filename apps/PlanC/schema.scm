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

(define (db-get-last)
  ;; Get the last record or #f
  (let ((recset
         (sqlite-query
          (get-db)
          "SELECT * \
           FROM assocs \
           WHERE stime = (SELECT MAX(stime) FROM assocs);")))
    (if (null? recset)  #f (car recset))))
