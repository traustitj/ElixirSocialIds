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

  @spec months(integer()) :: [28 | 29 | 30 | 31, ...]
  def months(year) do
    if is_leap_year(year) do
      [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    else
      [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    end
  end

  @spec calc_two_arrays([number()], [number()], any()) :: [any()]
  def calc_two_arrays([], [], totals) do
    totals |> Enum.reverse
  end

  def calc_two_arrays([head1 | tail1], [head2 | tail2], totals) do
    calc_two_arrays(tail1, tail2, [head1 * head2 | totals])
  end

  @spec is_leap_year(integer()) :: boolean()
  def is_leap_year(year) do
    if rem(year, 400) == 0 or ((rem(year, 4) == 0) and (rem(year, 100) != 0)) do
      true
    else
      false
    end
  end

  @spec get_days_in_month(integer(), integer()) :: [any()]
  def get_days_in_month(month, year) do
    days = Enum.at(months(year), month - 1)
    Enum.to_list(1..days)
    |> Enum.map(fn(x) -> Integer.to_string(x) end)
    |> Enum.map(fn(x) -> String.pad_leading(x, 2, "0") end )
  end

  @spec get_full_dates(integer(), any(), any()) :: [any()]
  def get_full_dates(year, month, days) do
    newyear = rem(year, 100) |> Integer.to_string |> String.pad_leading(2, "0")
    newmonth = month |> Integer.to_string |> String.pad_leading(2, "0")
    newdays = Enum.map(days, fn(x) -> Integer.to_string(x) end ) |> Enum.map(fn(x) -> String.pad_leading(x, 2, "0") end)

    newdays
      |> Enum.map(fn(x) -> "#{x}#{newmonth}#{newyear}" end)
  end

  def add_counter_to_dates(dates) do
    endings = 20..99
    |> Enum.map( fn(x) -> Integer.to_string(x) end )
    |> Enum.map( fn(x) -> x end)

    dates
    |> Enum.map(fn(x) -> Enum.map(endings, fn(y) -> "#{x}-#{y}" end) end)
    |> List.flatten
  end

  @spec get_checksum(binary()) :: integer()
  def get_checksum(idnumber) do
    tmp1 = String.replace(idnumber, "-", "")
    idnumbers = String.split(tmp1, "", trim: true) |> Enum.map(fn(x) -> String.to_integer(x) end)

    result = calc_two_arrays(idnumbers, [3, 2, 7, 6, 5, 4, 3, 2], []) |> Enum.sum
    remaining = rem(result, 11)
    if remaining == 0 do
      0
    else
      11 - remaining
    end
  end

  @spec add_checksum_to_id(binary()) :: binary()
  def add_checksum_to_id(idnumber) do
    "#{idnumber}#{get_checksum(idnumber)}"
  end

  @spec get_century_from_year(integer()) :: integer()
  def get_century_from_year(year) do
    rem(div(year, 100), 10)
  end

  @spec add_century_to_id(any(), integer()) :: binary()
  def add_century_to_id(idnumber, year) do
    "#{idnumber}#{get_century_from_year(year)}"
  end

  def is_checksum_legal(idnumber) do
    x = String.split(idnumber, "-")
    if String.length(Enum.at(x, 1)) == 3 do
      true
    else
      false
    end
  end

  def generate_dates_for_full_month(month, year) do
    days = 1..Enum.at(months(year), month - 1)
    get_full_dates(year, month, days)
  end

  def generate_id_numbers_for_year(year) do
    Enum.to_list 1..12
    |> Enum.map(&(generate_dates_for_full_month(&1, year))) |> List.flatten
    |> add_counter_to_dates
    |> Enum.map(&add_checksum_to_id(&1))
    |> Enum.filter(&is_checksum_legal(&1) == true)
    |> Enum.map(&add_century_to_id(&1, year))
  end
end
