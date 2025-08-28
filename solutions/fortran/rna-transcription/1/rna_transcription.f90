module rna_transcription
  implicit none
contains

  function to_rna(dna)
    character(*) :: dna
    character(len(dna)) :: to_rna
    integer :: i
    do i = 1, len(dna)
       to_rna(i:i) = translate(dna(i:i))
    end do
  end function to_rna

  function translate(dna)
    character :: dna, translate
    select case (dna)
    case ('G')
       translate = 'C'
    case ('C')
       translate = 'G'
    case ('T')
       translate = 'A'
    case ('A')
       translate = 'U'
    case default
       translate = ' '
    end select
  end function translate
end module rna_transcription
