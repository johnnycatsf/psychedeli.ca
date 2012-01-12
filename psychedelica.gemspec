Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'psychedelica'
  s.version           = '0.11.2'
  s.date              = '2012-01-11'
  s.rubyforge_project = 'psychedelica'

  s.summary     = "A blog powered by Jekyll that runs on Rack and compiles just in time."
  s.description = "A blog powered by Jekyll that runs on Rack and compiles just in time."

  s.authors  = ["Tom Scott"]
  s.email    = 'tubbo@psychedeli.ca'
  s.homepage = 'http://psychedeli.ca'

  s.require_paths = %w[lib]

  s.executables = ["synth"]

  # s.rdoc_options = ["--charset=UTF-8"]
  # s.extra_rdoc_files = %w[README.textile LICENSE]

  s.add_runtime_dependency('rack', "~> 1.3")
  s.add_runtime_dependency('rack-contrib', "~> 1.3")
  s.add_runtime_dependency('jekyll', "~> 0.11")
  s.add_runtime_dependency('sprockets', "~> 2.0")
  s.add_runtime_dependency('liquid', "~> 2.2.2")
  s.add_runtime_dependency('sass', "~> 2.0")
  s.add_runtime_dependency('compass', "~> 2.0")
  s.add_runtime_dependency('redcarpet', "~> 2.0")
  s.add_runtime_dependency('yajl-ruby', "~> 1.0")
  s.add_runtime_dependency('twitter', "~> 1.0")
  s.add_runtime_dependency('mogli', "~> 1.0")
end
