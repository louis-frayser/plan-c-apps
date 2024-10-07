;;; ------------------------------------------------------------
;;; Activities
;;; -----------------------------------------------------------
(define &activity-pulldown
  `    ;; Activity pulldown
  ,(lambda () (set! *category (dbget 'category))
	   (if *category
	       ;; Dropdown
	       `(dropdown id activity
			  label "Pick an activity:"
			  entries ,(activities-for-category ))

	       ;; Button with action callback that returns
	       ;; the page you want to go to
	       `(button h 75
			size header
			indent 0.05
			rounded #t
			text "Select a Category 1st!"
			action ,(lambda () 'catsel)))))

(define &apply-defaults
  ;; Apply defaults
  (lambda ()
    (unless (dbget 'sdate)
      (let ((d (current-date *tz)))
        (dbset 'sdate (date->string d "~Y-~m-~d"))
	(dbset 'stime-only (date->string d "~H:~M") )
	(dbset 'duration "00:36")))
    `(spacer)))

(define &submit-button
  ;; Submit
  `(button text "Submit"
	   action
	   ,(lambda()
	      (let* ((ctm (current-date-local-string))
		     (cat (dbget 'category))
		     (act (dbget 'activity))
		     (sdt (string-append
			   (dbget 'sdate) " " (dbget 'stime-only)))
		     (dur (dbget 'duration)))
		(cond ((and cat act)
		       (dbstore ctm cat act sdt dur )
		       'history)
		      (else
		       #f))))))
;;; .............................................................
(define &history-page
  `(history
    "Activity History"
    ("Activities" activities)
    ("Main" main)
    (spacer)
    ,(lambda()
       `(list entries ,(db-get-history-lines)))))
;;; .............................................................
(define &activities-page
;;; Activity selection and detail entry
  `(activities
    "Activity Detail"
    ("Cancel" main)
    ("History" history)
    (spacer)

    ;; Dropdown
    (dropdown id category
	      label "Pick a category:"
	      entries ,*categories)
    (spacer)

    ,&activity-pulldown
    (spacer)

    ;; Start Time
    (dateentry text "Date:" indent 0.4 id sdate)
    (timeentry text "Time:" indent 0.4 id stime-only)
    (spacer)

    ;; Duration
    (timeentry text "Duration:" indent 0.4 id duration)
    ,&apply-defaults ; <- includes (spacer)

    ,&submit-button
    (spacer)))
;;; -----------------------------------------------------------
