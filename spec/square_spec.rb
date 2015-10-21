include Sudoku
describe Square do
  subject{Square.new(0)}
  it 'sets neighbors to empty array is give' do
    expect(subject.neighbors).to be_empty
  end

  context 'value checking' do
    subject do
      square = Square.new(5)
      square.neighbors = 5.times.map{|i| Square.new(i, i + 1)}
      square
    end

    context '#valid_value?' do

      it 'checks neighbors to see if the value is taken' do
        expect(subject.valid_value?(5)).to be_falsy
        expect(subject.valid_value?(6)).to be_truthy
      end
    end

    context '#try' do
      it 'sets the value if value is valid' do
        expect(subject.try(6)).to be_truthy
        expect(subject.value).to eq 6
      end

      it 'does not set the value if value is invalid' do
        subject.value = 6
        expect(subject.try(5)).to be_falsy
        expect(subject.value).to eq 6
        expect(subject.try(nil)).to be_falsy
        expect(subject.value).to eq 6
      end

      it 'becomes invalid if neighbor changes' do
        subject.value = 6
        subject.neighbors[0].value = 6
        expect(subject).to be_invalid
      end

      it 'becomes valid if neighbor changes' do
        subject.value = 5
        expect(subject).to be_invalid
        subject.neighbors[4].value = 6
        expect(subject).to be_valid
      end
    end

    context '#to_s' do
      it 'returns "-" if value is nil' do
        expect(subject.to_s).to eq '-'
      end

      it 'returns to_s on value if value is not nil' do
        subject.value = 6
        expect(subject.to_s).to eq '6'
      end
    end
  end

end
