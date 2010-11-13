module Zymurgy
  class Brew

    attr_reader :brewery, :original_gravity, :final_gravity, :fermentation_volume_litres, :boil_time_minutes
    attr_writer :original_gravity, :final_gravity, :fermentation_volume_litres, :boil_time_minutes

    DEFAULT_PARAMS = {
        'original_gravity' => 1043,
        'final_gravity' => 1008,
        'fermentation_volume_litres' => 19,
        'boil_time_minutes' => 60
    }
    
    def initialize brewery, params
      raise ArgumentError unless (brewery.class == 'Zymurgy::Brewery')
      @brewery                      = brewery
      @original_gravity             = params['original_gravity'] || DEFAULT_PARAMS['original_gravity']
      @final_gravity                = params['final_gravity'] || DEFAULT_PARAMS['final_gravity']
      @fermentation_volume_litres   = params['fermentation_volume_litres'] || DEFAULT_PARAMS['fermentation_volume_litres']
      @boil_time_minutes            = params['boil_time_minutes'] || DEFAULT_PARAMS['boil_time_minutes']
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
      1.65 * 0.000125**(@original_gravity/1000.0 - 1.0)
    end

    # ((original gravity - final gravity)/6.8)+0.2
    def alcohol_by_volume
      (@original_gravity - @final_gravity) / 6.8 + 0.2
    end

    private

    def boil_time_hours
      @boil_time_minutes / 60
    end
  end
end



