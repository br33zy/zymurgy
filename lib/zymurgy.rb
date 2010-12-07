$LOAD_PATH << File.dirname(__FILE__)

require 'rubygems'
require 'active_record'
require "zymurgy/acts_as_brewery"
require "zymurgy/acts_as_brew_recipe"
require "zymurgy/acts_as_fermentable"
require "zymurgy/acts_as_hop_addition"

module Zymurgy

  autoload :Utils, "zymurgy/utils"

  ZymurgyError = Class.new(StandardError)

end
