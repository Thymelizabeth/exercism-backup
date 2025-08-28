module two_fer
  implicit none

contains

  function twoFer(name) result(phrase)
    character(*), intent(in), optional :: name
    character(:), allocatable :: phrase
    character(40) :: subject
    subject = "you"
    if (present(name)) then
       subject = name
    end if
    allocate(character(61) :: phrase)
    phrase = "One for " // trim(subject) // ", one for me."
  end function twoFer

end module two_fer
