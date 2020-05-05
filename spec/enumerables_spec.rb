require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:words_array) { %w[ant bear cat] }
  let(:nil_true) { [nil, true, 99, false] }
  let(:proced) { proc { |n| n * 2 } }
  let(:regexp_array) { %w[haystack hay hayabusa] }
  describe '#my_each' do
    it 'Returns each element' do
      expect(array.my_each { |n| n**2 }).to eql(array.each { |n| n**2 })
    end

    it 'Returns enumerator' do
      expect(array.my_each.class).to be(array.each.class)
    end

    it 'calls the given block for each of the items in the array' do
      each_output = 0
      block = proc { |num| each_output += num }
      array.my_each(&block)
      my_each_output = each_output.dup
      each_output = 0
      array.each(&block)
      expect(my_each_output).to eq(each_output)
    end
  end

  describe '#my_each_with_index' do
    it 'Returns each element' do
      expect(array.my_each_with_index { |n, _i| n**2 }).to eql(array.each_with_index { |n, _i| n**2 })
    end

    it 'Returns enumerator' do
      expect(array.my_each_with_index.class).to be(array.each_with_index.class)
    end

    it 'calls the given block for each of the items in the array with its index' do
      each_output = 0
      block = proc { |val, idx| each_output += (val + idx) }
      array.my_each_with_index(&block)
      my_each_output = each_output.dup
      each_output = 0
      array.each_with_index(&block)
      expect(my_each_output).to eq(each_output)
    end
  end

  describe '#my_select' do
    it 'Returns even numbers' do
      expect(array.my_select(&:even?)).to eql(array.select(&:even?))
    end

    it 'Returns words shorter than 4 characters' do
      expect(words_array.my_select { |n| n.length < 4 }).to eql(words_array.select { |n| n.length < 4 })
    end

    it 'Returns enumerator' do
      expect(array.my_select.class).to be(array.select.class)
    end
  end

  describe '#my_all?' do
    it 'Returns false for even numbers' do
      expect(array.my_all?(&:even?)).to eql(array.all?(&:even?))
    end

    it 'Return true for words smaller than 5' do
      expect(words_array.my_all? { |n| n.length < 5 }).to eql(words_array.all? { |n| n.length < 5 })
    end

    it 'Return false for all equal' do
      expect(nil_true.my_all?).to eql(nil_true.all?)
    end

    it 'Return false for all equal' do
      expect(nil_true.my_all?).to eql(nil_true.all?)
    end

    it 'Return true for a regular expression /hay/ in an array of words' do
      expect(regexp_array.my_all?(/hay/)).to eql(regexp_array.all?(/hay/))
    end

    it 'Return true for a class of string for an array of strings' do
      expect(regexp_array.my_all?(String)).to eql(regexp_array.all?(String))
    end

    it 'Return false for a value given as a parameter for an array with different values' do
      expect(array.my_all?(2)).to eql(array.all?(2))
    end
  end

  describe '#my_any?' do
    it 'Returns true if any number is even' do
      expect(array.my_any?(&:even?)).to eql(array.any?(&:even?))
    end

    it 'Returns false for words shorter than 3 characters' do
      expect(words_array.my_any? { |n| n.length < 3 }).to eql(words_array.any? { |n| n.length < 3 })
    end

    it 'Returns true for any element in an array' do
      expect(nil_true.my_any?).to eql(nil_true.any?)
    end

    it 'Return true for a regular expression /hay/ in an array of words' do
      expect(regexp_array.my_any?(/hay/)).to eql(regexp_array.any?(/hay/))
    end

    it 'Return true for a class of number for an array of values with different classes' do
      expect(nil_true.my_any?(Integer)).to eql(nil_true.any?(Integer))
    end

    it 'Return true for a value given as a parameter for an array with different values' do
      expect(array.my_any?(2)).to eql(array.any?(2))
    end
  end

  describe '#my_none?' do
    it 'Returns false for even numbers' do
      expect(array.my_none?(&:even?)).to eql(array.none?(&:even?))
    end

    it 'Returns true for words of length 5' do
      expect(words_array.my_none? { |n| n.length == 5 }).to eql(words_array.none? { |n| n.length == 5 })
    end

    it 'Returns true for empty arrays' do
      expect([].my_none?).to eql([].none?)
    end

    it 'Return false for a regular expression /hay/ in an array of words' do
      expect(regexp_array.my_none?(/hay/)).to eql(regexp_array.none?(/hay/))
    end

    it 'Return false for a class of number for an array of values with different classes' do
      expect(nil_true.my_none?(Integer)).to eql(nil_true.none?(Integer))
    end

    it 'Return true for a value not present in the array given as a parameter for an array with different values' do
      expect(array.my_none?(10)).to eql(array.none?(10))
    end
  end

  describe '#my_count' do
    it 'Returns 4 for even numbers' do
      expect(array.my_count(&:even?)).to eql(array.count(&:even?))
    end

    it 'Returns 2 for words shorter than 4 characters' do
      expect(words_array.my_count { |n| n.length < 4 }).to eql(words_array.count { |n| n.length < 4 })
    end

    it 'Returns 1 for true values' do
      expect(nil_true.my_count { |n| n == true }).to eql(nil_true.count { |n| n == true })
    end
  end

  describe '#my_map' do
    it 'Returns the numbers squared' do
      expect(array.my_map { |i| i * i }).to eql(array.map { |i| i * i })
    end

    it 'Return double for the proc n*2' do
      expect(array.my_map(&proced)).to eql(array.map(&proced))
    end

    it 'Returns the element given 4 times' do
      expect((1..4).my_map { 'cat' }).to eql((1..4).map { 'cat' })
    end

    it 'Returns enumerator' do
      expect(array.my_map.class).to be(array.map.class)
    end
  end

  describe '#my_inject' do
    it 'Returns the sum of all the array elements' do
      expect(array.my_inject(:+)).to eql(array.inject(:+))
    end

    it 'Returns the multiplication of all the array elements starting from one' do
      expect((5..10).my_inject(1, :*)).to eql((5..10).inject(1, :*))
    end

    it 'Returns the substraction of all the array elements starting from three' do
      expect((5..10).my_inject(3) { |sum, num| sum - num }).to eql((5..10).inject(3) { |sum, num| sum - num })
    end
  end
end
