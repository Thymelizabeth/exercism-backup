let find haystack needle =
    let rec aux low high = 
      let mid = (high + low) / 2 in
      if low > high then Result.error "value not in array" else
      if mid >= Array.length haystack then Result.error "value not in array" else
      match compare needle haystack.(mid) with
      | n when n < 0 -> aux low (mid - 1)
      | n when n > 0 -> aux (mid + 1) high
      | _ -> Result.ok mid
    in
    aux 0 (Array.length haystack)