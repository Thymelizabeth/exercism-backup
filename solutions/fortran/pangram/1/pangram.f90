module pangram
  implicit none
contains

  function is_pangram(sentence)
    character(*), intent(in) :: sentence
    logical :: is_pangram
    is_pangram = verify("abcdefghijklmnopqrstuvwxyz", lower(sentence)).eq.0
   end function is_pangram
   
   pure elemental function lower(str) result (string)
     ! Changes a string to lowercase
     character(*), intent(In)     :: str
     character(len(str))          :: string
     integer                      :: i
     string = str
     ! step thru each letter in the string in specified range
     do i = 1, len(str)
        select case (str(i:i))
        case ('A':'Z') ! change letter to miniscule
           string(i:i) = char(iachar(str(i:i))+32)
        case default
        end select
     end do
   end function lower
end module pangram
