module darts
  implicit none

contains

  function score(x, y) result(points)
    real, intent(in):: x, y
    integer :: points
    select case (ceiling(hypot(x, y)))
    case (:1)
       points = 10
    case (2:5)
       points = 5
    case (6:10)
       points = 1
    case default
       points = 0
    end select
  end function score

end module darts
