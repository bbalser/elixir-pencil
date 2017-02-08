defmodule Pencil do

  def new(durability) do
    {:ok, pid} = Agent.start_link(fn -> durability end)
    pid
  end

  def write(pencil, paper, string) do
    {new_durability, output} = determine_output_and_durability(string, current_durability(pencil))
    update_durability(pencil, new_durability)
    Paper.write(paper, output)
  end

  defp current_durability(pencil), do: Agent.get(pencil, &(&1))

  defp update_durability(pencil, new_durability), do: Agent.update(pencil, fn _state -> new_durability end)

  defp determine_output_and_durability(string, current_durability) do
    String.codepoints(string)
      |> Enum.reduce({current_durability, ""}, fn (next, {durability, buffer}) ->
            case {is_whitespace?(next), durability >= durability_loss(next)}  do
              {true, _}  -> {durability, buffer <> next}
              {_, false} -> {durability, buffer <> " "}
              {_, _}  -> {durability - durability_loss(next), buffer <> next}
            end
         end)
  end

  defp durability_loss(character) do
    case is_upcase?(character) do
      true -> 2
      false -> 1
    end
  end

  defp is_whitespace?(character) do
    Regex.match?(~r/^\s$/, character)
  end

  defp is_upcase?(character) do
    String.upcase(character) == character
  end

end
