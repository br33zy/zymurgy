$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'active_record'
require "zymurgy/acts_as_brewery"
require "zymurgy/acts_as_brew_recipe"

module Zymurgy

  autoload :Brewery,       "zymurgy/brewery"
  autoload :Brew,          "zymurgy/brew"
  autoload :Fermentable,   "zymurgy/fermentable"
  autoload :HopAddition,   "zymurgy/hop_addition"
  autoload :Utils,         "zymurgy/utils"
  autoload :ActsAsBrewery, "zymurgy/acts_as_brewery"

  ZymurgyError = Class.new(StandardError)

end
