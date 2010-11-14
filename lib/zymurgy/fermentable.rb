module Zymurgy
  class Fermentable

    attr_reader :brew, :mash, :points_per_kg_per_litre, :weight_in_kg
    attr_writer :mash, :points_per_kg_per_litre, :weight_in_kg

    DEFAULT = {
        'mash' => false,
        'points_per_kg_per_litre' => 300,
        'weight_in_kg' => 1.7,
    }

    def initialize brew, params = {}
      raise ArgumentError unless (brew.class == 'Zymurgy::Brew')
      @brew = brew
      @mash = params['mash'] || DEFAULT['mash']
      @points_per_kg_per_litre = params['points_per_kg_per_litre'] || DEFAULT['points_per_kg_per_litre']
      @weight_in_kg = params['weight_in_kg'] || DEFAULT['weight_in_kg']
    end

    def volume_gravity_points volume_litres
      (@points_per_kg_per_litre / volume_litres) * @weight_in_kg * @brew.brewery.efficiency_percentage / 100      
    end

    def post_boil_volume_gravity_points
      volume_gravity_points @brew.post_boil_volume_litres
    end

    def pre_boil_volume_gravity_points
      volume_gravity_points @brew.mash_out_volume_litres
    end
  end
end