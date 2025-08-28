module bob
  implicit none
contains

  function hey(statement)
    character(100) :: hey
    character(len=*), intent(in) :: statement
    if (len_trim(statement).eq.0) then
       hey = "Fine. Be that way!"
    else if (is_question(trim(statement)).and.is_yelling(statement)) then
       hey = "Calm down, I know what I'm doing!"
    else if (is_question(trim(statement))) then
       hey = "Sure."
    else if (is_yelling(statement)) then
       hey = "Whoa, chill out!"
    else
       hey = "Whatever."
    end if
  end function hey
     
  function is_question(statement)
    character(len=*), intent(in) :: statement
    logical :: is_question
    is_question = statement(len(statement):len(statement)).eq.'?'
  end function is_question

  function is_yelling(statement)
    character(len=*), intent(in) :: statement
    integer :: i
    logical :: is_yelling
    logical, allocatable :: are_letters(:), are_upper(:)
    allocate(are_letters(len(statement)))
    allocate(are_upper(len(statement)))
    do i = 1, len(statement)
       are_letters(i) = is_letter(statement(i:i))
       are_upper(i) = is_upper(statement(i:i))
    end do
    is_yelling = any(are_letters).and.all(.not.are_letters.or.are_upper)
  end function is_yelling

  function is_letter(c)
    character, intent(in) :: c
    logical :: is_letter
    is_letter = lge(c, 'a').and.lle(c, 'z').or.lge(c, 'A').and.lle(c, 'Z')
  end function is_letter

  function is_upper(c)
    character, intent(in) :: c
    logical :: is_upper
    is_upper = lge(c, 'A').and.lle(c, 'Z')
  end function is_upper
end module bob
