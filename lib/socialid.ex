defmodule Socialid do
  @moduledoc """
  Documentation for Socialid.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Socialid.hello()
      :world

  """
  def hello do
    :world
  end

  def months(year) do
    if is_leap_year(year) do
      [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    else
      [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    end
  end

  def calc_two_arrays([], [], totals) do
    totals |> Enum.reverse
  end

  def calc_two_arrays([head1 | tail1], [head2 | tail2], totals) do
    calc_two_arrays(tail1, tail2, [head1 + head2 | totals])
  end

  def is_leap_year(year) do
    if rem(year, 400) == 0 or ((rem(year, 4) == 0) and (rem(year, 100) != 0)) do
      true
    else
      false
    end
  end

  def get_days_in_month(year, month) do
    days = Enum.at(months(year), month - 1)
    Enum.to_list(1..days)
    |> Enum.map(fn(x) -> Integer.to_string(x) end)
    |> Enum.map(fn(x) -> String.pad_leading(x, 2, "0") end )
  end

  def get_full_dates(year, month, days) do
    newyear = rem(year, 100) |> Integer.to_string |> String.pad_leading(2, "0")
    newmonth = month |> Integer.to_string |> String.pad_leading(2, "0")
    newdays = Enum.map(days, fn(x) -> Integer.to_string(x) end ) |> Enum.map(fn(x) -> String.pad_leading(x, 2, "0") end)

    newdays
      |> Enum.map(fn(x) -> "#{x}#{newmonth}#{newyear}" end)
  end

end
