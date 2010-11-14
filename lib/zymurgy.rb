$LOAD_PATH << File.dirname(__FILE__)

# TODO: Add Zymurgy::Fermentable class and calculations
module Zymurgy

  autoload :Brewery,     "zymurgy/brewery"
  autoload :Brew,        "zymurgy/brew"
  autoload :Fermentable, "zymurgy/fermentable"
  autoload :HopAddition, "zymurgy/hop_addition"
  autoload :Utils,       "zymurgy/utils"

  ZymurgyError = Class.new(StandardError)

end
