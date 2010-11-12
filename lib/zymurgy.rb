$LOAD_PATH << File.dirname(__FILE__)

module Zymurgy

  autoload :HopAddition, "zymurgy/hop_addition"
  autoload :Brewery, "zymurgy/brewery"
  autoload :Brew, "zymurgy/brew"

  ZymurgyError = Class.new(StandardError)

end
