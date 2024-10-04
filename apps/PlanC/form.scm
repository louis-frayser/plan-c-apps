(include "list.scm")

(define demouiform:example
  (list->table `(
		 (main
		  "Plan C"
		  ("Activity Entry" catsel)
		  ("About" about)
		  (spacer height 200)
		  (label text "Hello from LambdaNative" size header)
		  (spacer)
		  ;; Show an image (file listed in EMBED)
		  (image file "LN_logo.png"))

		 ;;; Category Selection
		 (catsel
		  "Categories"
		  ("Back" main)
		  #f
		  (spacer)
		  ;; Dropdown
		  (dropdown id category
			    label "Pick a category:"
			    entries ,*categories)
		  ,(lambda () (set! *category (dbget 'category)) '(spacer))
		  ,(lambda ()
		     (if *category
			 `(button text "Continue" action ,(lambda () 'widgets))
			 '(spacer))))

		 ;;; Activity selection and detail entry
		 (widgets
		  "Activities"
		  #f
		  ("Cancel" main)
		  (spacer)

		  ;; Show Category
		  ,(lambda () (set! *category (dbget 'category))
			   (let ((s (if *category
					(string-append "Category: " *category)
					"Go select a category!")))
			     `(label text ,s)))
		  (spacer)

		  ;; Activity selection
		  ,(lambda () (set! *category (dbget 'category))
			   (if *category
			       ;; Dropdown
			       `(dropdown id activity
					  label "Pick an activity:"
					  entries ,(activities-for-category ))

			       ;; Button with action callback that returns the page you want to go to
			       `(button h 75
					size header
					indent 0.05
					rounded #t
					text "Select a Category 1st!"
					action ,(lambda () 'catsel))))
		  (spacer)

		  ;; Start Time
		  (dateentry text "Date:" indent 0.4 id sdate)
		  (timeentry text "Time:" indent 0.4 id stime-only)
		  (spacer)

		  ;; Duration
		  (timeentry text "Duration:" indent 0.4 id duration)

		  ;; Apply defaults
		  , (lambda ()
		      (unless (dbget 'sdate)
			(let ((d (current-date *tz)))
                          (dbset 'sdate (date->string d "~Y-~m-~d"))
			  (dbset 'stime-only (date->string d "~H:~M") )
			  (dbset 'duration "00:36")))
		      `(spacer))

		    ;; Submit
		    (button text "Submit"
			    action
			    ,(lambda()
			       (if  (dbget 'activity)
				    (let* ((ctm (current-date-local-string))
					   (cat (dbget 'category))
					   (act (dbget 'activity))
					   (sdt (string-append
						 (dbget 'sdate) " " (dbget 'stime-only)))
					   (dur (dbget 'duration)))
				      (dbstore ctm cat act sdt dur )
				      'main)
				    #f)))
		    (spacer)
;;; About
		    (about
		     "About"
		     ("Back" main)
		     #f
		     (spacer height 50)
		     (label text "Plan-C App - time-tracking for musicians. Based on the uiform module in LambdaNative, a cross-platform development environment written in Scheme. See lambdanative.org")
		     (spacer)
		     (label text "Copyright (c) 2024 Louis Frayser <louis.frayser@gmail.com>"))
		    ))))
