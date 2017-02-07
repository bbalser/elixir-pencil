defmodule PencilTest do
  use ExUnit.Case, aync: true

  setup do
    sheet = Paper.new_sheet
    {:ok, [sheet: sheet]}
  end

  test "pencil will write text to sheet of paper", ctx do
    pencil = Pencil.new(100)

    Pencil.write(pencil, ctx[:sheet], "It was the best of times, it was the worst of times")

    assert "It was the best of times, it was the worst of times" == Paper.read(ctx[:sheet])
  end

  test "when a pencil goes dull, it writes spaces to paper instead of text", ctx do
    pencil = Pencil.new(5)

    Pencil.write(pencil, ctx[:sheet], "possibilities")

    assert "possi        " == Paper.read(ctx[:sheet])
  end

  test "the pencil tracks its durability across multiple writes", ctx do
    pencil = Pencil.new(10)

    Pencil.write(pencil, ctx[:sheet], "Howdy ")
    Pencil.write(pencil, ctx[:sheet], "Doody ")
    Pencil.write(pencil, ctx[:sheet], "loves to ride his horse")

    assert "Howdy Dood                         " == Paper.read(ctx[:sheet])
  end

end
