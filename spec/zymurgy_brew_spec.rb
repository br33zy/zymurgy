require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## A brew encapsulates the properties of a particular brewing recipe:
##    Original Gravity
##    Fermentation Volume
##    Boil Time
##
## and is influenced by the particular attributes of the home brewery that the brew
## will be brewed in.

describe "Zymurgy" do
  before do
    @brewery = mock('A Brewery')
    @brewery.stub!('class').and_return('Zymurgy::Brewery')
    @brewery.stub!('kettle_tax_litres').and_return(2)
    @brewery.stub!('evaporation_rate_litres_per_hour').and_return(11)
    @brewery.stub!('volume_lost_to_mash_litres_per_kg').and_return(0.82)

    @params = {
        'original_gravity' => 1045,
        'fermentation_volume_litres' => 25,
        'boil_time_minutes' => 60
    }
  end

  # TODO: Move to accessors rather than just readers. Should be able to instantiate an empty brew.
  # TODO: Add Final Gravity attribute
  describe "Brew" do
    describe "instantiating a Brew" do
      it "should provide readers for the Brewery and parameters it is instantiated with" do
        brew = Zymurgy::Brew.new(@brewery, @params)
        brew.brewery.kettle_tax_litres.should == 2
        brew.original_gravity.should == 1045
        brew.original_gravity=(1000).should == 1000
        brew.fermentation_volume_litres.should == 25
        brew.boil_time_minutes.should == 60
      end

      it "should provide writers for the parameters it is instantiated with" do
        brew = Zymurgy::Brew.new(@brewery, @params)
        brew.should_not respond_to(:brewery=)
        brew.should respond_to(:original_gravity=)
        brew.should respond_to(:fermentation_volume_litres=)
        brew.should respond_to(:boil_time_minutes=)
      end

      it "should complain if not provided with a valid Zymurgy::Brewery object" do
        lambda {Zymurgy::Brew.new('not a brewery', @params)}.should raise_error()
      end

      it "should accept an empty set of parameters as long as a valid Zymurgy::Brewery object is provided" do
        brew = Zymurgy::Brew.new(@brewery, {})
        brew.brewery.kettle_tax_litres.should == 2
        brew.original_gravity.should == nil
        brew.fermentation_volume_litres.should == nil
        brew.boil_time_minutes.should == nil
      end
    end

    describe "performing brew calculations" do
      before do
        params = {
            'original_gravity' => 1045,
            'fermentation_volume_litres' => 25,
            'boil_time_minutes' => 60
        }
        @brew = Zymurgy::Brew.new(@brewery, params)
      end
      
      it "should calculate the post boil volume" do
        @brew.post_boil_volume_litres.should == 27
      end

      it "should calculate the bigness factor used for hop utilisation calculations" do
        @brew.bigness_factor.round_dp(1).should == 1.1
      end

      # Mashout volume = Post Boil Volume + (Boil Time Minutes / 60) * evaporation_rate_litres_per_hour
      it "should calculate the Mash Out volume given the weight of the total grain bill" do
        @brew.mash_out_volume_litres.should == 38
      end

      # Mash In volume = Mash Out volume + (volume_lost_to_mash_litres_per_kg * weight of total grain bill)
      it "should calculate the Mash In volume given the weight of the total grain bill" do
        @brew.mash_in_volume_litres(6.52).round_dp(2).should == 43.35
      end
    end
  end
end
