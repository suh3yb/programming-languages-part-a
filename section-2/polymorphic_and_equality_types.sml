(* Polymorphic types *)
(* 'a list * 'a list -> 'a list *)
fun append (xs,ys) =
  case xs of
      [] => ys
    | x::xs' => x :: append(xs',ys)

val ok1 = append(["hi", "bye"], ["programming", "languages"])

val ok2 = append([1,2],[4,5])

(* val not_ok = append([1,2],["programming","languages"]) *)

(*!
  'a list * 'a list -> 'a list

  is more general than

  string list * string list -> string list

  and it can be used as any less general type, such as

  int list * int list -> int list

  but it is not more general than the type

  int list * string list -> int list
*)

(* A type t1 is more general than the type t2 if you can take t1,
replace its type variables consistently, and get t2 *)

(*!
  Example: Replace eact 'a with int * int
  Example: Replace each 'a with bool and each 'b with bool
  Example: Replace each 'a with bool and each 'b with int
  Example: Replace each 'b with 'a' and each 'a with 'a 
*)

(*!
  Can combine "more general" rule with rules for equivalence
    - Use of type synonyms does not matter
    - Order of field names does not matter

  Example, given
    type foo = int * int
  the type
    {quux: 'b, bar: int * 'a, baz: 'b}
  is more general than
    {quux: string, bar: foo, baz: string}
  which is equivalent to
    {bar: int * int, baz: string, quux: string}
*)

(* Equality types *)
(* Example *)
(* ''a list * ''a -> bool *)

(*!
  These are "equality types" that arise from using the = operator
    - The = operator works on lots of types: int, string, tuples containing all equality types, ...
    - But not all types: function types, real, ...

  The rules for more general are exactly the same except you have to replace an equality-type
  variable with a type that can be used with =
    - A "strange" feature of ML because = is special
*)

(* ''a * ''a -> string *)
fun same_thing (x,y) =
  if x=y then "yes" else "no"

(* int -> string *)
fun is_three x =
  if x=3 then "yes" else "no"