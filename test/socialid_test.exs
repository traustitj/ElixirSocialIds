defmodule SocialidTest do
  use ExUnit.Case
  doctest Socialid

  test "greets the world" do
    assert Socialid.hello() == :world
  end

  test "calculate two arrays" do
    assert Socialid.calc_two_arrays([1,2,3], [3,2,1], []) == [4,4,4]
    assert Socialid.calc_two_arrays([1,2,3], [4,2,1], []) == [5,4,4]
  end

  test "is leap year" do
    assert Socialid.is_leap_year(1992) == true
    assert Socialid.is_leap_year(2000) == true
    assert Socialid.is_leap_year(1900) == false
  end

  test "year is 12 months" do
    assert length(Socialid.months(2000)) == 12
  end

  test "assure february is 28 days in normal year" do
    assert Enum.at(Socialid.months(2000), 1) == 29
    assert Enum.at(Socialid.months(1900), 1) == 28
  end

  test "get days of month" do
    assert Socialid.get_days_in_month(2000, 0) == ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
  end

  test "assert that year and months are added to dates" do
    assert Socialid.get_full_dates(2000, 1, [1,2,3]) == ["010100", "020100", "030100"]
  end

end
