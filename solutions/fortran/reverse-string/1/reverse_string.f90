module reverse_string
  implicit none
contains

  function reverse(input) result(reversed)
    character(*), intent(in) :: input
    character(len=len(input)) :: reversed
    integer :: i
    i = 0
    do i = len(input), 1, -1
       reversed(len(reversed) - i + 1:len(reversed) - i + 1) = input(i:i)
    end do
  end function

end module
