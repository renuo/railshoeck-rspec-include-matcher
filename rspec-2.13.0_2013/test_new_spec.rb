describe 'Renuo knowledge' do
  let(:employees) do
    [
      { name: 'Alessandro', knows: %w(Rails Cancancan)},
      { name: 'Josua', knows: %w(9gag) },
    ]
  end

  RSpec::Matchers.define :an_employee_knowing do |expected|
    match { |actual| actual[:knows].include?(expected) }
  end

  it 'can do rails' do
    employees.should include(an_employee_knowing('Rails'))
    employees.should include(include(name: 'Alessandro'))
  end
end
