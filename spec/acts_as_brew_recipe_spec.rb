require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Confirm test schema is loaded correctly" do
  before do
    load_schema
  end

  class Brew < ActiveRecord::Base
  end

  it "should load test schema correctly" do
    Brew.all.should eql []
  end
end

describe "Can act_as_brew_recipe" do
  before do
    load_schema
  end

  class Brew < ActiveRecord::Base
    acts_as_brew_recipe
    belongs_to :brewery

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

  describe "performing brew recipe calculations" do
    before do
      @brew = Brew.new()
      @brew.original_gravity=(1045)
      @brew.final_gravity=(1012)
      @brew.fermentation_volume_litres=(25)
      @brew.boil_time_minutes=(60)

      @brewery = Brewery.new()
      @brewery.kettle_tax_litres=(2)
      @brewery.evaporation_rate_litres_per_hour=(11)
      @brewery.volume_lost_to_mash_litres_per_kg=(0.82)

      @brew.brewery=(@brewery)
    end

    it "should calculate the post boil volume" do
      @brew.post_boil_volume_litres.should == 27
    end

    # Mashout volume = Post Boil Volume + (Boil Time Minutes / 60) * evaporation_rate_litres_per_hour
    it "should calculate the Mash Out/Pre Boil volume given the weight of the total grain bill" do
      @brew.mash_out_volume_litres.should == 38
      @brew.pre_boil_volume_litres.should == 38
    end

    # Mash In volume = Mash Out volume + (volume_lost_to_mash_litres_per_kg * weight of total grain bill)
    it "should calculate the Mash In volume given the weight of the total grain bill" do
      @brew.mash_in_volume_litres(6.52).round_dp(2).should == 43.35
    end
    
    it "should calculate the bigness factor used for hop utilisation calculations" do
      @brew.bigness_factor.round_dp(1).should == 1.1
    end

    it "should calculate the Alcohol By Volume percentage for the completed brew" do
      @brew.alcohol_by_volume.round_dp(2).should == 5.05
    end
    
  end
end