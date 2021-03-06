Gem::Specification.new do |s|
  s.name         = 'YAVM'
  s.version      = '0.6.2'

  s.summary      = 'Yet Another Version Manager'
  s.description  = 'A tiny gem for managing project version numbers'
  s.homepage     = 'https://github.com/lewiseason/yavm'
  s.licenses     = ['GPLv2']

  s.authors      = ['Lewis Eason']
  s.email        = 'me@lewiseason.co.uk'

  s.files        = Dir.glob('{bin,lib/yavm}/**/*') + %w[lib/yavm.rb README.md]

  s.require_path = 'lib'
  s.executables  = ['version', 'git-versiontag']

  s.test_files   = Dir.glob('features/**/*')

  s.required_ruby_version = '>= 2.3.0'

  s.add_dependency 'docopt', '~> 0.5'
  s.add_dependency 'json'

  s.add_development_dependency 'aruba',     '~> 0.6'
  s.add_development_dependency 'cucumber',  '~> 1.3'
  s.add_development_dependency 'rake',      '~> 12.3'
  s.add_development_dependency 'simplecov', '~> 0.9'

  s.add_development_dependency 'rubocop',   '~> 0.51.0'
end
