class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :completed

  def initialize(name, description, prep_time = "", difficulty = "", completed = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    @completed = completed
  end

  def mark_completed
    @completed = true
  end
end
