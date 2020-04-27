module Enumerable
  def my_each
    return to_enum unless block_given?

    length.times { |x| yield self[x] }
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    length.times { |x| yield self[x], x }
    self
  end

  def my_select
    return to_enum unless block_given?

    ret_arr = []
    my_each do |x|
      next unless yield(x)

      ret_arr << x
    end
    ret_arr
  end

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_all?(pattern = nil)

    my_each do |x|
      if block_given?
        return false unless yield x
      elsif pattern.class == Regexp
        return false unless pattern =~ x
      elsif pattern.class == Class
        return false unless x.class == pattern
      elsif !pattern.nil?
        return false unless x == pattern
      else
        return true
      end
    end
    true
  end

  def my_any?(pattern = nil)

    return false if (self - [nil, false]) == []
    my_each do |x|
      if block_given?
        return true if yield x
      elsif pattern.class == Regexp
        return true if pattern =~ x
      elsif pattern.class == Class
        return true if x.class == pattern
      elsif !pattern.nil?
        return true if x == pattern
      else
        return true unless x
      end
    end
    return false unless pattern.nil?
    true
  end

  def my_none?(pattern = nil)
    return true if include?(true) || (self - [nil, false]) == [] || length < 2

    my_each_with_index do |x, i|
      if block_given?
        return false if yield x
      elsif pattern.class == Regexp
        return false if pattern =~ x
      elsif pattern.class == Class
        return false if x.class == pattern
      elsif !pattern.nil?
        return false if x == pattern
      else
        return false if (i > 0 && self[i] != self[i-1])
      end
    end
    true
  end

  # rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity

  def my_count(item = nil)
    return length if item.nil? && !block_given?

    count = 0
    my_each do |x|
      if block_given?
        count += 1 if yield x
      elsif x == item
        count += 1
      end
    end

    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    ret_arr = []
    my_each { |x| ret_arr << (!proc.nil? ? proc.call(x) : yield(x)) }
    ret_arr
  end

  def my_inject(*args)
    dummy = dup
    unless block_given?

      sum = (args.length >= 1 ? args.shift : sum = dummy.shift)

      dummy.my_each { |x| sum = sum.send(args[0].to_s, x) }
      return sum
    end

    sum = (args.length.positive? ? args[0] : dummy.shift)

    dummy.my_each { |x| sum = yield sum, x }
    sum
  end

  def multiply_els
    my_inject(:*)
  end
end
