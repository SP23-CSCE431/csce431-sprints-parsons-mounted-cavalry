# frozen_string_literal: true

class HorsesTableComponent < ViewComponent::Base
  def initialize(horses)
    super @horses = horses
  end

  # maps the given horse's difficulty level to a color, returns the color
  def get_horse_difficulty_color(horse)
      colors = { 'Easy' => '#a7f1a8', 'Intermediate' => '#FFF36D', 'Advanced' => '#f47174' }

      if horse.nil?
          'none'
      else
          colors[horse.difficulty]
      end
  end

  # maps the given horse's difficulty level to a color, returns the color
  def get_horse_herd_color(horse)
      colors = { 'Alpha' => '#FFF36D', 'Bravo' => '#A7F1A8', 'Charlie' => '#83A0EE', 'Delta' => '#8B6C5C', 'OOS' => '#F47174' }

      if horse.nil?
          'none'
      else
          colors[horse.herd]
      end
  end
end
