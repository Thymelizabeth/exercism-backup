using System;
using System.Collections.Generic;

public static class ProteinTranslation
{
    public static string[] Proteins(string strand)
    {
        Dictionary<string, string> proteins = new Dictionary<string, string>();
        proteins.Add("AUG", "Methionine");
        proteins.Add("UUU", "Phenylalanine");
        proteins.Add("UUC",	"Phenylalanine");
        proteins.Add("UUA", "Leucine");
        proteins.Add("UUG", "Leucine");
        proteins.Add("UCU", "Serine");
        proteins.Add("UCC", "Serine");
        proteins.Add("UCA", "Serine");
        proteins.Add("UCG", "Serine");
        proteins.Add("UAU", "Tyrosine");
        proteins.Add("UAC", "Tyrosine");
        proteins.Add("UGU", "Cysteine");
        proteins.Add("UGC", "Cysteine");
        proteins.Add("UGG", "Tryptophan");
        List<string> result = new List<string>();
        for (int i = 0; i < strand.Length; i += 3) {
            string protein = strand.Substring(i, 3);
            if (proteins.ContainsKey(protein)) {
                result.Add(proteins[protein]);
            } else {
                break;
            }
        }
        return result.ToArray();
    }
}