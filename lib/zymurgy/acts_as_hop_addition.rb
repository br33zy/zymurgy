module Zymurgy
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_hop_addition(options = {})
      send :include, InstanceMethods
    end
  end

  module InstanceMethods

    # IBU = mg/l AA   *    time      *      bigness factor
    def IBU
      alpha_acid_mg_litre * time_factor * send(:bigness_factor)
    end

    private

    # mg/l AA        => ((AA/100) * weight_grams * 1000) / post_boil_volume
    def alpha_acid_mg_litre
      ((send(:alpha_acid_percentage)/100.0) * send(:weight_grams) * 1000.0) / send(:post_boil_volume_litres)
    end

    # time           => (1 - EXP((-0.04 * boil_time_minutes))) / 4.15
    def time_factor
      (1.0 - Math.exp((-0.04 * send(:boil_time_minutes)))) / 4.15
    end
  end
end

ActiveRecord::Base.send :include, Zymurgy
