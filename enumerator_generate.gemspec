Gem::Specification.new do |s|
  s.name     = 'enumerator_generate'
  s.version  = '0.0.1'
  s.authors  = ['Victor Shepelev']
  s.email    = 'zverok.offline@gmail.com'
  s.homepage = 'https://github.com/zverok/enumerator_generate'

  s.summary = 'Enumerator#generate: Simple infinite enumerators'
  s.description = <<-EOF
    This is just a showcase gem to support language core proposal.
  EOF
  s.licenses = ['MIT']

  s.files = `git ls-files lib LICENSE.txt *.md *.rb`.split($RS)
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 2.2.0' # in 2.1, MiniTest/TestUnit behaves weird

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubygems-tasks'
end