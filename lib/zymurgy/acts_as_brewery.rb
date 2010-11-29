module Zymurgy
  def self.included(base)
    base.send :extend, ClassMethods
  end

  # TODO: Not convinced we actually need an acts_as_brewery as yet. Maybe later.  
  # TODO: Provide options helper if attributes aren't as assumed.
  module ClassMethods
    def acts_as_brewery(options = {})
      send :include, InstanceMethods
    end
  end

  module InstanceMethods

    def add_litres_to_kettle_tax litres
      kettle_tax = send(:kettle_tax_litres) + litres
      send(:kettle_tax_litres=, kettle_tax)
    end
  end
end

ActiveRecord::Base.send :include, Zymurgy
