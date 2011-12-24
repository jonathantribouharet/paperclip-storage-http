# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
	s.files = `git ls-files`.split("\n")
	s.name = "paperclip-storage-http"
	s.platform = Gem::Platform::RUBY
	s.homepage = "https://github.com/eviljojo22/paperclip-storage-http"
	s.description = "HTTP storage support for paperclip."
	s.require_paths = ["lib"]
	s.summary = "HTTP storage support for paperclip"
	s.version = "1.0"
	s.author = "Jonathan TRIBOUHARET"
	s.email = "jonathan.tribouharet@gmail.com"
	
	s.add_runtime_dependency('paperclip')
	s.add_runtime_dependency('curb')
end