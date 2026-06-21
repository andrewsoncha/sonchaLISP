(def fibb
     '(n)
     '(cond (greater n 2)
	    (add
	      (fibb (sub n 1))
	      (fibb (sub n 2))
	      )
	1
    )
)
