describe 'Renuo knowledge' do
  let(:employees) do
    [
      { name: 'Alessandro', knowledge: ['Rails', 'Cancancan'] },
      { name: 'Martin', knowledge: ['ReactNative', 'Rails'] },
      { name: 'Josua', knowledge: ['9gag'] },
      { name: 'Simon', knowledge: ['Rails', 'Angular'] }
    ]
  end

  it 'can do rails' do
    employees.should include(a_hash_including(knowledge: a_collection_including('Rails')))
    # This works for all "actual" who respond to :any?
    # Basically early returns for a lot of cases and otherwise passes the decision
    # to the fuzzy matcher (composable) after all the nested matchers have been cloned (reporting)
  end
end
