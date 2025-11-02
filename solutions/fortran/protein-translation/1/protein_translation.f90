module protein_translation
  implicit none

contains

  function proteins(rna) result(names)
    character(len=*), intent(in) :: rna
    character(len=3) :: codon
    character(len=13), allocatable :: names(:)
    integer :: names_length
    integer :: i

    names_length = 0
    do i = 1, len(rna), 3
      if (rna(i:i+2).eq."UAA".or.rna(i:i+2).eq."UAG".or.rna(i:i+2).eq."UGA") then
        exit
      end if
      names_length = names_length + 1
    end do
    allocate(names(names_length))
    do i = 1, names_length
      codon = rna((((i-1)*3)+1):(((i-1)*3)+3))
      if (codon.eq."AUG") then
        names(i) = "Methionine"
      else if (codon.eq."UUU".or.codon.eq."UUC") then
        names(i) = "Phenylalanine"
      else if (codon.eq."UUA".or.codon.eq."UUG") then
        names(i) = "Leucine"
      else if (codon.eq."UCU".or.codon.eq."UCC".or.codon.eq."UCA".or.codon.eq."UCG") then
        names(i) = "Serine"
      else if (codon.eq."UAU".or.codon.eq."UAC") then
        names(i) = "Tyrosine"
      else if (codon.eq."UGU".or.codon.eq."UGC") then
        names(i) = "Cysteine"
      else if (codon.eq."UGG") then
        names(i) = "Tryptophan"
      else
        exit
      end if
    end do
  end function proteins

end module protein_translation

