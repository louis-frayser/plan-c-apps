(include "list.scm")

(define demouiform:example (list->table `(
					  (main
					   "Demo UI Form"
					   ("Widgets" widgets)
					   ("About" about)
					   (spacer height 200)
					   (label text "Hello from LambdaNative" size header)
					   (spacer)
					   ;; Show an image (file listed in EMBED)
					   (image file "LN_logo.png")
					   )
					  (widgets
					   "Widgets"
					   #f
					   ("Done" main)
					   (spacer)
					   ;; Dropdown
					   (dropdown id dropcolours
						     label "Pick an option:"
						     entries ,*categories)
					   (spacer)

					   ;; Make a text field where the entered number will be stored in key "someid" in the database, indent it on both sides
					   (textentry id someid text "Number here:" keypad numint indent 0.4 indentright 0.4)
					   (spacer height 10)
					   ;; Don't store the password in the database table, just store it in the UI
					   (textentry id passid text "Password:" password #t location ui)
					   (spacer)
					   ;; Simple radio box with a callback popup from one of the options.
					   (radiobox id aradio text "Pick Yes" left ("Yes" "1" #f) right ("No" "0" ("I said choose yes!" ("OK" ,(lambda ()
																		  ;; Don't allow No, set it to blank
																		  (dbclear 'aradio)
																		  ;; Don't go to another page
																		  #f)))))
					   ;; Checkbox that appears only if above radiobox is Yes
					   ,(lambda ()
					      (if (string=? (dbget 'aradio "") "1")
						  '(checkbox id checky indent 0.3 text "Visible if you said Yes")
						  '(spacer height 0)))
					   (spacer)
#|					   ;; Dropdown
					   (dropdown id dropcolours label "Pick an option:" entries ,*categories #;("Option 1" "Choice B" "Alternative iii")
						     )
					   (spacer)
|#					;
					   ;; Button with action callback that returns the page you want to go to ;
					   (button h 75 size header indent 0.05 rounded #t text "Go Back" action ,(lambda () 'main)) ;
					   (spacer)
					   ;; slider 
					   (slider id sliderval number #t min 0 max 100 default 50 labels ("min" "max"))
					   (spacer)
					   (label text "For more features that you can include in a script see the LNhealth app \"Demo Widgets\". Look at the main.sx file in the sandbox folder which is located at https://github.com/part-cw/LNhealth/tree/master/apps/WidgetDemo" align left size small)
					   )
					  (about
					   "About"
					   ("Back" main)
					   #f
					   (spacer height 50)
					   (label text "This is a demo app of the uiform module in LambdaNative, a cross-platform development environment written in Scheme. See lambdanative.org")
					   (spacer)
					   (label text "Copyright (c) 2009-2018\nUniversity of British Columbia")
					   )
					  )))
