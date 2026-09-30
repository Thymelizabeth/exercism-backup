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
        result = switch (codon) {
            .AUG => try addProtein(allocator, result, .methionine),
            .UUU, .UUC => try addProtein(allocator, result, .phenylalanine),
            .UUA, .UUG => try addProtein(allocator, result, .leucine),
            .UCU, .UCC, .UCA, .UCG => try addProtein(allocator, result, .serine),
            .UAU, .UAC => try addProtein(allocator, result, .tyrosine),
            .UGU, .UGC => try addProtein(allocator, result, .cysteine),
            .UGG => try addProtein(allocator, result, .tryptophan),
            .UAA, .UAG, .UGA => return result,
        };
    }
    return result;
}

fn addProtein(allocator: mem.Allocator, buffer: []Protein, protein: Protein) mem.Allocator.Error![]Protein {
    const result = try allocator.realloc(buffer, buffer.len + 1);
    result[result.len - 1] = protein;
    return result;
}
