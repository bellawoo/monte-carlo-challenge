require 'pry'
require 'minitest/autorun'

# Implement these classes to get the specs below to pass
class Dice
  def initialize sides
    @sides = sides.to_i
  end

  attr_reader :sides

  def roll
    rand(1..@sides)
  end

  def loaded?
    return false
  end
end



class LoadedDice < Dice
  def roll
    if super + 1
      # rand(1..@sides)+1
  end

  def but_really_is_it_loaded?
    return true
  end
end


class TestDice < MiniTest::Test
  def test_it_knows_how_many_sides_it_has
    d7 = Dice.new 7 # Take that, geometry
    assert_equal 7, d7.sides
  end

  def test_it_rolls_a_reasonable_range
    d20 = Dice.new 20
    rolls = []
    100.times { rolls.push d20.roll }

    assert rolls.max <= 20
    assert rolls.min >= 0
    assert rolls.uniq.count > 5
  end

  def test_it_rolls_a_fair_distribution_when_unloaded
    d6 = Dice.new 6
    total = 0
    1000.times { total += d6.roll }
    average = total / 1000.0

    assert_in_epsilon 3.5, average, 0.1
  end

  def test_it_knows_when_its_not_loaded
    dice = Dice.new 13
    assert !dice.loaded?
  end
# binding.pry

  # Work on these last, if time permits

  def test_it_lies_when_loaded
    dice = LoadedDice.new 13
    assert !dice.loaded?
    assert dice.but_really_is_it_loaded?
  end

  def test_it_rolls_off_when_loaded
    d6 = LoadedDice.new 6
    total = 0
    1000.times { total += d6.roll }
    average = total / 1000.0

    assert average > 3.51
  end

  def test_it_is_still_a_dice
    ld5 = LoadedDice.new 5
    assert ld5.is_a? Dice
  end
end
