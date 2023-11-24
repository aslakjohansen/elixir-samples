defmodule Expression do
  def eval({:number, _, number}) do
    number
  end
  def eval({:op_add, _, ls_expr, rs_expr}) do
    ls_value = eval(ls_expr)
    rs_value = eval(rs_expr)
    ls_value + rs_value
  end
  def eval({:op_sub, _, ls_expr, rs_expr}) do
    ls_value = eval(ls_expr)
    rs_value = eval(rs_expr)
    ls_value - rs_value
  end
  def eval({:op_mul, _, ls_expr, rs_expr}) do
    ls_value = eval(ls_expr)
    rs_value = eval(rs_expr)
    ls_value * rs_value
  end
  def eval({:op_div, _, ls_expr, rs_expr}) do
    ls_value = eval(ls_expr)
    rs_value = eval(rs_expr)
    ls_value / rs_value
  end
  def eval(_) do
    nil
  end

  def hello do
    examples = [
      {"42", 42},
      {"(42)", 42},
      {"42+56", 98},
      {"2*3+4", 10},
      {"2+3*4", 14},
      {"(2+3)*4", 20},
    ]

    results =
      for {string_expr, correct_result} <- examples do
        {:ok, tokens, _} = string_expr |> to_charlist() |> :expr_lexer.string()
        {:ok, expr} = :expr_parser.parse(tokens)
        result = eval(expr)
        case {result, correct_result} do
          {result, result} ->
            "#{string_expr}: success"
          _ ->
            "#{string_expr}: failure expected '#{correct_result}' but got '#{result}'"
        end
      end

    IO.puts("Test results:")
    results
    |> Enum.map(fn line -> "- #{line}\n" end)
    |> IO.puts()
  end
end
