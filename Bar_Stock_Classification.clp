(deftemplate stock_ID (slot material) (slot height) (slot length)(slot width))

(deffacts data
    (stock_ID (material Fe-1) (length 10) (width 10) (height 10))
	(stock_ID (material Cu-2) (length 20) (width 10) (height 10))
	(stock_ID (material Cu-3) (length 20) (width 10) (height 20))
	(stock_ID (material Pt-4) (length 10) (width 20) (height 10))
	(stock_ID (material Fe-5) (length 30) (width 30) (height 10))
	(stock_ID (material Fe-6) (length 30) (width 20) (height 10))
	(stock_ID (material Fe-7) (length 10) (width 30) (height 20))
	(stock_ID (material Cu-8) (length 10) (width 20) (height 30))
	(stock_ID (material Pt-9) (length 30) (width 20) (height 10))
	(stock_ID (material Pt-10) (length 20) (width 20) (height 20)))

(defrule square-cross-section
    (stock_ID {length == width} (material ?element))
    =>
	(printout t ?element " has Square Cross Sectional" crlf))

(defrule square-side
	(stock_ID {length == height} (material ?element))
	=>
	(printout t ?element " has Square Side" crlf))

(defrule cube
    (stock_ID {length == width && width == height} (material ?element))
	=>
	(printout t ?element " is a Cube" crlf))

(defrule stock_ID
    (stock_ID (material ?element) (length ?l) (width ?w) (height ?h))
    =>
    (printout t ?element " has a dimension of length= " ?l "; width= " ?w " and height= "?h crlf))

(reset)
(run)