fun max1 (xs : int list) =
    if null xs
    then NONE
    else
	let
	    val head = hd xs
	    val tl_ans = max1(tl xs)
	in
	    
	    if isSome tl_ans andalso valOf tl_ans > head
	    then tl_ans
	    else SOME head
	end


fun max2 (xs:int list) =
    if null xs
    then NONE
    else
	let
	    fun helper_max(nonempty_xs:int list) =
		if null (tl nonempty_xs)
		then hd nonempty_xs
		else
		    let
			val head = hd nonempty_xs
			val tl_ans = helper_max(tl nonempty_xs)
		    in
			if head > tl_ans
			then head
			else tl_ans
		    end
	in
	    SOME (helper_max xs)
	end
	    
