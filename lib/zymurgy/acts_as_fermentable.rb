module Zymurgy
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_fermentable(options = {})
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    def volume_gravity_points volume_litres
      maximum_volume_gravity_points = (send(:points_per_kg_per_litre) / volume_litres) * send(:weight_in_kg)

      return maximum_volume_gravity_points unless send(:mash)
      return maximum_volume_gravity_points * send(:mash_efficiency_percentage) / 100
    end

    def post_boil_volume_gravity_points
      volume_gravity_points(send(:post_boil_volume_litres))
    end

    def pre_boil_volume_gravity_points
      volume_gravity_points send(:mash_out_volume_litres)
    end

  end
end

ActiveRecord::Base.send :include, Zymurgy
