fun hd xs =
  case xs of
      [] => raise List.Empty
    | x::_ => x

exception MyUndesirableCondition

exception MyOtherException of int * int
(* raise MyOtherException(3,4) *)

fun mydiv (x,y) =
  if y=0
  then raise MyUndesirableCondition
  else x div y

fun maxlist (xs,ex) = (* int list * exn -> int *)
  case xs of
      [] => raise ex
    | x::[] => x
    | x::xs' => Int.max(x,maxlist(xs',ex))

val w = maxlist ([3,4,5],MyUndesirableCondition)

(*!
How to handle a exception
  e1 handle ex => e2
*)

val x = maxlist ([3,4,5],MyUndesirableCondition) (* 5 *)
        handle MyUndesirableCondition => 42

(* val y = maxlist ([],MyUndesirableCondition) *)

val z = maxlist ([],MyUndesirableCondition) (* 42 *)
        handle MyUndesirableCondition => 42

(*!
  Exceptions
    An exception binding introduces a new kind of exception

    exception MyFirstException
    exception MySecondException of int * int

    The raise primitive raises (a.k.a. throws) an exception

    raise MyFirstException
    raise (MySecondException(7,9))

    A handle expression can handle (a.k.a. catch) an exception

    - If doesn't match, exception continues to propagate

    e1 handle MyFirstException => e2
    e1 handle MySecondException(x,y) => e2

  Exceptions are a lot like datatype constructors
    - Declaring an exception makes adds a constructor for type exn
    - Can pass values of exn anywhere (e.g. function arguments)
      - Not too common to do this but can be useful
    - Handle can have multiple branches with patterns for type exn
*)