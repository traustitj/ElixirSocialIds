defmodule SocialidTest do
  use ExUnit.Case
  doctest Socialid

  test "greets the world" do
    assert Socialid.hello() == :world
  end

  test "calculate two arrays" do
    assert Socialid.calc_two_arrays([1,2,3], [3,2,1], []) == [3,4,3]
    assert Socialid.calc_two_arrays([1,2,3], [4,2,1], []) == [4,4,3]
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
    assert Socialid.get_days_in_month(0, 2000) == ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
  end

  test "assert that year and months are added to dates" do
    assert Socialid.get_full_dates(2000, 1, [1,2,3]) == ["010100", "020100", "030100"]
  end

  test "assert that there are 79 items per day added" do
    list = Socialid.add_counter_to_dates(["010100", "020100", "030100"])
    assert Enum.at(list, 0) == "010100-20"
    assert Enum.at(list, 1) == "010100-21"
    assert Enum.at(list, 79) == "010100-99"
  end

  test "the checksum should be 3 for social id 030574-30" do
    assert Socialid.get_checksum("030574-30") == 3
    assert Socialid.get_checksum("120160-33") == 8
  end

  test "the checksum is added to the id number" do
    assert Socialid.add_checksum_to_id("030574-30") == "030574-303"
    assert Socialid.add_checksum_to_id("120607-40") == "120607-405"
    assert Socialid.add_checksum_to_id("240305-28") == "240305-283"
  end

  test "add the century to id number, 9 for 1900 and 0 for 2000" do
    assert Socialid.get_century_from_year(1987) == 9
    assert Socialid.get_century_from_year(1887) == 8
    assert Socialid.get_century_from_year(2087) == 0
  end

  test "check that the century number is added behind an id number" do
    assert Socialid.add_century_to_id("030574-303", 1974) == "030574-3039"
    assert Socialid.add_century_to_id("120607-405", 2007) == "120607-4050"
    assert Socialid.add_century_to_id("240305-283", 2005) == "240305-2830"
  end

  test "generate id numbers for a year and check if you find a specific id" do
    year1974 = Socialid.generate_id_numbers_for_year(1974)
    assert Enum.find(year1974, fn(x) -> x == "030574-3039" end) == "030574-3039"
    # year2005 = Socialid.generate_id_numbers_for_year(2005)
    # assert Enum.find(year2005, fn(x) -> x == "240305-2830" end) == "240305-2830"
  end

end
