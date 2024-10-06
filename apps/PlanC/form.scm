(include "schema.scm")

;;; Main Page
(define &main-page
  `(main
    "Plan C"
    ("About" about)
    ("Activities" activity)
    (spacer height 200)
    (label text "Hello from LambdaNative" size header)
    (spacer)
    ;; Show an image (file listed in EMBED)
    (image file "LN_logo.png")))

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

(define mainform
  (list->table `(,&main-page
		 ,&activities-page ;; Detail entry of a new record.
		 ,&about-page
		 ,&history-page)))  ;; a list of all records
