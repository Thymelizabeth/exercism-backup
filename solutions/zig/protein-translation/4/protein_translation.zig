const std = @import("std");
const mem = std.mem;

pub const TranslationError = error{
    InvalidCodon,
};

pub const Protein = enum {
    methionine,
    phenylalanine,
    leucine,
    serine,
    tyrosine,
    cysteine,
    tryptophan,
};

pub fn proteins(allocator: mem.Allocator, strand: []const u8) (mem.Allocator.Error || TranslationError)![]Protein {
    var result = try allocator.alloc(Protein, 0);
    errdefer allocator.free(result);
    var i: usize = 0;
    while (i < strand.len) : (i += 3) {
        if (i + 2 >= strand.len) {
            return TranslationError.InvalidCodon;
        }
        const codon = std.meta.stringToEnum(enum { AUG, UUU, UUC, UUA, UUG, UCU, UCC, UCA, UCG, UAU, UAC, UGU, UGC, UGG, UAA, UAG, UGA }, strand[i .. i + 3]) orelse return TranslationError.InvalidCodon;
        const protein: Protein = switch (codon) {
            .AUG => .methionine,
            .UUU, .UUC => .phenylalanine,
            .UUA, .UUG => .leucine,
            .UCU, .UCC, .UCA, .UCG => .serine,
            .UAU, .UAC => .tyrosine,
            .UGU, .UGC => .cysteine,
            .UGG => .tryptophan,
            .UAA, .UAG, .UGA => return result,
        };
        result = try allocator.realloc(result, result.len + 1);
        result[result.len - 1] = protein;
    }
    return result;
}
