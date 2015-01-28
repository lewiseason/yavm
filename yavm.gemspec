Gem::Specification.new do |s|
  s.name         = 'YAVM'
  s.version      = '0.1.1'

  s.summary      = 'Yet Another Version Manager'
  s.description  = 'A tiny gem for managing project version numbers'
  s.homepage     = 'https://github.com/lewiseason/yavm'
  s.licenses     = ['GPLv2']

  s.authors      = ['Lewis Eason']
  s.email        = 'me@lewiseason.co.uk'
  s.date         = '2014-01-27'

  s.require_path = 'lib'
  s.executables  = ['version']
  s.files = Dir.glob('{bin,lib}/**/*') + %w(README.md)

  s.add_dependency('docopt', ['>= 0.5.0', '~> 0.5.0'])
  s.add_dependency('json', ['>= 1.8.0', '~> 1.8.1'])

  s.add_development_dependency('rubocop')
end
