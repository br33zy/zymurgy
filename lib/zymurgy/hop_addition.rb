module Zymurgy
  class HopAddition

    attr_reader :alpha_acid_percentage, :weight_grams, :boil_time_minutes, :IBU

    def initialize brew, alpha_acid_percentage, weight_grams, boil_time_minutes
      @brew                  = brew
      @alpha_acid_percentage = alpha_acid_percentage
      @weight_grams          = weight_grams
      @boil_time_minutes     = boil_time_minutes
      @IBU                   = calculate_international_bitterness_units()
    end

    private

    # mg/l AA        => ((AA/100) * weight_grams * 1000) / post_boil_volume
    def alpha_acid_mg_litre
      alpha_acid_mg_litre = (@alpha_acid_percentage/100.0 * @weight_grams * 1000.0) / @brew.post_boil_volume()
      return alpha_acid_mg_litre
    end

    # time           => (1 - EXP((-0.04 * boil_time_minutes))) / 4.15
    def time_factor
      time_factor = (1.0 - Math.exp((-0.04 * @brew.boil_time_minutes()))) / 4.15
      return time_factor
    end

    # IBU = mg/l AA   *    time      *      bigness factor
    def calculate_international_bitterness_units
      alpha_acid_mg_litre * time_factor * @brew.bigness_factor
    end
  end
end
