module Enumerable
  def my_each
    return to_enum unless block_given?

    self.length.times do |x|
      yield self[x]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    self.length.times do |x|
      yield self[x], x
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    ret_arr = []
    self.my_each do |x|
      next unless yield(x)

        ret_arr << x
      end
      ret_arr
  end

  def my_all?(pattern = nil)
    
    self.my_each do |x|
      if block_given?
        return false unless yield x
      elsif 

    end
  end

  def my_any?          ##### Double check the value for empty
    return true unless block_given?

    self.my_each do |x|
      if yield x
        return true
      end
    end
    false
  end

  def my_none?          ##### Double check the value for empty
    return true unless block_given?

    self.my_each do |x|
      if yield x
        return true
      end
    end
    false
  end
end

evens = ([1,2,3,4,5]).my_select do |n|
  n % 2 == 0
end
p evens

all = ([1,2,3,4,5]).my_any? do |n|
  n == 4
end
p all
