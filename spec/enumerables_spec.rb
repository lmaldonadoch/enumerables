require_relative '../enumerables.rb'

describe Enumerable do
  let(:array) {[1,2,3,4,5,6,7,8,9]}
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
  end

  describe '#my_all?' do
    it 'Are all even numbers' do
      expect(array.my_all?{ |n| n.even? }).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'returns true if any number is even' do
      expect(array.my_any?{ |n| n.even? }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns false for even numbers' do
      expect(array.my_none?{ |n| n.even? }).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns the amount of elements who are even' do
      expect(array.my_count{ |n| n.even? }).to eql(4)
    end
  end

  describe '#my_map' do
    it 'returns the numbers squared' do
      expect(array.my_map{ |i| i * i }).to eql([1,4,9,16,25,36,49,64,81])
    end
  end

  describe '#my_inject' do
    it 'returns the sum of all the array elements' do
      expect(array.my_inject(:+)).to eql(45)
    end
  end
end