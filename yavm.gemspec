require 'date'

Gem::Specification.new do |s|
  s.name         = 'YAVM'
  s.version      = '0.2.1'

  s.summary      = 'Yet Another Version Manager'
  s.description  = 'A tiny gem for managing project version numbers'
  s.homepage     = 'https://github.com/lewiseason/yavm'
  s.licenses     = ['GPLv2']

  s.authors      = ['Lewis Eason']
  s.email        = 'me@lewiseason.co.uk'
  s.date         = Date.today.to_s

  s.files        = Dir.glob('{bin,lib}/**/*') + %w(README.md)

  s.require_path = 'lib'
  s.executables  = ['version']

  s.test_files   = Dir.glob('features/**/*')

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency('docopt', ['>= 0.5.0', '~> 0.5.0'])
  s.add_dependency('json',   ['>= 1.8.0', '~> 1.8.1'])

  s.add_development_dependency('rubocop',  ['>= 0.28.0', '~> 0.28.0'])
  s.add_development_dependency('cucumber', ['>= 1.3.18', '~> 1.3.18'])
  s.add_development_dependency('aruba',    ['>= 0.6.2',  '~> 0.6.2'])
end
