defmodule PaperTest do
  use ExUnit.Case, async: true

  test "paper will reflect string that was written to it" do
    sheet = Paper.new_sheet
    
    Paper.write(sheet, "This is an awesome string")

    assert "This is an awesome string" == Paper.read(sheet)
  end

  test "paper will append written string to existing text on paper" do
    sheet = Paper.new_sheet
    Paper.write(sheet, "Howdy ")

    Paper.write(sheet, "Doody!")

    assert "Howdy Doody!" == Paper.read(sheet)
  end


end
