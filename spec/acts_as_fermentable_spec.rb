require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Confirm test schema is loaded correctly" do
  before do
    load_schema
  end

  class Fermentable < ActiveRecord::Base
  end

  it "should load test schema correctly" do
    Fermentable.all.should eql []
  end
end

describe "Can act_as_fermentable" do
  before do
    load_schema
  end

  class Brew < ActiveRecord::Base
    acts_as_brew_recipe
    belongs_to :brewery
    has_many :fermentables

    def evaporation_rate_litres_per_hour
      @brewery.evaporation_rate_litres_per_hour
    end

    def mash_efficiency_percentage
      @brewery.mash_efficiency_percentage
    end

    def volume_lost_to_mash_litres_per_kg
      @brewery.volume_lost_to_mash_litres_per_kg
    end

    def kettle_tax_litres
      @brewery.kettle_tax_litres
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
      @brew.mash_out_volume_litres
    end

    def post_boil_volume_litres
      @brew.post_boil_volume_litres
    end

    def mash_efficiency_percentage
      @brew.brewery.mash_efficiency_percentage
    end
  end

  describe "performing brew fermentable calculations" do
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

      @brew.brewery=(@brewery)

      @fermentable.brew=(@brew)
    end

    describe "for mashed fermentables, thus factoring in brewery mash efficiency" do
      it "should calculate the gravity points contributed towards the post boil volume" do
        @fermentable.post_boil_volume_gravity_points.round_dp(2).should == 35.52
      end

      it "should calculate the gravity points contributed towards the mash out/pre boil volume" do
        @fermentable.pre_boil_volume_gravity_points.round_dp(2).should == 25.23
      end

      it "should calculate the gravity points contributed towards a given volume" do
        @fermentable.volume_gravity_points(38).round_dp(2).should == 25.23
      end
    end

    describe "for fermentables (such as cans of goop) which aren't mashed, thus ignoring brewery mash efficiency" do
      before do
        @fermentable.mash=(false)
        @fermentable.points_per_kg_per_litre=(300)
        @fermentable.weight_in_kg=(1.7)
      end

      it "should calculate the gravity points contributed towards the post boil volume" do
        @fermentable.post_boil_volume_gravity_points.round_dp(2).should == 18.89
      end

      it "should calculate the gravity points contributed towards the pre boil volume" do
        @fermentable.pre_boil_volume_gravity_points.round_dp(2).should == 13.42
      end

      it "should calculate the gravity points contributed towards a given volume" do
        @fermentable.volume_gravity_points(25).round_dp(2).should == 20.40
      end
    end
  end
end