module Zymurgy
  class Brewery

    attr_reader :efficiency_percentage, :evaporation_rate_litres_per_hour, :volume_lost_to_mash_litres_per_kg, :kettle_tax_litres

    def initialize efficiency_percentage, evaporation_rate_litres_per_hour, volume_lost_to_mash_litres_per_kg, kettle_tax_litres
      @efficiency_percentage               = efficiency_percentage
      @evaporation_rate_litres_per_hour    = evaporation_rate_litres_per_hour
      @volume_lost_to_mash_litres_per_kg   = volume_lost_to_mash_litres_per_kg
      @kettle_tax_litres                   = kettle_tax_litres
    end
  end
end