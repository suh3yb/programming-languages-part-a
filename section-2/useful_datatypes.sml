datatype suit = Club | Diamond | Heart | Spade;
datatype rank = Jack | Queen | King | Ace | Num of int;

datatype id = StudentNum of int 
            | Name of string (* first name *)
                      * (string option) (* optional middle name *)
                      * string; (* last name *)

(* bad style below *)
(* use the student_num and ignore other fields unless the student_num is ~1 *)
(*
  { student_num : int,
    first       : string,
    middle      : string option,
    last        : string }
*)

(* and if you want both student number and name, the following each-of is way to go *)
(* person type *)
(*
  { student_num : int option,
    first       : string,
    middle      : string option,
    last        : string }
*)

(* Expression Trees *)
(* recursive/self-reference types *)
datatype exp = Constant of int
             | Negate   of exp
             | Add      of exp * exp
             | Multiply of exp * exp;

val e = Add (Constant (10+9), Negate (Constant 4));

(*
        Add
    /        \
Constant    Negate
    |         |
    19      Constant
              |
              4
*)

fun eval e =
  case e of Constant i      => i
          | Negate e2       => ~ (eval e2)
          | Add(e1,e2)      => (eval e1) + (eval e2)
          | Multiply(e1,e2) => (eval e1) + (eval e2);

fun number_of_adds e = (* exp -> int *)
  case e of Constant i      => 0
          | Negate e2       => number_of_adds e2
          | Add(e1,e2)      => 1 + number_of_adds e1 + number_of_adds e2
          | Multiply(e1,e2) => number_of_adds e1 + number_of_adds e2;

val example_exp : exp = Add (Constant 19, Negate (Constant 4));
val example_exp_ans : int = eval example_exp;
val example_addcount = number_of_adds (Multiply(example_exp, example_exp));