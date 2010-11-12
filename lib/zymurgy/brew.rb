module Zymurgy
  class Brew

    attr_reader :original_gravity, :fermentation_volume_litres, :boil_time_minutes

    def initialize brew, original_gravity, fermentation_volume_litres, boil_time_minutes
      @brew                         = brew
      @original_gravity             = original_gravity
      @fermentation_volume_litres   = fermentation_volume_litres
      @boil_time_minutes            = boil_time_minutes         
    end
  end
end



