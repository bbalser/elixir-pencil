defmodule StringUtilTests do
  use ExUnit.Case, aync: true
  use ExUnit.Parameterized

  test_with_params "is_whitespace? returns true for all whitespace characters",
    fn (input, result)->
      assert result == StringUtil.is_whitespace?(input)
    end do
      [
        {" ", true},
        {"\t", true},
        {"\n", true},
        {"a", false}
      ]
    end

  test_with_params "is_upcase returns true for all upper case characters",
    fn (input, result) ->
      assert result == StringUtil.is_upcase?(input)
    end do
      [
        {"A", true},
        {"a", false},
        {"B", true},
        {"b", false}
      ]
    end

  test_with_params "replace_at replaces the chracter at position int he string with the replacement ",
    fn (input, position, replacement, output) ->
      assert output == StringUtil.replace_at(input, position, replacement)
    end do
      [
        {"Hello", 1, "a", "Hallo"},
        {"Jerks", 4, ">", "Jerk>"},
        {"Baby", 0, "b", "baby"}
      ]
    end

end
