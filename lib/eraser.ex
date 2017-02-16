defmodule Eraser do
  import StringUtil

  def new(durability \\ 5) do
    {:ok, pid} = Agent.start_link(fn -> durability end)
    pid
  end

  def erase(pid, sheet, string) do
    text = Paper.read(sheet)
    text
      |> :binary.matches(string)
      |> List.last
      |> to_list_of_indexes
      |> remove_whitespaces(text)
      |> Enum.reverse
      |> erase_indexes(pid, sheet)
  end

  defp remove_whitespaces(indexes, original_string) do
    Enum.reject indexes, fn index -> String.at(original_string, index) |> is_whitespace? end
  end

  defp to_list_of_indexes({index, length}) do
    Enum.to_list index..(index+length-1)
  end

  defp erase_indexes(indexes, pid, sheet) do
    Agent.update pid, fn durability ->
      Enum.take(indexes, durability)
        |> Enum.each(fn index -> Paper.erase(sheet, index) end)

      durability - Enum.count(indexes)
    end
  end

end
