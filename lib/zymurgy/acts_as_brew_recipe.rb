module Zymurgy
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_brew_recipe(options = {})
      send :include, InstanceMethods
    end
  end

  module InstanceMethods

    # bigness factor => 1.65*(0.000125^((original_gravity/1000)-1))
    # round to 2dp
    def bigness_factor
      1.65 * 0.000125**(send(:original_gravity)/1000.0 - 1.0)
    end

    # ((original gravity - final gravity)/6.8)+0.2
    def alcohol_by_volume
      (send(:original_gravity) - send(:final_gravity)) / 6.8 + 0.2
    end

    def post_boil_volume_litres
      send(:fermentation_volume_litres) + send(:kettle_tax_litres)
    end

    # Mashout volume = Post Boil Volume + (Boil Time Minutes / 60) * evaporation_rate_litres_per_hour
    def mash_out_volume_litres
      post_boil_volume_litres() + boil_time_hours() * send(:evaporation_rate_litres_per_hour)
    end

    # Mash In volume = Mash Out volume + (volume_lost_to_mash_litres_per_kg * weight of total grain bill)
    def mash_in_volume_litres weight_of_total_grain_bill_kg
      mash_out_volume_litres + send(:volume_lost_to_mash_litres_per_kg) * weight_of_total_grain_bill_kg
    end

    # TODO: Alias this?
    def pre_boil_volume_litres
      mash_out_volume_litres
    end

    private

    def boil_time_hours
      send(:boil_time_minutes) / 60.0
    end
  end
end

ActiveRecord::Base.send :include, Zymurgy
