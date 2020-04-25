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

  def my_all?(pattern = nil)
    return false if include?(nil) || include?(false)

    my_each do |x|
      if block_given?
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
    return true if include?(nil)
    return true if include?(false)

    my_each do |x|
      if block_given?
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
    return true if include?(true)

    my_each do |x|
      if block_given?
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
    my_each do |x|
      ret_arr << (!proc.nil? ? proc.call(x) : yield(x))
    end
    ret_arr
  end

  def my_inject(*args)
    dummy = dup
    unless block_given?

      sum = (args.length.positive? ? args.shift : sum = dummy.shift)

      dummy.my_each do |x|
        sum = sum.send(args[0].to_s, x)
      end
      return sum
    end

    sum = (args.length.positive? ? args[0] : dummy.shift)

    dummy.my_each do |x|
      sum = yield sum, x
    end

    sum
  end

  def multiply_els
    my_inject(:*)
  end
end

puts "The array input for all our methods is [1, 2, 3, 4, 5]"
puts ' '

all = [1, 2, 3, 4, 5].my_inject(100) do |sum, n|
  sum * n
end
puts "The result for my_inject(100) {|sum, n| sum * n} is #{all}"
puts ' '

square = proc do |x|
  x * x
end

array = [1, 2, 3, 4, 5]

p "The result for my_map with a block of n * 100 is #{array.my_map {|n| n * 100}}"
puts ' '

puts "The result for my_map with a proc x * x is #{(array.map(&square))}"
puts ' '

print  "The result of my_each_with_index for the index is "
array.my_each_with_index { |_n, i| print(i.to_s + ' ') }
puts ' '
puts ' '

puts "This is the result of my_select for even numbers is #{array.my_select { |n| (n % 2).zero? }}"
puts ' '

puts "This is the result of my_all for n < 10 #{array.my_all? { |n| n < 10 }}"
puts ' '

puts "This is the result of my_any for n == 10 #{array.my_any? { |n| n == 10 }}"
puts ' '

puts "This is the result of my_none for n == 1 #{array.my_none? { |n| n == 1 }}"
puts ' '

puts "This is the result of my_count for even numbers is #{array.my_count { |n| (n % 2).zero? }}"
puts ' '
