defmodule Username do
  defp sanitise(char) do
    case char do
      ?_ -> [?_]
      char when char > 96 and char < 123 -> [char]
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      _  -> []
    end
  end

  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    Enum.concat(Enum.map(username, &sanitise/1))
  end
end
