guard 'bundler' do
  watch('Gemfile')
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|md|builder|jbuilder)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end

guard 'shell' do
  watch(/^(app|lib|spec)\/(.*)\.rb/) {|m| `ctags -R .` }
  watch(/^.env/) { |m| `source $PWD/.env` }
end

guard 'rails' do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
  watch(/^.env/)
end

guard 'minitest' do
  watch(%r|^test/(.*)\/?test_(.*)\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)      { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_helper\.rb|)     { "test" }
  watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/functional/#{m[1]}_test.rb" }
  watch(%r|^app/helpers/(.*)\.rb|)     { |m| "test/helpers/#{m[1]}_test.rb" }
  watch(%r|^app/models/(.*)\.rb|)      { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r|^app/decorators/(.*)\.rb|)  { |m| "test/unit/decorators/#{m[1]}_test.rb" }
end
