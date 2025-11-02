module binary_search
  implicit none
contains

  recursive function find(array, val) result(idx)
    integer, dimension(:), intent(in) :: array
    integer, intent(in) :: val
    integer :: idx, high_idx
    idx = size(array) / 2 + 1
    if (idx.gt.size(array)) then
      idx = -1
    else if (array(idx).gt.val) then
      idx = find(array(:idx-1), val)
    else if (array(idx).lt.val) then
      high_idx = find(array(idx+1:), val)
      if (high_idx.eq.-1) then
        idx = -1
      else
        idx = high_idx + idx
      end if
    end if
  end function
end module
