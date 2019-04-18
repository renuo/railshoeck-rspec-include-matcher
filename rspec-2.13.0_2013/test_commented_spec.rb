
describe 'Renuo knowledge' do
  let(:alessandro) do
    { name: 'Alessandro', knowledge: ['Rails', 'Cancancan'] }
  end
  let(:employees) do
    [
      alessandro,
      { name: 'Martin', knowledge: ['ReactNative', 'Rails'] },
      { name: 'Josua', knowledge: ['9gag'] },
      { name: 'Simon', knowledge: ['Rails', 'Angular'] }
    ]
  end

  # As of 2.0 three things can be matched:
  # - everything having an include? method
  # - hash keys
  # - hash parts
  it 'has a valid first Alessandro' do
    employees.should include(alessandro)
    employees.first.should include(:name)
    employees.first.should include(name: 'Alessandro')
  end
  # Internally it worked like this:
  # https://github.com/rspec/rspec-expectations/blob/v2.12.1/lib/rspec/matchers/built_in/include.rb#L29

  # Appearing in the RSpec 2.13 documentation as fuzzy matcher:
  RSpec::Matchers.define :an_employee_knowing do |expected|
    match do |actual|
      actual[:knowledge].include?(expected)
    end
    description do
      "an employee knowing '#{expected}'"
    end
  end

  # This works if "actual" is an array (why not enumerable?)
  # Basically checks if expected is a matcher
  it 'can do rails' do
    employees.should include(an_employee_knowing('Rails'))
    employees.should include(include(name: 'Alessandro'))
  end

  # lol https://github.com/rspec/rspec-expectations/blob/v2.13.0/lib/rspec/matchers/built_in/include.rb#L60

end
