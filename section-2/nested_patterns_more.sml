fun nondecreasing1 xs = (* int list -> bool *)
  case xs of
      [] => true
    | x::xs' => case xs' of
                    [] => true
                  | y::ys' => x <= y andalso nondecreasing1 xs'

fun nondecreasing2 xs = (* int list -> bool *)
  case xs of
      [] => true
    | _::[] => true
    | head::(neck::rest) => head <= neck andalso nondecreasing2 (neck::rest)

datatype sgn = P | N | Z
fun multsing (x1,x2) = (* int * int -> sgn *)
  let fun sign x = if x=0 then Z else if x>0 then P else N
  in
    case (sign x1, sign x2) of
        (Z,_) => Z
      | (_, Z) => Z
      | (P,P) => P
      | (N,N) => P
      | _ => N
   (* | (N,P) => N
      | (P,N) => N *)
  end

fun len xs =
  case xs of
      [] => 0
    | _::xs' => 1 + len xs'

(* Style *)
(*!
  Nested patterns can lead to very elegant, concise code
    - Avoid nested case expressions if nested patterns are simpler
    and avoid unnecessary branches or let-expressions
      - Example: unzip3 and nondecreasin2
    - A common idiom is matching against a tuple of datatypes to
    compare them
      - Examples: zip3 and multsing

  Wildcards are good style: use them instead of variables when
  you do not need the data
    - Examples: len and multsing
*)