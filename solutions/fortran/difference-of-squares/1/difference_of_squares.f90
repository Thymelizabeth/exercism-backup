module difference_of_squares
  implicit none
contains

  integer function square_of_sum(n)
    integer :: n, i
    square_of_sum = sum([(i, i = 1, n)]) ** 2
  end function square_of_sum

  integer function sum_of_squares(n)
    integer :: n, i
    sum_of_squares = sum([(i, i = 1, n)] ** 2)
  end function sum_of_squares

  integer function difference(n)
    integer :: n
    difference = abs(sum_of_squares(n) - square_of_sum(n))
  end function difference

end module difference_of_squares
