defmodule Paper do

  def new_sheet do
    {:ok, pid} = Agent.start_link(fn -> "" end)
    pid
  end

  def write(sheet, string) do
    Agent.update sheet, fn state -> state <> string end
  end

  def read(sheet) do
    Agent.get sheet, fn state -> state end
  end

  def erase(sheet, index) do
    Agent.update sheet, fn state ->
      StringUtil.replace_at(state, index, " ")
    end
  end

end
