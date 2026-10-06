#include "protein_translation.h"

namespace protein_translation {

std::vector<std::string> proteins(std::string codons) {
  std::vector<std::string> result{};
  for (size_t i = 0; i < codons.size(); i += 3) {
    auto codon = codons.substr(i, 3);
    if (codon == "AUG")
      result.emplace_back("Methionine");
    else if (codon == "UUU" || codon == "UUC")
      result.emplace_back("Phenylalanine");
    else if (codon == "UUA" || codon == "UUG")
      result.emplace_back("Leucine");
    else if (codon == "UCU" || codon == "UCC" || codon == "UCA" ||
             codon == "UCG")
      result.emplace_back("Serine");
    else if (codon == "UAU" || codon == "UAC")
      result.emplace_back("Tyrosine");
    else if (codon == "UGU" || codon == "UGC")
      result.emplace_back("Cysteine");
    else if (codon == "UGG")
      result.emplace_back("Tryptophan");
    else if (codon == "UAA" || codon == "UAG" || codon == "UGA")
      break;
    else
      return {};
  }
  return result;
}

} // namespace protein_translation
