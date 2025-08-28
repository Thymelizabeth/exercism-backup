
module rational_numbers
  implicit none
contains

  function add(r1,r2)
    integer,dimension(2) :: add, r1,r2
    add = reduce([r1(1) * r2(2) + r2(1) * r1(2), r1(2) * r2(2)])
  end function

  function sub(r1,r2)
    integer,dimension(2) :: sub, r1,r2
    sub = reduce([r1(1) * r2(2) - r2(1) * r1(2), r1(2) * r2(2)])
  end function

  function mul(r1,r2)
    integer,dimension(2) :: mul, r1,r2
    mul = reduce([r1(1) * r2(1), r1(2) * r2(2)])
  end function

  function div(r1,r2)
    integer,dimension(2) :: div, r1,r2
    div = reduce([r1(1) * r2(2), r2(1) * r1(2)])
  end function

  function rational_abs(r1)
    integer,dimension(2) :: rational_abs, r1
    rational_abs = reduce([abs(r1(1)), abs(r1(2))])
  end function

  function rational_to_pow(r1, ex)
    integer,dimension(2) :: rational_to_pow, r1
    integer :: ex
    if (ex < 0) then
       rational_to_pow = reduce([r1(2) ** abs(ex), r1(1) ** abs(ex)])
    else
       rational_to_pow = reduce([r1(1) ** ex, r1(2) ** ex])
    end if
  end function

  function real_to_rational_pow(ex,r1)
    integer,dimension(2) ::  r1
    real :: real_to_rational_pow,ex
    real_to_rational_pow = ex ** (1.0 * r1(1) / r1(2))
  end function

  function reduce(r1)
    integer,dimension(2) :: reduce, r1
    reduce = [r1(1) / gcd(r1(1), r1(2)), r1(2) / gcd(r1(1), r1(2))]
    if (r1(2) < 0) then
       reduce = [-reduce(1), -reduce(2)]
    end if
  end function reduce

  ! From https://www.programming-idioms.org/idiom/74/compute-gcd/3741/fortran
  function gcd(m,n)
    integer, intent(in) :: m, n
    integer :: gcd, rest, first
    first = abs(m)
    gcd = abs(n)
    if (gcd.eq.0) then
       gcd = first
    else
       do
          rest = mod(first, gcd)
          if (rest == 0) exit
          first = gcd
          gcd = rest
       end do
       gcd = abs(gcd)
    end if
  end function gcd

end module
