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
    @brewery.stub!('kettle_tax_litres').and_return(2)
  end

  describe "Brew" do
    describe "instantiating a Brew" do
      it "should reveal the Original Gravity, Fermentation Volume and Boil Time; but not Brewery it was instantiated with" do
        original_gravity = 1045
        fermentation_volume_litres = 25
        boil_time_minutes = 60
        brew = Zymurgy::Brew.new(@brewery, original_gravity, fermentation_volume_litres, boil_time_minutes)
        brew.original_gravity.should == 1045
        brew.fermentation_volume_litres.should == 25
        brew.boil_time_minutes.should == 60
      end
    end

    describe "performing brew calculations" do
      before do
        original_gravity = 1045
        fermentation_volume_litres = 25
        boil_time_minutes = 60
        @brew = Zymurgy::Brew.new(@brewery, original_gravity, fermentation_volume_litres, boil_time_minutes)
      end
      it "should calculate the post boil volume" do
        @brew.post_boil_volume_litres.should == 23
      end

      it "should calculate the bigness factor used for hop utilisation calculations" do
        @brew.bigness_factor.round_dp(1).should == 1.1
      end
    end
  end
end
