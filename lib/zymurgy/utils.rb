module Zymurgy
  module Utils

    def litres_2_us_gallons litres
      litres / 3.78541178
    end

    def us_gallons_2_litres gallons
      gallons * 3.78541178
    end

    def kilograms_2_pounds kilograms
      kilograms * 2.2
    end

    def pounds_2_kilograms pounds
      pounds / 2.2
    end

    def kilograms_2_ounces kilograms
      kilograms / 0.0283495231
    end

    def ounces_2_kilograms ounces
      ounces * 0.0283495231
    end

    def celsius_2_fahrenheit degrees_celsius
      32.0 + degrees_celsius / (5.0/9.0)
    end

    def fahrenheit_2_celsius degrees_fahrenheit
      (5.0/9.0) * (degrees_fahrenheit - 32.0)
    end

    def pkgl_2_ppg pkgl
      litres_2_us_gallons(pounds_2_kilograms(pkgl))
    end

    def ppg_2_pkgl ppg
      us_gallons_2_litres(kilograms_2_pounds(ppg))
    end
  end
end


