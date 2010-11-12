module Zymurgy
  class Brew

    attr_reader :original_gravity, :fermentation_volume_litres, :boil_time_minutes

    def initialize original_gravity, fermentation_volume_litres, boil_time_minutes
      @original_gravity             = original_gravity
      @fermentation_volume_litres   = fermentation_volume_litres
      @boil_time_minutes            = boil_time_minutes         
    end
  end
end



