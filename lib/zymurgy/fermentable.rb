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
  end
end