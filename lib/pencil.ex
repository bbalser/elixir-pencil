defmodule Pencil do

  def new(durability) do
    {:ok, pid} = Agent.start_link(fn -> durability end)
    pid
  end

  def write(pencil, paper, string) do
    durability = get_and_update_durability(pencil, String.length(string))
    output = slice_string(string, durability)
          |> String.pad_trailing(String.length(string))

    Paper.write(paper, output)
  end

  defp get_and_update_durability(pencil, amount_to_use) do
    Agent.get_and_update(pencil, fn durability -> {durability, max(0, durability - amount_to_use)} end)
  end

  defp slice_string(_string, length) when length <= 0, do: ""
  defp slice_string(string, length) do
    String.slice(string, 0..(length-1))
  end

end
