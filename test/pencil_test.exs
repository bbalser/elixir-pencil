defmodule PencilTest do
  use ExUnit.Case, aync: true

  test "pencil will write text to sheet of paper" do
    sheet = Paper.new_sheet

    Pencil.write(sheet, "It was the best of times, it was the worst of times")

    assert "It was the best of times, it was the worst of times" == Paper.read(sheet)
  end

end
