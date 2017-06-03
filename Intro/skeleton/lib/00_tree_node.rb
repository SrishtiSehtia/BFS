require 'byebug'
class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    if node && !node.children.include?(self)
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    child_node.parent=(nil)
    raise "error" unless @children.include?(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value

    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_child = queue.shift
      return current_child if current_child.value == target_value
      queue += current_child.children
    end

    nil
  end

end
