module Zymurgy
  class HopAddition

    attr_reader :alpha_acid_percentage, :weight_grams, :boil_time_minutes

    def initialize brew, alpha_acid_percentage, weight_grams, boil_time_minutes
      @brew                  = brew
      @alpha_acid_percentage = alpha_acid_percentage
      @weight_grams          = weight_grams
      @boil_time_minutes     = boil_time_minutes
    end

    def IBU
      17.23
    end
  end
end
