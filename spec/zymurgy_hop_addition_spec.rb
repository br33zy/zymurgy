require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## A hop addition encapsulates the properties of a particular instance of a hop variety
## added to the boil at a particular time:
##    Alpha Acid level
##    Weight of Hops added
##    Boil Time (I.e. time that the hops are boiled for)
##
## and is influenced by the particular attributes of the home brewery that the brew
## will be brewed in; and the brew recipe itself.

describe "Zymurgy" do
  before do
    @brew = mock('A Brew')
  end

  # TODO: Actually perform hop bitterness calc. May have to pass in Brewery....
  describe "HopAddition" do
    describe "instantiating a Hop Addition object" do
      it "should reveal the alpha acid level, weight added, and boil time; but not Brew it was instantiated with" do
        alpha_acid_percentage = 7
        weight_grams = 30
        boil_time_minutes = 45
        hop_addition = Zymurgy::HopAddition.new(@brew, alpha_acid_percentage, weight_grams, boil_time_minutes)
        hop_addition.alpha_acid_percentage.should == 7
        hop_addition.weight_grams.should == 30
        hop_addition.boil_time_minutes.should == 45
      end
    end

    describe "calculating Hop utilisation" do
      before do
        alpha_acid_percentage = 7
        weight_grams = 30
        boil_time_minutes = 45
        @hop_addition = Zymurgy::HopAddition.new(@brew, alpha_acid_percentage, weight_grams, boil_time_minutes)
      end

      it "should calculate International Bitterness Units for the Hop Addition" do
        @hop_addition.IBU().should == 17.23
      end
    end
  end
end
