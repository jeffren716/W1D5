require 'byebug'

class PolyTreeNode
  attr_accessor :children

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

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Error" if self.children.none? { |el| el == child_node }
    child_node.parent = nil
  end

  def parent=(parent)
    return if @parent == parent
    old_parent = @parent
    @parent = parent
    unless parent == nil || parent.children.include?(self)
      parent.children << self
    end
    old_parent.children.reject!{ |el| el == self } unless old_parent.nil?
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      val = child.dfs(target_value)
      return val if val && val.value == target_value
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      head = queue.shift
      return head if head.value == target_value
      queue.concat(head.children)
    end
    nil
  end
end
