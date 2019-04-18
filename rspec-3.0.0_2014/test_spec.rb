describe 'Renuo knows' do
  let(:employees) do
    [
      { name: 'Alessandro', knows: %w(Rails Cancancan)},
      { name: 'Josua', knows: %w(9gag) }
    ]
  end

  it 'can do rails' do
    employees.should
      include(a_hash_including(knows: a_collection_including('Rails')))
  end
end
