describe Sudoku::Step do
  let(:cell) do
    cell = double('cell', value: nil, possible_values: [1,2,3])
  end
  subject{ Sudoku::Step.new(cell)}

  it 'tracks initial value and possible_values' do
    expect(subject.cell).to eq cell
    expect(subject.possible_values).to eq([1,2,3])
    expect(subject.initial_possible_values).to eq([1,2,3])
    expect(subject.initial_value).to be_nil
  end

  it 'does not execute if no possible values'
  it 'does not execute if no possible values'
end