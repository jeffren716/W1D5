
require 'byebug'
class KnightPathFinder

  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]

  end

  def self.valid_moves(pos)
    array = []
    mover = [1, -1]
    mover2 = [2, -2]
    mover.each do |first|
      mover2.each do |second|
        array << [first, second]
      end
    end
    mover2.each do |first|
      mover.each do |second|
        array << [first, second]
      end
    end
    array.each do |el|
      el[0] += pos[0]
      el[1] += pos[1]
    end
    array.select { |el| el[0].between?(0, 7) && el[1].between?(0, 7) }
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject! { |position| @visited_positions.include?(position) }
    @visited_positions.concat(moves)
    moves
  end
end
