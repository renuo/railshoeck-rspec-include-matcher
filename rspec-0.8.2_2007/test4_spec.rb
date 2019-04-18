require 'spec'

renuo_knowledge = ['Rails', 'Angular', 'React']

context 'Renuo' do
  specify 'can do rails' do

    Spec::Matchers::Include.new('Rails').matches?(renuo_knowledge).should be(true)

  end
end

