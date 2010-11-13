$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'zymurgy'
require 'spec'
require 'spec/autorun'

require 'spec/expectations'
require 'patches/float'

Spec::Runner.configure do |config|
  config.include Zymurgy::Utils

end
