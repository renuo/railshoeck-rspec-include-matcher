require 'spec'

describe 'Renuo knowledge' do
  context 'when hash' do
    let(:knowledge) do
      {
        rails: ['Alessandro', 'Simon'],
        angular: ['Simon', 'Martin']
      }
    end

    it 'can do rails' do
      knowledge.should include :rails
      knowledge.should include(rails: ['Alessandro', 'Simon'])
    end
  end
end
