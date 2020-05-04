require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) {[1,2,3,4,5,6,7,8,9]}
  let(:words_array) {%w[ant bear cat]}
  let(:nil_true) {[nil,true,99,false]}
  let(:proced) {proc {|n| n * 2}}
  describe '#my_each' do
    it 'returns each element' do
      expect(array.my_each{ |n| n*n }).to eql(array)
    end
  end
  

  describe '#my_each_with_index' do
    it 'returns each element' do
      expect(array.my_each_with_index{ |n| n*n }).to eql(array)
    end
  end

  describe '#my_select' do
    it 'returns even numbers' do
      expect(array.select{ |n| n.even? }).to eql([2,4,6,8])
    end

    it 'returns words shorter than 4 characters' do
      expect(words_array.select{ |n| n.length < 4 }).to eql(['ant', 'cat'])
    end
  end

  describe '#my_all?' do
    it 'Are all even numbers' do
      expect(array.my_all?{ |n| n.even? }).to eql(false)
    end

    it 'Return true for words smaller than 5' do
      expect(words_array.my_all?{ |n| n.length < 5 }).to eql(true)
    end

    it 'Return false for all equal' do
      expect(nil_true.my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'Returns true if any number is even' do
      expect(array.my_any?{ |n| n.even? }).to eql(true)
    end

    it 'Returns false for words shorter than 3 characters' do
      expect(words_array.my_any?{ |n| n.length < 3 }).to eql(false)
    end

    it 'Returns true for any element in an array' do
      expect(nil_true.my_any?).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'Returns false for even numbers' do
      expect(array.my_none?{ |n| n.even? }).to eql(false)
    end

    it 'Returns true for words of length 5' do
      expect(words_array.my_none?{ |n| n.length == 5 }).to eql(true)
    end

    it 'Returns true for empty arrays' do
      expect([].my_none?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'Returns 4 for even numbers' do
      expect(array.my_count{ |n| n.even? }).to eql(4)
    end

    it 'Returns 2 for words shorter than 4 characters' do
      expect(words_array.my_count{ |n| n.length < 4 }).to eql(2)
    end

    it 'Returns 1 for true values' do
      expect(nil_true.my_count{ |n| n == true }).to eql(1)
    end
  end

  describe '#my_map' do
    it 'Returns the numbers squared' do
      expect(array.my_map{ |i| i * i }).to eql([1,4,9,16,25,36,49,64,81])
    end

    it 'Return double for the proc n*2' do
      expect(array.my_map(&proced)).to eql([2,4,6,8,10,12,14,16,18])
    end

    it 'Returns the element given 4 times' do
      expect((1..4).my_map{"cat"}).to eql(['cat','cat','cat','cat'])
    end
  end

  describe '#my_inject' do
    it 'returns the sum of all the array elements' do
      expect(array.my_inject(:+)).to eql(45)
    end
  end
end