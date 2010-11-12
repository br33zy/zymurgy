module Zymurgy
  class Hop

    attr_reader :alpha_acid_percentage, :bigness_factor

    def initialize alpha_acid_percentage, bigness_factor = 1.65
      @alpha_acid_percentage = alpha_acid_percentage
      @bigness_factor = bigness_factor
    end
  end
end