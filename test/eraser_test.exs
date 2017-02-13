defmodule EraserTest do
  use ExUnit.Case, aync: true
  use ExUnit.Parameterized

  setup do
    sheet = Paper.new_sheet
    {:ok, [sheet: sheet]}
  end

  test "eraser can erase text already written to paper", ctx do
    Paper.write(ctx[:sheet], "Howdy Doody")

    Eraser.erase(ctx[:sheet], "Howdy")

    assert "      Doody" == Paper.read(ctx[:sheet])
  end

  test "eraser will erase the last instance of the string written to paper", ctx do
    Paper.write(ctx[:sheet], "How much wood would a woodchuck chuck if a woodchuck could chuck wood?")

    Eraser.erase(ctx[:sheet], "chuck")

    assert "How much wood would a woodchuck chuck if a woodchuck could       wood?" == Paper.read(ctx[:sheet])

    Eraser.erase(ctx[:sheet], "chuck")

    assert "How much wood would a woodchuck chuck if a wood      could       wood?" == Paper.read(ctx[:sheet])
  end

end
