(include "schema.scm")

;;; Main Page
(define &main-page
  `(main
    "Plan X"
    ("About" about)
    ("Activities" catsel)
    (spacer height 200)
    (label text "Hello from LambdaNative" size header)
    (spacer)
    ;; Show an image (file listed in EMBED)
    (image file "LN_logo.png")))

(define &entry-page
;;; Category Selection
  `(catsel
    "Activities"
    ("Back" main)
    ("History" history)

    (spacer)
    (label text "For a New Activity..." size header)
    ;; Dropdown
    (dropdown id category
	      label "Pick a category:"
	      entries ,*categories)
    ,(lambda () (set! *category (dbget 'category)) '(spacer))
    ,(lambda ()
       (if (dbget 'category)
	   `(button text "Continue" action ,(lambda () 'widgets))
	   '(spacer)))))

(include "activities.scm")

(define &about-page
    ;;; About
  `(about
    "About"
    ("Back" main)
    #f
    (spacer height 50)
    (label text ,(string-append
		  "Plan-C App - time-tracking for musicians. "
		  "Based on the uiform module in LambdaNative, "
		  "a cross-platform development environment "
		  "written in Scheme. See lambdanative.org"))
    (spacer)

    (label text "Copyright (c) 2024 Louis Frayser <louis.frayser@gmail.com>")))

(define &history-page
    `(history
      "Activity History"
      ("Activity" catsel)
      #f
      (spacer)
      (list entries ,(db-get-history-lines))))


(define demouiform:example
  (list->table `(,&main-page
		 ,&entry-page      ;; Reads the Category when adding a new record to the db.
		 ,&activities-page ;; Detail entry of a new record.
		 ,&about-page
		 ,&history-page)))  ;; a list of all records
