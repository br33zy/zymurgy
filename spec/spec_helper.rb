$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'zymurgy'
require 'spec'
require 'spec/autorun'

require 'spec/expectations'
require 'patches/float'

Spec::Runner.configure do |config|
  config.include Zymurgy::Utils

end
#require 'active_support'
require 'active_record'


def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.establish_connection(config['mysql'])
  load(File.dirname(__FILE__) + "/schema.rb")
end
