require 'spec'

renuo_knowledge = ['Rails', 'Angular', 'React']

context 'Renuo' do
  specify 'can do rails' do

    Spec::Expectations::ExpectationMatcherHandler.handle_matcher(
      renuo_knowledge,
      Spec::Matchers::Include.new('Rails')
    )

  end
end
