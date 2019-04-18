require 'spec'

renuo_knowledge = ['Rails', 'Angular', 'React']

context 'Renuo' do
  specify 'can do rails' do

    renuo_knowledge.should(Spec::Matchers::Include.new('Rails'))

  end
end

