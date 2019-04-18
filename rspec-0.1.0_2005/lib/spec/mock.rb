require 'spec'


class Mock

  def initialize
    @expectations = Hash.new
  end
  
  def __expects(sym)
    @expectations[sym] = MockExpectation.new
    @expectations[sym]
  end 

  def __verify
    @expectations.keys.each do |method|
      @expectations[method].verify(method.to_s) 
    end
  end
  
  def ignore_missing
    @ignore_missing = true
  end

  def method_missing(sym, *args, &block)
    if expectation = @expectations[sym]
      expectation.verify_call(sym.to_s,args,block)
    else
      begin
        super(sym, *args, &block) unless @ignore_missing 
      rescue NoMethodError
        raise Spec::Exceptions::MockExpectationError, "Unexpected method "+sym.to_s+" called."
      end
    end
  end

end


class MockExpectation

  def verify(message)
    unless @expected_call_count == @call_count
      raise Spec::Exceptions::MockExpectationError, 
        message+": Expected #{@expected_call_count} calls, got #{@call_count} calls"
    end
  end
  
  def verify_call(message,args,block)
    unless @expected_params == nil or @expected_params == args
      raise Spec::Exceptions::MockExpectationError,
        message+": Parameter mismatch: Expected <#{@expected_params}>, got <#{@args}>" 
    end
    args << block unless block.nil?
    @call_count = @call_count + 1
    @block.call(*args)
  end

  def initialize
    @block = proc {}
    @expected_call_count = 1
    @call_count = 0
    @expected_params = nil
  end

  def with(*args)
    @expected_params = args
    self
  end
  
  def with_no_args
    @expected_params = []
    self
  end
  
  def with_any_args
    @expected_params = nill
    self
  end
  
  def at_least_once
    self
  end
  
  def never
    @expected_call_count = 0
    self
  end
  
  def once
    @expected_call_count = 1
    self
  end
  
  def twice
    @expected_call_count = 2
    self
  end
  
  def returns(value=nil,&block)
    @block = block_given? ? block : proc { value }
  end
  
end
