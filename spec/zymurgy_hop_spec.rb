require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

## As a beer brewing recipe application I would like to use the Zymurgy gem to
## perform zymurgical calculations so that I don't have to include complicated
## esoteric logic in my codebase.

describe "Zymurgy" do

  describe "Hop" do
    describe "instantiating a Hop object" do
      # TODO: Get more information on what 'bigness' factor is.
      # TODO: Factor out a new Brew class to encapsulate bigness factor, starting gravity and boil time
      it "should reveal the 'bigness' factor and the hop's alpha acid level it was instantiated with" do
        alpha_acid_percentage = 10
        bigness_factor = 2
        hop = Zymurgy::Hop.new(alpha_acid_percentage, bigness_factor)
        hop.alpha_acid_percentage.should == 10
        hop.bigness_factor.should == 2
      end

      it "should reveal a default 'bigness' factor of 1.65 if instantiated without a bigness factor" do
        alpha_acid_percentage = 10
        hop = Zymurgy::Hop.new(alpha_acid_percentage)
        hop.alpha_acid_percentage.should == 10
        hop.bigness_factor.should == 1.65
      end
    end

    describe "calculating Hop utilisation" do
      before do
        alpha_acid_percentage = 7
        bigness_factor = 1.65
        @hop = Zymurgy::Hop.new(alpha_acid_percentage, bigness_factor)
      end

      it "should calculate International Bitterness Units for the Hop as a function of the brew's starting gravity, boil time in minutes, and the weight in grams of hops" do
        starting_gravity = 1045
        boil_time_minutes = 45
        weight_grams = 30
        @hop.IBU(starting_gravity, boil_time_minutes, weight_grams).should == 17.23
      end
    end
  end
end
