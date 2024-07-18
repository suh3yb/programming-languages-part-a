(* Provided types *)
type student_id = int
type grade = int (* must be in 0 to 100 range *)
type final_grade = { id : student_id, grade : grade option }
datatype pass_fail = pass | fail

(*!
Note that the grade might be absent (presumably because the student unregistered from the course).

1. Write a function pass_or_fail of type {grade : int option, id : ’a} -> pass_fail that takes a
final_grade (or, as the type indicates, a more general type) and returns pass if the grade field
contains SOME i for an i ≥ 75 (else fail).
*)

fun pass_or_fail {grade, id} =
  case grade of
      SOME i => if i >= 75 then pass else fail
    | NONE => fail

(*
2. Using pass_or_fail as a helper function, write a function has_passed of type 
{grade : int option, id : ’a} -> bool that returns true if and only if the the grade field contains
SOMEi for an i ≥ 75.
*)

fun has_passed f_grade =
  case pass_or_fail f_grade of
      pass => true
    | fail => false

(*
3. Using has_passed as a helper function, write a function number_passed that takes a list of type
final_grade (or a more general type) and returns how many list elements have passing (again, ≥75)
grades.
*)

fun number_passed grades =
  let
    fun aux(gs,acc) =
      case gs of
          [] => acc
        | g::gs' => if has_passed g then aux(gs',1+acc) else aux(gs',acc)
  in
    aux(grades,0)
  end

(*
4. Write a function number_misgraded of type (pass_fail * final_grade) list -> int that indicates how
many list elements are "mislabeled" where mislabeling means a pair (pass,x) where has_passed x is
false or (fail,x) where has_passed x is true.
*)

(* Problems 5-7 use these type definitions: *)

datatype 'a tree = leaf 
                 | node of { value : 'a, left : 'a tree, right : 'a tree }
datatype flag = leave_me_alone | prune_me

(*!
5. Write a function tree_height that accepts an 'a tree and evaluates to a height of this tree.
The height of a tree is the length of the longest path to a leaf. Thus the height of a leaf is 0.
*)

fun tree_height tree =
  let
    fun aux(t,acc) =
      case t of
          leaf => acc
        | node {value,left,right} => let
                                      val left_height = aux(left,acc+1)
                                      val right_height = aux(right,acc+1)
                                     in
                                      if left_height > right_height
                                      then left_height 
                                      else right_height
                                     end
  in
    aux(tree,0)
  end


(*!
6. Write a function sum_tree that takes an int tree and evaluates to the sum of all values in the
nodes.
*)

fun sum_tree tree =
  case tree of
      leaf => 0
    | node {value,left,right} => value+sum_tree left+sum_tree right


(*!
7. Write a function gardener of type flag tree -> flag tree such that its structure is identical
to the original tree except all nodes of the input containing prune_me are (along with all their
descendants) replaced with a leaf.
*)

fun gardener tree =
  case tree of
      leaf => leaf
    | node {value,left,right} => case value of
                                    prune_me => leaf
                                  | leave_me_alone => node {
                                                            value=value,
                                                            left=gardener left,
                                                            right=gardener right
                                                          }

(*!
8. Re-implement various functions provided in the SML standard libraries for lists and options.  See http://sml-family.org/Basis/list.html and http://sml-family.org/Basis/option.html
.  Good examples include last, take, drop, concat, getOpt, and join. 
*)

(* Problems 9-16 use this type definition for natural numbers: *)

datatype nat = ZERO | SUCC of nat

(*!
A "natural" number is either zero, or the "successor" of a another integer. So for example the
number 1 is just SUCC ZERO, the number 2 is SUCC (SUCC ZERO), and so on.

9. Write is_positive : nat -> bool, which given a "natural number" returns whether that number is
positive (i.e. not zero).

10. Write pred : nat -> nat, which given a "natural number" returns its predecessor. Since 0 does
not have a predecessor in the natural numbers, throw an exception Negative (will need to define it
first).

11. Write nat_to_int : nat -> int, which given a "natural number" returns the corresponding int.
For example, nat_to_int (SUCC (SUCC ZERO)) = 2.  (Do not use this function for problems 13-16 -- it
makes them too easy.)

12. Write int_to_nat : int -> nat which given an integer returns a "natural number" representation
for it, or throws a Negative exception if the integer was negative.  (Again, do not use this
function in the next few problems.)

13. Write add : nat * nat -> nat to perform addition.

14. Write sub : nat * nat -> nat to perform subtraction.  (Hint: Use pred.)

15. Write mult : nat * nat -> nat to perform multiplication. (Hint: Use add.)

16. Write less_than : nat * nat -> bool to return true when the first argument is less than the
second.
*)

(* The remaining problems use this datatype, which represents sets of integers: *)

datatype intSet = 
  Elems of int list (*list of integers, possibly with duplicates to be ignored*)
| Range of { from : int, to : int }  (* integers from one number to another *)
| Union of intSet * intSet (* union of the two sets *)
| Intersection of intSet * intSet (* intersection of the two sets *)

(*!
17. Write isEmpty : intSet -> bool that determines if the set is empty or not.

18. Write contains: intSet * int -> bool that returns whether the set contains a certain element or
not.

19. Write toList : intSet -> int list that returns a list with the set's elements, without
duplicates.
*)

(* Test *)
val grade1 = {grade=NONE,id=1}
val grade2 = {grade=SOME 74,id=2}
val grade4 = {grade=SOME 90,id=4}
val grade3 = {grade=SOME 75,id=3}
val tree1 = leaf
val tree2 = node {value=1,
                  right=leaf,
                  left=node {
                              value=2,
                              left=leaf,
                              right=node {
                                          value=1,
                                          left=leaf,
                                          right=leaf
                                          }}}
val tree3 = node {
                  value=3,
                  right=tree1,
                  left=node {
                              value=4,
                              right=tree2,
                              left=tree2
                            }}
val flag_tree1 = node {
                  value=leave_me_alone,
                  right=leaf,
                  left=node {
                              value=leave_me_alone,
                              right=leaf,
                              left=leaf
                            }}
val flag_tree2 = node {
                  value=leave_me_alone,
                  right=leaf,
                  left=node {
                              value=prune_me,
                              right=flag_tree1,
                              left=leaf
                            }}

val test1 = pass_or_fail grade1 = fail
val test2 = pass_or_fail grade2 = fail
val test3 = pass_or_fail grade3 = pass
val test4 = pass_or_fail grade4 = pass
val test5 = has_passed grade1 = false
val test6 = has_passed grade2 = false
val test7 = has_passed grade3 = true
val test8 = has_passed grade4 = true
val test9 = number_passed [] = 0
val test10 = number_passed [grade1,grade2,grade3,grade4] = 2
val test11 = tree_height tree1 = 0
val test12 = tree_height tree2 = 3
val test13 = tree_height tree3 = 5
val test14 = sum_tree tree1 = 0
val test15 = sum_tree tree3 = 15
val test16 = sum_tree(node{value=5,left=tree3,right=tree2}) = 24
val test17 = gardener tree1 = leaf
val test18 = gardener flag_tree1 = flag_tree1
val test19 = gardener flag_tree2 = node {
                                          value=leave_me_alone,
                                          right=leaf,
                                          left=leaf
                                        }
