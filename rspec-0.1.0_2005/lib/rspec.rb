class RSpec

  def initialize(args)
    args.each do |file|
      require file
    end
  end

end
