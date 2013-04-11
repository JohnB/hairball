require 'rubygems'
require 'nokogiri'

class WordpressArchiveFiles
  attr_reader :year, :month, :day, :contents, :title

  def self.sources(source_dir)
    @@source_dir = source_dir
    sources = []
    year_format = File.join( File.expand_path(source_dir), '????')
    Dir.glob(year_format).select {|y| y =~ /\d\d\d\d$/ }.each do |path_with_year|
      month_format = File.join( path_with_year, '??' )
      Dir.glob(month_format).select {|m| m =~ /\d\d$/ }.each do |path_with_month|
        day_format = File.join( path_with_month, '??' )
        Dir.glob(day_format).select {|d| d =~ /\d\d$/ }.each do |path_with_day|
          Dir.entries(path_with_day).reject {|f| f =~ /^\./ }.each do |title|
            year, month, day = path_with_year[-4..-1], path_with_month[-2..-1], path_with_day[-2..-1]
            sources << self.new(File.join(path_with_day,title,'index.html'), year, month, day, title)
          end
        end
      end
    end
    return sources
  end

  def initialize(file, year, month, day, title)
    @file = file
    @year = year
    @month = month
    @day = day
    @title = title
    @contents = IO.read(@file)
    @contents = Nokogiri::HTML(@contents)
    @contents = @contents.at_xpath('//div[@id = "content"]')
    #puts @contents
  end
end
