$LOAD_PATH << File.dirname(__FILE__)

module Zymurgy

  autoload :Hop, "zymurgy/hop"
  autoload :Brewery, "zymurgy/brewery"
  autoload :Brew, "zymurgy/brew"

  ZymurgyError = Class.new(StandardError)

end
