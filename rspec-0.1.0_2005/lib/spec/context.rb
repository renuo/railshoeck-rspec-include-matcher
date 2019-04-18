require 'spec'


module Spec
  class Context
  
    def initialize(specification=nil)
      @specification = specification
    end

    def run(result_listener)
      result = false
    
      result_listener.spec(@specification)
      setup
      begin
        __send__(@specification)
        result_listener.pass(@specification)
      rescue Exception
        result_listener.failure(@specification, $!)
      end
      teardown
      
      return result
    end

    def setup
    end
    
    def teardown
    end

    def self.collection
      specs = []
      self.specifications.each do |spec|
        specs << self.new(spec.to_sym)
      end
      
      return specs
    end
  
    def self.specifications
      return self.my_methods.select {|spec| self.specification_name?(spec)}
    end

    def self.my_methods
      self.instance_methods - self.superclass.instance_methods
    end

    def self.specification_name?(name)
      return false if not self.new.method(name).arity == 0
      return false if name[0..0] == '_'
      return true
    end
    
    def violated
      raise Spec::Exceptions::ExpectationNotMetError.new
    end

  end
end
