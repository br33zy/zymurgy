module Zymurgy
  class Brew

    attr_reader :original_gravity, :fermentation_volume_litres, :boil_time_minutes

    def initialize brewery, original_gravity, fermentation_volume_litres, boil_time_minutes
      @brewery                      = brewery
      @original_gravity             = original_gravity
      @fermentation_volume_litres   = fermentation_volume_litres
      @boil_time_minutes            = boil_time_minutes         
    end

    # Mashout volume = Post Boil Volume + (Boil Time Minutes / 60) * evaporation_rate_litres_per_hour
    def mash_out_volume_litres
      post_boil_volume_litres + boil_time_hours * @brewery.evaporation_rate_litres_per_hour
    end

    # Mash In volume = Mash Out volume + (volume_lost_to_mash_litres_per_kg * weight of total grain bill)
    def mash_in_volume_litres weight_of_total_grain_bill_kg
      mash_out_volume_litres + @brewery.volume_lost_to_mash_litres_per_kg * weight_of_total_grain_bill_kg
    end

    def post_boil_volume_litres
      @fermentation_volume_litres + @brewery.kettle_tax_litres
    end

    # bigness factor => 1.65*(0.000125^((original_gravity/1000)-1))
    # round to 2dp
    def bigness_factor
      return 1.65 * 0.000125**(@original_gravity/1000.0 - 1.0)
    end

    private

    def boil_time_hours
      @boil_time_minutes / 60
    end
  end
end



