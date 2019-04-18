require 'spec'

describe 'Renuo knowledge' do
  context 'when not a hash' do
    let(:knowledge) { ['Rails', 'Angular', 'React'] }

    it 'can do rails' do
      knowledge.should include 'Rails', 'React'
    end

    example 'can not do Rust (yet)' do
      knowledge.should_not include 'Rust'
    end
  end
end
