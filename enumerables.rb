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
      if x === nil or x === false
        return false
      elsif block_given?
        return false unless yield x
      elsif pattern.class == Regexp
        return false unless pattern =~ x
      elsif pattern.class == Class
        return false unless x.class == pattern
      else
        return true
      end
    end
    true
  end

  def my_any?(pattern = nil)

    self.my_each do |x|
      if x == nil or x == false
        return true
      elsif block_given?
        return true if yield x
      elsif pattern.class == Regexp
        return true if pattern =~ x
      elsif pattern.class == Class
        return true if x.class == pattern
      else
        return false
      end
    end
    false
  end

  def my_none?(pattern = nil)
    
    self.my_each do |x|
      if x == true
        return false
      elsif block_given?
        return false if yield x
      elsif pattern.class == Regexp
        return false if pattern =~ x
      elsif pattern.class == Class
        return false if x.class == pattern
      else
        return true
      end
    end
    true
  end
end

evens = ([1,2,3,4,5]).my_select do |n|
  n % 2 == 0
end
p evens

all = ([1,2,3,4,nil]).my_none?(String)
p all
