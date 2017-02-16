defmodule StringUtil do

  def is_whitespace?(character) do
    Regex.match?(~r/^\s$/, character)
  end

  def is_upcase?(character) do
    String.upcase(character) == character
  end

  def replace_at(string, position, replacement) do
    String.codepoints(string)
    |> List.replace_at(position, replacement)
    |> to_string
  end

end
