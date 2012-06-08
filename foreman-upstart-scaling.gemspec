Gem::Specification.new do |s|
  s.name = "foreman-upstart-scaling"
  s.email = "fabio.kung@gmail.com"
  s.version = "0.3"
  s.description = "Upstart exporter for foreman, that supports worker scaling via env vars."
  s.summary = "Upstart configuration generator for foreman"
  s.authors = ["Fabio Kung"]
  s.homepage = "http://github.com/fabiokung/foreman-upstart-scaling"

  s.files = Dir["lib/**/*.rb"] + Dir["data/**/*.erb"]
  s.require_paths = ["lib"]
  s.add_dependency "foreman", ">= 0.46.0"
end

