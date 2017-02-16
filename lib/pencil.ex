defmodule Pencil do
  import StringUtil

  def new(durability, length \\ 1) do
    {:ok, pid} = Agent.start_link(fn -> %{initial_durability: durability, durability: durability, length: length} end)
    pid
  end

  def write(pencil, paper, string) do
    output = Agent.get_and_update pencil, fn state ->
      {new_durability, output} = determine_output_and_durability(string, state[:durability])
      {output, %{state | durability: new_durability} }
    end

    Paper.write(paper, output)
  end

  def sharpen(pencil) do
    Agent.update pencil, fn state ->
      case state[:length] > 0 do
        true -> %{state | durability: state[:initial_durability], length: state[:length] - 1}
        false -> state
      end
    end
  end

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

end
