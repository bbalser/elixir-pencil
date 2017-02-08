defmodule PencilTest do
  use ExUnit.Case, aync: true
  use ExUnit.Parameterized

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

    Pencil.write(pencil, ctx[:sheet], "howdy ")
    Pencil.write(pencil, ctx[:sheet], "doody ")
    Pencil.write(pencil, ctx[:sheet], "loves to ride his horse")

    assert "howdy doody                        " == Paper.read(ctx[:sheet])
  end

  test_with_params "writing spaces and newlines expends no graphite and should not reduce the durability of the pencil", ctx,
    fn (input, output) ->
      pencil = Pencil.new(10)

      Pencil.write(pencil, ctx[:sheet], input)

      assert output == Paper.read(ctx[:sheet])
    end do
      [
        {"the quick brown fox", "the quick br       "},
        {"the quick\tbrown\tfox", "the quick\tbr   \t   "},
        {"the quick\nbrown\nfox", "the quick\nbr   \n   "}
      ]
  end

  test_with_params "upper case characters cost twice the point durability", ctx,
    fn (input, output) ->
      pencil = Pencil.new(4)

      Pencil.write(pencil, ctx[:sheet], input)

      assert output == Paper.read(ctx[:sheet])
    end do
      [
        {"Text", "Tex "},
        {"texTy", "tex y"}
      ]
  end

end
