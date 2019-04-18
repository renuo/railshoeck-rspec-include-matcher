describe 'Renuo knowledge' do
  let(:employees) do
    [
      { name: 'Alessandro', knows: %w(Rails Cancancan)},
      { name: 'Josua', knows: %w(9gag) },
    ]
  end

  it 'has a valid first Alessandro' do
    employees.should include({ name: 'Alessandro', knows: %w(Rails Cancancan)})
    employees.first.should include(:name)
    employees.first.should include(name: 'Alessandro')
  end
end
