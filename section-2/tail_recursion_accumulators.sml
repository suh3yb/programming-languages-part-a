(*!
Moral of tail recursion

- Where reasonably elegant, feasible, and important, rewriting
  functions to be tail-recursive can be much more efficient
    - Tail-recursive: recursive calls are tail-calls

- There is a methodology that can often guide this transformation:
  - Create a helper function that takes an accumulator
  - Old base case becomes initial accumulator
  - New base case becomes final accumulator
*)

(* Another example *)
fun sum xs =
  case xs of
      [] => 0
    | x::xs' => x + sum xs'

fun sum xs =
  let fun aux(xs,acc) =
    case xs of
        [] => acc
      | x::xs' => aux(xs', x+acc)
  in
    aux(xs,0)
  end

(* Another example *)
fun rev xs =
  case xs of
      [] => []
    | x::xs' => (rev xs') @ [x]

fun rev xs =
  let fun aux(xs,acc) =
    case xs of
        [] => acc
      | x::xs' => aux(xs',x::acc)
  in
    aux(xs,[])
  end

(*!
Non-tail recursive rev is inefficient

So it turns out that it's not just that we're going to build up a call stack every time here. It's
actually that this append operator always copies the first list. It has to that's how append works.

- For fact and sum, tail-recursion is faster but both ways linear time
- Non-tail recursive rev is quadratic because each recursive call
  uses append, which must traverse the first list
  - And 1+2+....+(length-1) is almost length*length/2
  - Moral: beware list-append, especially within outer recursion
- Cons constant-time (and fast), so accumulator version much better
*)
