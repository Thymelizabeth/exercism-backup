module BinarySearchTree

type BinarySearchTree<'a> =
    | Node of 'a * Option<BinarySearchTree<'a>> * Option<BinarySearchTree<'a>>

let left node =
    match node with
    | Node(v, l, r) -> l

let right node =
    match node with
    | Node(v, l, r) -> r

let data node =
    match node with
    | Node(v, l, r) -> v
    

let rec insert items node =
    match items with
    | [] -> node
    | x::xs ->
        match node with
        | Node(v, l, r) ->
            if x <= v then
                match l with
                | None -> Node(v, Some(Node(x, None, None)), r) |> insert xs
                | Some lInner -> Node(v, Some(insert [x] lInner), r) |> insert xs
            else
                match r with
                | None -> Node(v, l, Some(Node(x, None, None))) |> insert xs
                | Some rInner -> Node(v, l, Some(insert [x] rInner)) |> insert xs

let create items =
    match items with
    | x :: xs -> Node(x, None, None) |> insert xs


let rec sortedData node =
    match node with
    | Node(v, l, r) ->
        let lData =
            match l with
            | None -> []
            | Some lInner -> sortedData lInner
        let rData =
            match r with
            | None -> []
            | Some rInner -> sortedData rInner
        List.concat [lData; [v]; rData]
