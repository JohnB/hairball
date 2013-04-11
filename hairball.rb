
class Hairball
  def initialize(options)
    @sources = options[:sources]
    @converter = options[:converter]
    @destination = options[:destination]

    raise "No source files found" if @sources.empty?
    raise "No conversion found" unless @converter
    raise "No destination found" unless @destination
    @converter = @converter.new
    raise "Unable to create converter (did you giv an instance instead of the class?)" unless @converter

    raise ducks_not_aligned_message unless all_our_ducks_are_in_a_row?
  end

  def convert
    @sources.each do |source|
      result = @converter.convert(source)
      @destination.add(result)
    end
  end

  def all_our_ducks_are_in_a_row?
    # our resources use duck typing to get their work done, so do a quick up-front verification
    # that they will all work together. I prefer an up-front message about incompatibility to
    # an obscure method-missing error deep in the code.
    result = true
    @missing_source_methods = []
    @missing_converter_methods = []
    source = @sources.first
    @converter.methods_expected_of_source.each do |method|
      unless source.respond_to?(method)
        @missing_source_methods << method
        result = false
      end
    end
    converted = @converter.convert(source)
    @destination.methods_expected_of_converter.each do |method|
      unless converted.respond_to?(method)
        @missing_converter_methods << method
        result = false
      end
    end
    result
  end
  def ducks_not_aligned_message
    msg = []
    msg << "Conversion mismatch - the source and converter don't provide enough data for the destination"
    unless @missing_source_methods.empty?
      msg << "Missing source methods: #{@missing_source_methods.inspect}."
      msg << @sources.first.methods
    end
    unless @missing_converter_methods.empty?
      msg << "Missing converter methods: #{@missing_converter_methods.inspect}."
      msg << @converter.convert(@sources.first).methods
    end
    msg.join("\n")
  end
end
