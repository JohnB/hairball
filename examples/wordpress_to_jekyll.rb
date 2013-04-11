require './hairball'
require './sources/wordpress_archive_files'
require './converters/html_to_textile'
require './destinations/jekyll_datestamped_blog_entries'

def usage
  puts "Usage: bundle exec ruby #{__FILE__} <source_dir> <dest_dir>"
  exit(-1)
end
usage unless ARGV.length >= 2

my_source_dir = ARGV[0]
dest_dir = ARGV[1]

Hairball.new( :sources => WordpressArchiveFiles.sources(my_source_dir),
              :converter => HtmlToTextile,
              :destination => JekyllDatestampedBlogEntries.new(dest_dir)
            ).convert
