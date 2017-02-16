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

end
