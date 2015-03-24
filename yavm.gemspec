Gem::Specification.new do |s|
  s.name         = 'YAVM'
  s.version      = '0.4.0'

  s.summary      = 'Yet Another Version Manager'
  s.description  = 'A tiny gem for managing project version numbers'
  s.homepage     = 'https://github.com/lewiseason/yavm'
  s.licenses     = ['GPLv2']

  s.authors      = ['Lewis Eason']
  s.email        = 'me@lewiseason.co.uk'

  s.files        = Dir.glob('{bin,lib/yavm}/**/*') + %w(lib/yavm.rb README.md)

  s.require_path = 'lib'
  s.executables  = ['version']

  s.test_files   = Dir.glob('features/**/*')

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency 'docopt', '~> 0.5'

  s.add_development_dependency 'rake',      '~> 10.4'
  s.add_development_dependency 'rubocop',   '~> 0.28'
  s.add_development_dependency 'cucumber',  '~> 1.3'
  s.add_development_dependency 'aruba',     '~> 0.6'
  s.add_development_dependency 'simplecov', '~> 0.9'
end
