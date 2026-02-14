let rec length_aux acc = function
  | [] -> acc
  | _ :: xs -> length_aux (acc + 1) xs

let length xs = length_aux 0 xs

let rec rev_acc acc = function
  | [] -> acc
  | x :: xs -> rev_acc (x :: acc) xs

let reverse xs = rev_acc [] xs

let rec map ~f = function
  | [] -> []
  | x :: xs -> f x :: map ~f xs

let rec filter ~f = function
  | [] -> []
  | x :: xs -> if f x then x :: filter ~f xs else filter ~f xs

let rec fold ~init ~f = function
  | [] -> init
  | x :: xs -> fold ~init:(f init x) ~f xs

let rec append lst1 lst2 = match lst1 with
  | [] -> lst2
  | x :: xs -> x :: append xs lst2

let concat xs = fold ~init:[] ~f:append xs
