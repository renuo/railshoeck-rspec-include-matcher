require 'spec'

class RenuoKnowledgeSpec < Spec::Context
  def setup
    @stack = ['Rails', 'Angular', 'ReactNative']
  end

  def can_do_rails
    @stack.should_include 'Rails'
  end

  def cannot_do_rust_yet
    @stack.should_not_include 'Rust'
  end
end

runner = Spec::TextRunner.new($stdout)
runner.run(RenuoKnowledgeSpec)
