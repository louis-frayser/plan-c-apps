(include "lib.scm" )

(define *categories 
  '("Engineering" "Fitness" "Life" "Maitenance" "Media"
    "MusicPractice" "PIM"))
(define *category (list-ref *categories 0))


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






