(deftemplate car
    (slot running)
    (slot gas)
    (slot battery)
    (slot starter)
    (slot oil)
    (slot tyre)
    (slot lights)
    (slot engine)
    (slot key))


(deftemplate possible_problem
    (slot oil)
    (slot gas)
    (slot lights)
    (slot engine)
    (slot tyre)
    (slot key)
    (slot starter))


(defrule car-running
	(car(running yes))
    =>
    (printout t "Car is running, you’ve got no possible_problem. Ride on." crlf)
    (assert(car (running TRUE))))

(defrule car-not-running
        (car (running no))
        =>
        (printout t "Car is not Running." crlf)
        (assert(car (running FALSE))))


(defrule engine-rule
    (car (key FALSE))
    =>
    (assert (car (engine FALSE))))

(defrule starter-rule
    (car (engine FALSE))
    (car (battery FALSE))
    =>
    (assert (car (starter FALSE))))

(defrule battery-rule
    (car (lights FALSE))
    =>
    (assert (car (battery FALSE))))

(defrule battery-yes-rule
    (car (lights TRUE))
    =>
    (assert (car (battery TRUE))))

(defrule tyres-rule-yes
    (or(possible_problem (tyre 28))
    	(or(possible_problem (tyre 29))
            (or (possible_problem (tyre 30))
                (or (possible_problem (tyre 31))
                    (possible_problem (tyre 32))))))
    =>
    (assert (car(tyre TRUE))))	

(defrule tyres-rule-no
	 (or(not(possible_problem (tyre 28)))
    	(or(not(possible_problem (tyre 29)))
            (or (not(possible_problem (tyre 30)))
                (or (not(possible_problem (tyre 31)))
                    (not(possible_problem (tyre 32)))))))
    =>
    (assert (car(tyre FALSE))))



;FOR GAS
(defrule gas
    (car (running FALSE))
    (car (gas FALSE))
    =>
    (printout t "Fill up the Gas" crlf))
(defrule ask-gas
    (car (running FALSE))
    	(and(not (car (gas TRUE)))
        	(not (car (gas FALSE))))
    =>
    (printout t "Does the fuel gauge of the gas read empty? yes/no" crlf)
    (assert (possible_problem (gas (read)))))
(defrule gas-empty
    (possible_problem (gas empty))
    =>
    (assert (car (gas FALSE))))
(defrule gas-full
    (or(car (gas TRUE))
        (possible_problem (gas full)))
    =>
    (printout t "Gas is Full" crlf)
    )



;FOR OIL
(defrule oil
    (car (running FALSE))
    (car (oil FALSE))
    =>
    (printout t "The oil needs to be filled" crlf))
(defrule ask-oil
    (car (running FALSE))
    	(and(not (car (oil TRUE)))
        	(not (car (oil FALSE))))
    =>
    (printout t "Oil dipstick indication? empty/full" crlf)
    (assert (possible_problem (oil (read)))))
(defrule oil-empty
    (possible_problem (oil empty))
    =>
    (assert (car (oil FALSE))))
(defrule oil-full
    (or(car (oil TRUE))
        (possible_problem (oil full)))
    =>
    (printout t "Oil is Full" crlf)
    )



;FOR BATTERY
(defrule lights
    (car (running FALSE))
    (car (lights FALSE))
    =>
    (printout t "Charge the Battery" crlf))
(defrule ask-lights
    (car (running FALSE))
    	(and(not (car (lights TRUE)))
        	(not (car (lights FALSE))))
    =>
    (printout t "Are the lights turning on? yes/no" crlf)
    (assert (possible_problem (lights (read)))))
(defrule lights-no
    (possible_problem (lights no))
    =>
    (assert (car (lights FALSE))))
(defrule lights-yes
    (or(car (lights TRUE))
        (possible_problem (lights yes)))
    =>
    (printout t "Battery is charged" crlf)
    )



;FOR IGNITION
(defrule ignition
    (car (running FALSE))
    (car (engine FALSE))
    =>
    (printout t "Engine not working" crlf)
    )
(defrule ask-iginition
    (car (running FALSE))
    	(and (not (car (engine TRUE)))
        		(not (car (engine FALSE))))
    =>
    (printout t "Does the Engine Turn On? yes/no" crlf)
    (assert (possible_problem (engine (read)))))
(defrule engine-no
    (possible_problem (engine no))
    =>
    (assert (car (engine FALSE))))
(defrule engine-yes
    (possible_problem (engine yes))
    =>
    (assert (car (engine TRUE))))



;FOR KEY
(defrule key
    (car (running FALSE))
    (car (key FALSE))
    =>
    (printout t "Get your key and turn on the engine" crlf))
(defrule ask-key
    (car (running FALSE))
    	(and (not (car (key TRUE)))
        		(not (car (key FALSE))))
    =>
    (printout t "Do you have the key? yes/no" crlf)
    (assert (possible_problem (key (read)))))
(defrule key-no
    (possible_problem (key no))
    =>
    (assert (car (key FALSE))))
(defrule key-yes
    (possible_problem (key yes))
    =>
    (assert (car (key TRUE))))



;FOR STARTER
(defrule starter-no
    (car (running FALSE))
    (car (starter FALSE))
    =>
    (printout t "Starter Motor is not Working" crlf)
    )



;FOR TYRES
(defrule tyres-ask
    (car (running FALSE))
    =>
    (printout t "What is the tyre Pressure? lbs" crlf)
    (assert (possible_problem(tyre (read)))))
(defrule tyres-yes
    (car (tyre TRUE))
    =>
    (printout t "Tyres are inflated properly." crlf))
(defrule tyre-no
    (car (running FALSE))
    (not (car (tyre TRUE)))
    (car (tyre FALSE))
    =>
    (printout t "Inflate Tyres properly between 28 and 32 lbs"))

(defrule end-program
    (or(possible_problem (engine end))
    	(or(possible_problem (lights end))
    		(or(possible_problem (gas end))
    			(or(possible_problem (oil end))
    				(or(possible_problem (tyre end))
    					(or(possible_problem (key end))
                        	(car (running end))))))))
    =>
    (printout t "end program")
    (exit)    
    )

(reset)
(printout t "Is the car running? yes/no" crlf)
(assert (car (running (read))))
(assert (car (lights TRUE)))
;(assert (car (gas TRUE)))
(assert (car (key TRUE)))
;(assert (car (oil FALSE)))

(run)
