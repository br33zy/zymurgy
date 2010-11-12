module Zymurgy
  class Brew

    attr_reader :original_gravity, :fermentation_volume_litres, :boil_time_minutes

    def initialize brewery, original_gravity, fermentation_volume_litres, boil_time_minutes
      @brewery                      = brewery
      @original_gravity             = original_gravity
      @fermentation_volume_litres   = fermentation_volume_litres
      @boil_time_minutes            = boil_time_minutes         
    end

    def post_boil_volume_litres
      @fermentation_volume_litres - @brewery.kettle_tax_litres
    end
  end
end



