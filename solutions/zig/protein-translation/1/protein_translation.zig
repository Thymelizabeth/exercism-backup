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
        result = switch (strand[i]) {
            'A' => if (strand[i + 1] == 'U' and strand[i + 2] == 'G')
                try addProtein(allocator, result, .methionine)
            else
                return TranslationError.InvalidCodon,
            'U' => switch (strand[i + 1]) {
                'A' => switch (strand[i + 2]) {
                    'A', 'G' => {
                        return result;
                    },
                    'C', 'U' => try addProtein(allocator, result, .tyrosine),
                    else => {
                        return TranslationError.InvalidCodon;
                    },
                },
                'C' => switch (strand[i + 2]) {
                    'A', 'C', 'G', 'U' => try addProtein(allocator, result, .serine),
                    else => {
                        return TranslationError.InvalidCodon;
                    },
                },
                'G' => switch (strand[i + 2]) {
                    'A' => {
                        return result;
                    },
                    'C', 'U' => try addProtein(allocator, result, .cysteine),
                    'G' => try addProtein(allocator, result, .tryptophan),
                    else => {
                        return TranslationError.InvalidCodon;
                    },
                },
                'U' => switch (strand[i + 2]) {
                    'A', 'G' => try addProtein(allocator, result, .leucine),
                    'C', 'U' => try addProtein(allocator, result, .phenylalanine),
                    else => {
                        return TranslationError.InvalidCodon;
                    },
                },
                else => {
                    return TranslationError.InvalidCodon;
                },
            },
            else => {
                return TranslationError.InvalidCodon;
            },
        };
    }
    return result;
}

fn addProtein(allocator: mem.Allocator, buffer: []Protein, protein: Protein) mem.Allocator.Error![]Protein {
    const result = try allocator.realloc(buffer, buffer.len + 1);
    result[result.len - 1] = protein;
    return result;
}
