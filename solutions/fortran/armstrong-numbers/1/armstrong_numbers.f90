
module armstrong_numbers
  implicit none
contains

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    integer :: num_digits
    integer, allocatable :: digits_of_i(:)
    num_digits = ceiling(log10(real(i)))
    allocate(digits_of_i(num_digits))
    call digits(i, digits_of_i)
    digits_of_i = digits_of_i ** num_digits
    isArmstrongNumber = i.eq.sum(digits_of_i)
  end function isArmstrongNumber

  subroutine digits(n, digits_out)
    integer, allocatable, intent(out) :: digits_out(:)
    integer, intent(in) :: n
    integer :: x, i
    x = n
    if (.not.allocated(digits_out)) then
       allocate(digits_out(ceiling(log10(real(n)))))
    end if
    do i = size(digits_out), 1, -1
       digits_out(i) = mod(x, 10)
       x = x / 10
    end do
  end subroutine digits

end module
