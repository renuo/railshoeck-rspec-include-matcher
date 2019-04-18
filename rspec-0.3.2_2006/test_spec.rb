require 'spec'

knowledge_stack = ['Rails', 'Angular', 'ReactNative']

specification 'Renuo can do Rails' do
  knowledge_stack.should_include 'Rails'
end

example 'Renuo cannot do Rust (yet)' do
  knowledge_stack.should_not_include 'Rust'
end

Spec::TextRunner.new.run
