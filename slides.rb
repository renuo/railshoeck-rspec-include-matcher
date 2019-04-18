# encoding: utf-8

def b(str)
  "\e[1m#{str}\e[0m"
end

center <<~EOS
  #{b 'A bit of RSpec history'}


  Josua Schmid
  @schmijos

  Railshöck Spring 2019
EOS

section 'What is RSpec' do
  block <<~EOS
    A library for Behaviour Driven Development

    The three amigos discuss specifications
    and gather a common understanding.

    #{b 'Not'} verification testing #{b 'but'} behaviour specification
  EOS

  code <<~EOS
    describe 'hash generation' do
      context 'of the first position' do
        subject { instance[0].to_h }

        let(:bbs_attributes) do
          {
            subpositions: [
              a_hash_including(product_code: bse.product_code),
              a_hash_including(product_code: bso.product_code),
              a_hash_including(product_code: bss.product_code)
            ]
          }
        end

        it { is_expected.to include(bbs_attributes) }
      end
    end
  EOS

  block <<~EOS
    RSpec Timeline:

    * 2004 "Why your code sucks" of Dave Astel
    * 2005 Reference implementation of Steven Baker
    * 2006 v0.7 uses now RSpec instead of TestUnit
    * 2007 v0.8 switches to expectation matchers
    * 2007 v1.0 (Ruby 1.8)
    * 2010 v2.0 (Ruby 1.9) takes in micronaut runner
    * 2014 v3.0 (Ruby 2.1)
  EOS

  block <<~EOS
    Cucumber Timeline:

    * 2004 JBehave
    * 2007 RBehave
    * 2007 RBehave becomes RSpec story runner
    * 2009 Cucumber gets extracted
  EOS

end

section '2005 – RSpec v0.1' do
  code File.read('./rspec-0.1.0_2005/test_spec.rb')

  code <<~EOS
    def should_include(sub, message=nil)
      message ||= "<\#{self.inspect}> should include <\#{sub.inspect}>"
      \e[32mshould\e[0m(message) { self.include? sub }
    end
  EOS

  code <<~EOS
    def \e[32mshould\e[0m(message=nil)
      message ||= "Expectation not met."
      if (! yield)
        raise Spec::Exceptions::ExpectationNotMetError.new(message)
      end
    end
  EOS
end

section '2006 – RSpec v0.3' do
  code File.read('./rspec-0.3.2_2006/test_spec.rb')

  block <<~EOS
    "specification" is aliased if an environment variable is defined
  
    USER=marick bundle exec spec ./test_spec.rb
  EOS
end

section '2007 – RSpec v0.8' do
  code File.read('./rspec-0.8.2_2007/test1_spec.rb')
  code File.read('./rspec-0.8.2_2007/test2_spec.rb')
  code File.read('./rspec-0.8.2_2007/test3_spec.rb')
  code File.read('./rspec-0.8.2_2007/test4_spec.rb')
end

section '2009 – RSpec v1.2' do
  code File.read('./rspec-1.2.9_2009/test1_spec.rb')
  code File.read('./rspec-1.2.9_2009/test2_spec.rb')
  code <<~EOS
    # lib/spec/matchers/include.rb

    if actual.is_a?(Hash)
      if expected.is_a?(Hash)
        expected.each_pair do |k,v|
          return false unless actual[k] == v
        end
      else
        return false unless actual.has_key?(expected)
      end
    else
      return false unless actual.include?(expected)
    end

    return true
  EOS
end

section '2013 – RSpec v2.13' do
  code File.read('./rspec-2.13.0_2013/test_new_spec.rb')
  code <<~EOS
    # lib/rspec/matchers/built_in/include.rb
    
    if comparing_hash_values?(actuals, expected)
      expected.__send__(hash_predicate) { |k,v|
        actuals.has_key?(k) && actuals[k] == v
      }
    elsif comparing_hash_keys?(actuals, expected)
      actuals.has_key?(expected)
    elsif comparing_with_matcher?(actual, expected)
      actual.any? { |value| \e[32mexpected.matches?(value)\e[0m }
    else
      actuals.include?(expected)
    end
  EOS
end

section '2014 – RSpec v3.0' do
  code File.read('./rspec-3.0.0_2014/test_spec.rb')
  code <<~EOS
    # lib/rspec/matchers.rb  

    def include(*expected)
      BuiltIn::Include.new(*expected)
    end
    alias_matcher :a_collection_including, :include
    alias_matcher :a_string_including,     :include
    alias_matcher :a_hash_including,       :include
    alias_matcher :including,              :include
  EOS
  code <<~EOS
    class Include < BaseMatcher; … end

    class BaseMatcher
      include RSpec::Matchers::Composable
    end

    module Composable
      def and(matcher) …
      def or(matcher) …
      def values_match?(expected, actual) …
    end
  EOS
  code <<~EOS
    # lib/rspec/matchers/composable.rb
    
    def values_match?(expected, actual)
      expected = with_matchers_cloned(expected)
      Support::FuzzyMatcher.values_match?(expected, actual)
    end
  EOS
  code <<~EOS
    # lib/rspec/support/fuzzy_matcher.rb

    def self.hashes_match?(expected_hash, actual_hash)
      return false if expected_hash.size != actual_hash.size

      expected_hash.all? do |expected_key, expected_value|
        actual_value = actual_hash.fetch(expected_key) { return false }
        \e[32mvalues_match?(expected_value, actual_value)\e[0m
      end
    end
  EOS
end

section 'Future' do
  code <<~EOS
    describe 'Renuo knows and teaches' do
      let(:employees) do
        [
          { name: 'Alessandro', knows: %w(Rails Cancancan), teaches: %w('Rails')},
          { name: 'Josua', knows: %w(Ruby) }
        ]
      end

      it 'can do rails' do
        employees.should include(a_hash_including(
          a_string_matching(/knows|teaches/): a_collection_including('Rails')
        ))
      end
    end
  EOS
  code <<~EOS
    # spec/rspec/support/fuzzy_matcher_spec.rb:118

    it 'does not fuzzy match on keys' do
      expect(/foo/ => 1).not_to match_against("foo" => 1)
    end
  EOS
end

center 'Thank you!'
