require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## A brew encapsulates the properties of a particular brewing recipe:
##    Original Gravity
##    Fermentation Volume
##    Boil Time

describe "Zymurgy" do

  describe "Brew" do
    describe "instantiating a Brew" do
      it "should reveal the Original Gravity, Fermentation Volume and Boil Time it was instantiated with" do
        original_gravity = 1045
        fermentation_volume_litres = 25
        boil_time_minutes = 60
        brew = Zymurgy::Brew.new(original_gravity, fermentation_volume_litres, boil_time_minutes)
        brew.original_gravity.should == 1045
        brew.fermentation_volume_litres.should == 25
        brew.boil_time_minutes.should == 60
      end
    end

    describe "calculating Post Boil volume" do
#      before do
#        alpha_acid_percentage = 7
#        bigness_factor = 1.65
#        @hop = Zymurgy::Hop.new(alpha_acid_percentage, bigness_factor)
#      end
#
#      it "should calculate International Bitterness Units for the Hop as a function of the brew's starting gravity, boil time in minutes, and the weight in grams of hops" do
#        starting_gravity = 1045
#        boil_time_minutes = 45
#        weight_grams = 30
#        @hop.IBU(starting_gravity, boil_time_minutes, weight_grams).should == 17.23
#      end
    end
  end
end
