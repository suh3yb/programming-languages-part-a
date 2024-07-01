datatype mytype = TwoInts of int * int 
                | Str of string 
                | Pizza

(* mytype -> int *)
fun f x = 
    case x of
        Pizza => 3
      | Str s => 8
      | TwoInts(i1, i2) => i1 + i2
  (*  | Str s => String.size s;  (* redundant match error *) *)

(* fun g x = case x of Pizza => 3; (* missing cases: warning *) *)

val p = f Pizza           (* 3 *)
val s = f (Str "hi")      (* 8 *)
val z = f (TwoInts (7,9)) (* 16 *)

(*
 * f "hi" will throw error because "hi" is string type and not Str type
 *)