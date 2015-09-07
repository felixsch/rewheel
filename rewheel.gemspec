lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib + 'core/')

Gem::Specification.new do |spec|
    spec.name          = "rewheel"
    spec.version       = '1.0'
    spec.authors       = ["Felix Schnizlein"]
    spec.email         = ["felix@none.io"]
    spec.summary       = %q{rewheel irc bot}
    spec.description   = %q{just another irc bot project}
    spec.homepage      = "http://github.com/felixsch/rewheel"
    spec.license       = "MIT"
    spec.files         = Dir['{bin,lib}/**/*']
    spec.executables   = ['bin/rewheel.rb']
    spec.test_files    = ['tests/test_message.rb']
end
