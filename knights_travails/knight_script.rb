require_relative "../skeleton/lib/00_tree_node.rb"
require 'byebug'


class KnightPathFinder

  attr_reader :move_tree

  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]
    @move_tree = build_move_tree(start_position)
    return nil
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

  def build_move_tree(root)
    root_node = PolyTreeNode.new(root)
    tree = [root_node]
    queue = [root_node]
    until queue.empty?
      current = queue.shift
      new_node_positions = new_move_positions(current.value)
      nodes = []
      new_node_positions.each do |position|
        node = PolyTreeNode.new(position)
        node.parent = current
        nodes << node
      end
      queue.concat(nodes)
      tree.concat(nodes)
    end
    tree
  end

  def find_path(end_pos)
    target_node = @move_tree[0].dfs(end_pos)
    trace_path_back(target_node)
  end

  def trace_path_back(target_node)
    path_array = []
    path_array.unshift(target_node)
    until path_array[0].parent.nil?
      next_node = path_array[0].parent
      path_array.unshift(next_node)
    end
    path_array.map { |el| el.value }
  end
end
kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
