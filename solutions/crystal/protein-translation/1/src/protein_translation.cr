module ProteinTranslation
  def self.proteins(strand : String) : Array(String)
    strand.each_char.each_slice(3).map {|x| translate_codon(x.join) }.take_while {|x| x != "STOP"}.to_a
  end
  def self.translate_codon(codon : String) : String
    case codon
    when "AUG"
      "Methionine"
    when "UUU", "UUC"
      "Phenylalanine"
    when "UUA", "UUG"
      "Leucine"
    when "UCU", "UCC", "UCA", "UCG"
      "Serine"
    when "UAU", "UAC"
      "Tyrosine"
    when "UGU", "UGC"
      "Cysteine"
    when "UGG"
      "Tryptophan"
    when "UAA", "UAG", "UGA"
      "STOP"
    else
      raise ArgumentError.new("Invalid Codon")
    end
  end
end
