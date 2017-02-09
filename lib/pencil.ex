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

  defp determine_output_and_durability(string, durability) do
    process_durability_and_buffer(String.codepoints(string), {durability, ""})
  end

  defp process_durability_and_buffer([], state), do: state
  defp process_durability_and_buffer([head | tail], {current_durability, buffer}) do
    new_state = cond do
      current_durability >= durability_loss(head) -> {current_durability - durability_loss(head), buffer <> head}
      true -> {current_durability, buffer <> " "}
    end
    process_durability_and_buffer(tail, new_state)
  end

  defp durability_loss(character) do
    cond do
      is_whitespace?(character) -> 0
      is_upcase?(character) -> 2
      true -> 1
    end
  end

  defp is_whitespace?(character) do
    Regex.match?(~r/^\s$/, character)
  end

  defp is_upcase?(character) do
    String.upcase(character) == character
  end

end
