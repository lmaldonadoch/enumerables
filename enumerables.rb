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

  def my_count(item = nil)
    if item.nil? and not block_given?
      return self.length
    else
      count = 0
      self.my_each do |x|
        if block_given?
          count += 1 if yield x
        else
          count += 1 if x == item
        end
      end
    end
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    ret_arr = []
    self.my_each do |x|
      ret_arr << (!proc.nil? ? proc.call(x) : yield(x))
    end
    ret_arr
  end

  def my_inject(*args)
    
    dummy = self.dup
    unless block_given?

      if args.length > 1
        sum = args.shift
      else
        sum = dummy.shift
      end
      dummy.my_each do |x|
        sum = sum.send(args[0].to_s, x)
      end
      return sum
    end

    if args.length.positive?
      sum = args[0]
    else
      sum = dummy.shift
    end

    dummy.my_each do |x|
      sum = yield sum, x
    end

    sum
  end

  def multiply_els
    my_inject(:*)
  end

end

# all = ([1,2,3,4,5, 4, 4, 6, 7, 4]).my_inject(100) do |sum, n|
#   sum*n
# end
# p all

square = Proc.new do |x|
  x*x
end

p ([1,2,3,4,5].map do |n| 
  n*n
end)

