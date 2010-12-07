require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Confirm test schema is loaded correctly" do
  before do
    load_schema
  end

  class HopAddition < ActiveRecord::Base
  end

  it "should load test schema correctly" do
    HopAddition.all.should eql []
  end
end

describe "Can act_as_hop_addition" do
  before do
    load_schema
  end

  class Brew < ActiveRecord::Base
    acts_as_brew_recipe
    belongs_to :brewery
    has_many :fermentables

    def evaporation_rate_litres_per_hour
      self.brewery.evaporation_rate_litres_per_hour
    end

    def mash_efficiency_percentage
      self.brewery.mash_efficiency_percentage
    end

    def volume_lost_to_mash_litres_per_kg
      self.brewery.volume_lost_to_mash_litres_per_kg
    end

    def kettle_tax_litres
      self.brewery.kettle_tax_litres
    end
  end

  class Brewery < ActiveRecord::Base
    acts_as_brewery
    has_many :brews
  end

  class Fermentable < ActiveRecord::Base
    acts_as_fermentable
    belongs_to :brew

    def mash_out_volume_litres
      self.brew.mash_out_volume_litres
    end

    def post_boil_volume_litres
      self.brew.post_boil_volume_litres
    end

    def mash_efficiency_percentage
      self.brew.brewery.mash_efficiency_percentage
    end
  end

  class HopAddition < ActiveRecord::Base
    acts_as_hop_addition
    belongs_to :brew

    def post_boil_volume_litres
      self.brew.post_boil_volume_litres
    end

    def original_gravity
      self.brew.original_gravity
    end
  end

  describe "performing hop addition calculations" do
    before do
      @fermentable = Fermentable.new()
      @fermentable.mash=(true)
      @fermentable.points_per_kg_per_litre=(300)
      @fermentable.weight_in_kg=(5.24)

      @brew = Brew.new()
      @brew.original_gravity=(1045)
      @brew.final_gravity=(1012)
      @brew.fermentation_volume_litres=(25)
      @brew.boil_time_minutes=(60)

      @brewery = Brewery.new()
      @brewery.kettle_tax_litres=(2)
      @brewery.evaporation_rate_litres_per_hour=(11)
      @brewery.volume_lost_to_mash_litres_per_kg=(0.82)
      @brewery.mash_efficiency_percentage=(61)

      @hop_addition = HopAddition.new()
      @hop_addition.alpha_acid_percentage=(7.0)
      @hop_addition.weight_grams=(30)
      @hop_addition.boil_time_minutes=(45)

      @brew.brewery=(@brewery)

      @fermentable.brew=(@brew)
      @hop_addition.brew=(@brew)
    end

    # mg/l AA        => ((AA/100) * weight_grams * 1000) / post_boil_volume
    # time           => (1 - EXP((-0.04 * boil_time_minutes))) / 4.15
    # IBU = mg/l AA   *    time      *      bigness factor
    it "should calculate International Bitterness Units for the Hop Addition" do
      @hop_addition.IBU().round_dp(2).should == 17.23
    end

  end
end