module raindrops
  implicit none

  type :: raindrop
     integer :: k
     character(5) :: v
  end type raindrop
contains

  function convert(i)
    integer :: i, n, c
    character(20) :: convert
    type(raindrop) :: translation(3)
    convert = repeat(" ", 20)
    translation = [raindrop(3, "Pling"), raindrop(5, "Plang"), raindrop(7, "Plong")]
    c = 1
    do n = 1, size(translation)
       if (mod(i, translation(n)%k) == 0) then
          convert(c:) = translation(n)%v
          c = c + len(translation(n)%v)
       end if
       print *, i, "%", translation(n)%k, mod(i, translation(n)%k)
    end do
    print *, "convert = ", convert
    if (convert(1:1) == " ") then
       write(convert, "(i20)") i
       convert = trim(adjustl(convert))
    end if
  end function convert

end module raindrops
