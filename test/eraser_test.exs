defmodule EraserTest do
  use ExUnit.Case, aync: true
  use ExUnit.Parameterized

  setup do
    sheet = Paper.new_sheet
    {:ok, [sheet: sheet]}
  end

  test "eraser can erase text already written to paper", ctx do
    Paper.write(ctx[:sheet], "Howdy Doody")
    eraser = Eraser.new()

    Eraser.erase(eraser, ctx[:sheet], "Howdy")

    assert "      Doody" == Paper.read(ctx[:sheet])
  end

  test "eraser will erase the last instance of the string written to paper", ctx do
    Paper.write(ctx[:sheet], "How much wood would a woodchuck chuck if a woodchuck could chuck wood?")
    eraser = Eraser.new(25)

    Eraser.erase(eraser, ctx[:sheet], "chuck")

    assert "How much wood would a woodchuck chuck if a woodchuck could       wood?" == Paper.read(ctx[:sheet])

    Eraser.erase(eraser, ctx[:sheet], "chuck")

    assert "How much wood would a woodchuck chuck if a wood      could       wood?" == Paper.read(ctx[:sheet])
  end

  test "eraser will delete text in middle of word", ctx do
    Paper.write(ctx[:sheet], "foobar")
    eraser = Eraser.new(100)

    Eraser.erase(eraser, ctx[:sheet], "oob")

    assert "f   ar" == Paper.read(ctx[:sheet])
  end

  test "the eraser tip will degrade for every character that is erased and erase chracters is reverse order", ctx do
    Paper.write(ctx[:sheet], "Erase me please")
    eraser = Eraser.new(5)

    Eraser.erase(eraser, ctx[:sheet], "please")

    assert "Erase me p     " == Paper.read(ctx[:sheet])
  end

  test "the eraser does not degrade when erasing a whitespace character", ctx do
    Paper.write(ctx[:sheet], "Erase me please")
    eraser = Eraser.new(4)

    Eraser.erase(eraser, ctx[:sheet], "me ple")

    assert "Erase m     ase" == Paper.read(ctx[:sheet])
  end

end
