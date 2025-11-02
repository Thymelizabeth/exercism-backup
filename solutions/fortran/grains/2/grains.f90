
module grains

  implicit none

contains

  double precision function square(n)
    integer :: n
    if ((n.lt.1).or.(n.gt.64)) then
      square = -1.d0
    else
      square = 2.d0 ** real(n - 1)
    end if
  end function

  double precision function total()
    integer :: i
    total = sum([(square(i), i = 1, 64)])
  end function

end module
