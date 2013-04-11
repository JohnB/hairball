# This file really has nothing to do with hairball.rb except to convert a single file html file to markdown.
require 'rubygems'
require 'html2markdown'

def usage
  puts "Usage: #{__FILE__} source_html_file"
  puts "       (output to STDOUT)"
  exit(-1)
end
usage unless ARGV.length >= 1

source_html_file = ARGV[0]
puts HTML2Markdown.new(IO.read(source_html_file)).to_s
