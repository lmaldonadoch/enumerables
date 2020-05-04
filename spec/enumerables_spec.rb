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
    it 'returns even numbers' do
      expect(array.my_any?{ |n| n.even? }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns even numbers' do
      expect(array.my_any?{ |n| n.even? }).to eql(true)
    end
  end
end