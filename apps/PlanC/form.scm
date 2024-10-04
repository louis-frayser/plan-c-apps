(include "schema.scm")

;;; Main Page
(define &main-page
  `(main
    "Plan C"
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
    ("History" #f)
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
  (let(( lines (string-mapconcat (get-assocs) " "  (lambda(s)
						     (setw s 16)))))
    `(history
      "Activity History"
      ("Activity" widgets)
      #f
      (list entries ,lines))))


(define demouiform:example
  (list->table `(,&main-page
		 ,&entry-page
		 ,&activities-page
		 ,&about-page
		 ,&history-page)))
