defmodule StringUtil do

  def is_whitespace?(character) do
    Regex.match?(~r/^\s$/, character)
  end

  def is_upcase?(character) do
    String.upcase(character) == character
  end

end
