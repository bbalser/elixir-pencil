defmodule Eraser do

  def erase(sheet, string) do
    Paper.read(sheet)
      |> :binary.matches(string)
      |> List.last
      |> to_list_of_indexes
      |> erase_indexes(sheet)
  end

  defp to_list_of_indexes({index, length}) do
    Enum.to_list index..(index+length)
  end

  defp erase_indexes(indexes, sheet) do
    Enum.each indexes, fn index ->
      Paper.erase(sheet, index)
    end
  end

end
