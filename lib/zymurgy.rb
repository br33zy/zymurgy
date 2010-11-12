$LOAD_PATH << File.dirname(__FILE__)

module Zymurgy

  autoload :Hop, "zymurgy/hop"

  ZymurgyError = Class.new(StandardError)

end
