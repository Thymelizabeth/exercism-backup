using System;

static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        string prefix = "";
        if (id != null)
            prefix = $"[{id}] - ";
        return $"{prefix}{name} - {(department ?? "OWNER").ToUpper()}";
    }
}
