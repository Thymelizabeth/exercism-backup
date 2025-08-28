module hamming
  implicit none
contains

  function compute(strand1, strand2, distance)
      character(*) :: strand1, strand2
      integer :: distance
      integer :: n
      logical :: compute

      if (len(strand1) /= len(strand2)) then
        compute = .false.
        distance = 0
      else
        compute = .true.
        distance = count([(strand1(n:n) /= strand2(n:n), n = 1, len(strand1))])
      end if
  end function compute

end module hamming
