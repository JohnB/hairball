class JekyllDatestampedBlogEntries
  def initialize(dest_dir)
    @dest_dir = dest_dir
  end
  def methods_expected_of_converter
    %w[year month day title contents]
  end

  def add(converter)
    dest_filename = [converter.year, converter.month, converter.day, converter.title+'.textile'].join('-')
    dest_fullpath = File.join(@dest_dir,dest_filename)
    content = textile_format(converter)
    puts "Writing #{dest_fullpath}"
    #File.delete(dest_fullpath)
    File.open(dest_fullpath,'w') { |f| f.write(content) }
  end

  def textile_format(converter)
    markdown_content = converter.contents.to_s
    page = [
        "---",
        "layout: default",
        "title: #{converter.title}",
        "---",
        "",
        '<div id="page">',
        markdown_content,
        "</div>",
        "",
    ].join("\n")
    page
  end
end
