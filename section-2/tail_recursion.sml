(*!
  Recursion

  Should now be confortable with recursion:
  - No harder than using a loop
  - Often much easier than a loop
    - When processing a tree (e.g., evaluate an arithmetic expression)
    - Examples like appending lists
    - Avoids mutation even for local variables
  - Now:
    - How to reason about efficiency of recursion
    - The importance of tail recursion
    - Using an accumulator to achieve tail recursion
    - [No new language features here]

  Call-stack

  While a programs runs, there is a call stack of function calls that
  have started but not yet returned
    - Calling a function f pushes an instance of f on the stack
    - When a call to f finishes, it is popped from the stack

  These stack-frames store information like the value of local
  variables and "what is left to do" in the function

  Due to recursion, multiple stack-frames may be calls to the same
  function 
*)

(* Example *)
fun fact n = if n = 0 then 1 else n*fact(n-1)

val x = fact 3

(*!
Call-stacks

  fact 3    fact 3: 3*_    fact 3: 3*_    fact 3: 3*_
            fact 2         fact 2: 2*_    fact 2: 2*_
                           fact 1         fact 1: 1*_
                                          fact 0

  fact 3: 3*_   fact 3: 3*_   fact 3: 3*_    fact 3: 3*2
  fact 2: 2*_   fact 2: 2*_   fact 2: 2*1
  fact 1: 1*_   fact 1: 1*1
  fact 0: 1
*)

(* Example revised *)
fun fact n =
  let fun aux(n,acc) = 
      if n=0
      then acc
      else aux(n-1,acc*n)
  in
    aux(n,1)
  end

val y = fact 3

(*!
Still recursive, more complicated, but the result of recursive
calls is the result for the caller (no remaining multiplication) 

Call-stacks

  fact 3    fact 3: _   fact 3: _   fact 3: _
            aux(3,1)    aux(3,1):_  aux(3,1):_
                        aux(2,3):   aux(2,3):_
                                    aux(1,6)

  fact 3: _   fact 3: _   fact 3: _   fact 3: _
  aux(3,1):_  aux(3,1):_  aux(3,1):_  aux(3,1):_
  aux(2,3):_  aux(2,3):_  aux(2,3):_  aux(2,3):6
  aux(1,6):_  aux(1,6):_  aux(1,6):6
  aux(0,6):_  aux(0,6):6
*)

(*!
An optimization

It is unnecessary to keep around a stack-frame just so it can get a
callee's result and return it without any further evaluation

ML recognizes there tail calls in the compiler and treats them
differently:
  - Pop the caller before the call, allowing callee to reuse the
  same stack space
  - (Along with other optimizations,) as efficient as a loop

Reasonable to assume all function-language implementations do
tail-call optimization
*)

(*!
What really happens with revised function

  fact 3    aux(3,1)    aux(2,3)    aux(1,6)    aux(0,6)

We never build up a stack, this more complicated version of factorial is in fact more efficient.
*)