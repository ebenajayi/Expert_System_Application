(deftemplate light
    (slot red)
    (slot green)
    (slot blinking-red)
    (slot blinking-yellow)
    (slot blinking-green)
    (slot none))

(deftemplate walk-sign
    (slot walk)
    (slot dont-walk ))
    
(deftemplate status
    (slot walking)
    (slot driving))
       

(defrule robot-walking 
   (or(status (driving FALSE))
   (status(walking TRUE)))
=>
(printout t "The robot is walking" crlf))

(defrule robot-driving
   (or(status (driving TRUE))
   (status(walking FALSE)))
=>
(printout t "The robot is driving" crlf))


(defrule walk-signs
            (and(status(walking TRUE))
                 (or(walk-sign(walk TRUE)))
                	 (walk-sign(dont-walk FALSE)))
=>   
(printout t "The robot can walk across the other side of the road" crlf))

(defrule go
           	   (and(or(status(driving TRUE))
                      (status(walking FALSE)))
            		   (or(light(green TRUE))
                           (light(blinking-green TRUE))))
=>      
(printout t "The robot can drive across traffic signal" crlf))

(defrule make-a-stop 
            (and(or(status(driving TRUE))
                      (status(walking FALSE)))
            		   (or(light(red TRUE))
                           (light(blinking-red TRUE))))
=>     
(printout t "The robot should stop" crlf))

(defrule proceed-with-caution
         	(and(or(status(driving TRUE))
            (status(walking FALSE)))
            		   (or(light(blinking-yellow TRUE))
                           (light(none TRUE))))
=>        
(printout t "The robot should proceed through the intersection with caution" crlf))

(defrule walking
    	 (and(or(status(driving FALSE))
                      (status(walking TRUE)))
            		   (or(walk-sign(walk TRUE))
                           (walk-sign(dont-walk FALSE))))
=>
(printout t "The robot should cross the road" crlf))


(defrule stoop-walking
    	 (and(or(status(driving FALSE))
                      (status(walking TRUE)))
            		   (or(walk-sign(walk FALSE))
                           (walk-sign(dont-walk TRUE))))
=>
(printout t "The robot should not cross the road" crlf))

(reset)
(assert (walk-sign(walk TRUE)))
(assert (status(driving FALSE)))
(assert (light(red TRUE)))
(run)		





