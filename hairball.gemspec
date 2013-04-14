# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["John Baylor"]
  gem.email         = ["john.baylor@gmail.com"]
  gem.summary       = "A tool for blog or wiki conversion."
  gem.description   = "A tool for blog or wiki conversion - will probably not meet your specific needs without modifications."
  gem.homepage      = "https://github.com/JohnB/hairball"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = []
  gem.test_files    = []
  gem.name          = "hairball"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_dependency ["nokogiri", "html2markdown"]

end
