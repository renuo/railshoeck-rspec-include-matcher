require 'spec'

renuo_knowledge = ['Rails', 'Angular', 'React']

context 'Renuo' do
  specify 'can do rails' do

    renuo_knowledge.should include 'Rails'

  end
end
