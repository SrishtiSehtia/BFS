require_relative 'tree_node.rb'
require 'byebug'
class KnightPathFinder

  def initialize(start_pos = [0, 0])
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @first_pos = PolyTreeNode.new(start_pos)
  end

  def self.valid_moves(pos)
    moves = [
      [-2,1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1]
    ]

    valid_ends = []

    moves.each do |move|
      end_move = [pos[0] + move[0], pos[1] + move[1]]
      if end_move[0].between?(0, 7) && end_move[1].between?(0, 7)
        valid_ends << end_move
      end
    end
    valid_ends
  end

  def new_move_positions(moves)
    result = KnightPathFinder.valid_moves(moves).select { |move| !@visited_positions.include?(move)}
    @visited_positions.concat(result)
    result
  end

  def build_move_tree
    queue = [@first_pos]

    until queue.empty?
      current_move_node = queue.shift
      new_move_positions(current_move_node.value).each do |move|
        child_move_node = PolyTreeNode.new(move)
        queue << child_move_node
        current_move_node.add_child(child_move_node)
      end
    end
  end

  def find_path(end_pos)
    build_move_tree
    end_node = @first_pos.bfs(end_pos)
    puts trace_path_back(end_node).map(&:value)
  end

  def trace_path_back(end_node)
    trace_back = [end_node]
    until end_node && end_node.parent.nil?
      trace_back.unshift(end_node.parent)
      end_node = end_node.parent
    end
    trace_back
  end
end


kpf = KnightPathFinder.new
kpf.find_path([7, 6])
# kpf.find_path([6, 2])
