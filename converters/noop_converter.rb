class NoopConverter
  def methods_expected_of_source
    %w[year month day title]
  end

  def convert(source)
    source  # it should eventually do more, right?
  end
end
