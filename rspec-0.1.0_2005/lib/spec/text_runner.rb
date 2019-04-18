module Spec
  class TextRunner

    def initialize
      common_initialization
      @output = $stdout
    end
  
    def initialize(appendable)
      common_initialization
      @output = appendable
    end

    def common_initialization
      @failures = Array.new
      @specification_count = 0
      @expectation_count = 0
      @failure_count = 0
    end
  
    def run(context_or_collection)
      start_run
      context_or_collection.collection.each {|context| context.run(self)}
      end_run
    end
  
    def pass(spec)
      @output << "."
      @expectation_count += 1
    end

    def failure(spec, exception)
      @output << "X"
      @expectation_count += 1
      @failures << exception
    end
  
    def spec(spec)
      @specification_count += 1
    end
  
    def start_run
      @output << "\n"
      @start_time = Time.new
    end
  
    def end_run
      @end_time = Time.new
      @output << "\n\n"

      dump_failures
      
      dump_duration(@end_time - @start_time)
      
      dump_counts
    end
    
    def dump_failures
      @failures.inject(1) do |index, exception|
        @output << index.to_s << ") " 
        @output << exception.to_s << "\n"
        dump_backtrace(exception.backtrace)
        index + 1
      end
    end

    def dump_backtrace(trace)
      lines = trace.reject {|line| line.include? "lib/spec"}
      @output << lines.join("\n")
      @output << "\n\n"
    end
    
    def dump_duration(duration)
      @output << "Finished in " << duration.to_s << " seconds\n"
    end
    
    def dump_counts
      @output << "\n" << @specification_count.to_s << " specifications, "
      @output << @expectation_count.to_s << " expectations, "
      @output << @failures.length.to_s << " failures\n"
    end
    
  end
end
