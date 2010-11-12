$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'zymurgy'
require 'spec'
require 'spec/autorun'

require 'spec/expectations'

Spec::Runner.configure do |config|
  
end
