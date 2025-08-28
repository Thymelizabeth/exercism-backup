
module collatz_conjecture
  implicit none
contains

  integer function steps(i)
    integer :: i
    integer :: n
    n = i
    steps = -1
    do while (n >= 1)
       steps = steps + 1       
       if (n == 1) then
          exit
       else if (mod(n, 2) == 0) then
          n = n / 2
       else
          n = 3 * n + 1
       end if
    end do
  end function

end module
